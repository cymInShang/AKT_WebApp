//
//  PFHttpManager.m
//  PFDoctors
//
//  Created by K.E. on 2019/7/22.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "PFHttpManager.h"

@interface PFHttpManager (){
    AFHTTPSessionManager *manager;
}
@end

@implementation PFHttpManager

+ (instancetype)sharedHttpManager{
    static dispatch_once_t onceToken;
    static PFHttpManager *manager = nil;
    dispatch_once(&onceToken, ^{ manager = [[PFHttpManager alloc]init]; });
    return manager;
}

#pragma mark - init request
- (id)init {
    if (self = [super init]) {
        manager = [AFHTTPSessionManager manager];//超时默认60秒
        manager.requestSerializer.timeoutInterval = 10.0;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//发送json
        manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回二进制  默认返回json
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    return self;
}

#pragma mark - request  get post put delete
- (NSURLSessionTask *)request:(NSString *)methodName parameters:(id)parameters fileData:(NSData *)data hud:(NSString *)hud success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    if (!hud) [[AppDelegate sharedDelegate] showLoadingHUD:nil msg:hud];
    NSLog(@"%@ %@",kRequestURL(methodName),parameters);
    NSURLSessionTask *task;
    if (data) task = [self uploadMethod:kRequestURL(methodName) parameters:parameters fileData:data success:success failure:failure];
    else if (self.method == HttpRequestMethodGET) task = [self requestGetMethod:kRequestURL(methodName) parameters:parameters success:success failure:failure];
    else if (self.method == HttpRequestMethodPUT) task = [self requestPutMethod:kRequestURL(methodName) parameters:parameters success:success failure:failure];
    else if (self.method == HttpRequestMethodDELETE) task = [self requestDeleteMethod:kRequestURL(methodName) parameters:parameters success:success failure:failure];
    else task = [self requestPostMethod:kRequestURL(methodName) parameters:parameters success:success failure:failure];
    if (task)  [task resume];   // 启动任务
    return task;
}

- (NSURLSessionTask *)payment:(NSString *)methodName parameters:(id)parameters hud:(NSString *)hud success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    if (!hud) [[AppDelegate sharedDelegate] showLoadingHUD:nil msg:hud];
    NSLog(@"%@ %@",kRequestURL(methodName),parameters);
    NSURLSessionTask *task;
    if (self.method == HttpRequestMethodGET) task = [self requestGetMethod:kPaymentURL(methodName) parameters:parameters success:success failure:failure];
    else if (self.method == HttpRequestMethodPUT) task = [self requestPutMethod:kPaymentURL(methodName) parameters:parameters success:success failure:failure];
    else if (self.method == HttpRequestMethodDELETE) task = [self requestDeleteMethod:kPaymentURL(methodName) parameters:parameters success:success failure:failure];
    else task = [self requestPostMethod:kPaymentURL(methodName) parameters:parameters success:success failure:failure];
    if (task)  [task resume];   // 启动任务
    return task;
}


#pragma mark - method  get post put delete
- (NSURLSessionTask *)requestGetMethod:(NSString *)_url parameters:(id)_parameters success:(void (^)(id))success failure:(void (^)(NSError *error))failure{
    return [manager GET:_url parameters:_parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObj){
        [self doOptionResponseAction:task response:responseObj success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        [self doInterceptError:error task:task failure:failure];
    }];
}

- (NSURLSessionTask *)requestPostMethod:(NSString *)_url parameters:(id)_parameters success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    return [manager POST:_url parameters:_parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObj){
        [self doOptionResponseAction:task response:responseObj success:success failure:failure];
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        [self doInterceptError:error task:task failure:failure];
    }];
}

- (NSURLSessionTask *)requestPutMethod:(NSString *)_url parameters:(id)_parameters success:(void (^)(id))success failure:(void (^)(NSError *error))failure{
    return [manager PUT:_url parameters:_parameters success:^(NSURLSessionDataTask *task, id responseObj) {
        [self doOptionResponseAction:task response:responseObj success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self doInterceptError:error task:task failure:failure];
    }];
}

- (NSURLSessionTask *)requestDeleteMethod:(NSString *)_url parameters:(id)_parameters success:(void (^)(id))success failure:(void (^)(NSError *error))failure{
    return [manager DELETE:_url parameters:_parameters success:^(NSURLSessionDataTask *task, id responseObj) {
        [self doOptionResponseAction:task response:responseObj success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self doInterceptError:error task:task failure:failure];
    }];
}

#pragma mark - method post file
- (NSURLSessionTask *)uploadMethod:(NSString *)_url parameters:(id)_parameters fileData:(NSData *)data success:(void (^)(id))success failure:(void (^)(NSError *error))failure{
    return [manager POST:_url parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:_parameters[@"key"] fileName:@"card.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObj){
        [self doOptionResponseAction:task response:responseObj success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        [self doInterceptError:error task:task failure:failure];
    }];
}

#pragma mark - back info
- (void)doOptionResponseAction:(NSURLSessionDataTask *)task response:(NSDictionary *)responseObj success:(void (^)(id))success failure:(void (^)(NSError *error))failure{
    [[AppDelegate sharedDelegate] hidHUD];
    NSLog(@"%@\nresponse : %@",task.response.URL.absoluteString,responseObj);
    NSInteger code = [[responseObj objectForKey:@"success"] integerValue];
    if (code == 1)
        success(responseObj[@"result"]);
    else {
        NSString *msg = [NSString stringWithFormat:@"错误${%ld}，请稍后重试",(long)code];
        if ([responseObj objectForKey:@"info"] && ![kString([responseObj objectForKey:@"info"]) isEqual:@""])
            msg = [responseObj objectForKey:@"info"];
        NSError *error = [NSError errorWithDomain:msg code:code userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
        failure(error);
    }
}

- (void)doInterceptError:(NSError *)error task:(NSURLSessionDataTask *)task failure:(void (^)(NSError *error))failure{
    [[AppDelegate sharedDelegate] hidHUD];
    NSLog(@"%@\nError info: %@",task.response.URL.absoluteString,error.localizedDescription);
    failure(error);
}

@end
