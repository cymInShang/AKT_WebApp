//
//  PFHttpManager.h
//  PFDoctors
//
//  Created by K.E. on 2019/7/22.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

// 网络请求方法
typedef enum {
    HttpRequestMethodPOST,  // 增
    HttpRequestMethodGET,   // 查
    HttpRequestMethodPUT,   // 改
    HttpRequestMethodDELETE // 删
} HttpRequestMethod;

NS_ASSUME_NONNULL_BEGIN

@interface PFHttpManager : NSObject

@property (assign, nonatomic) HttpRequestMethod method;

//获取request单例
+ (instancetype)sharedHttpManager;

- (NSURLSessionTask *)request:(NSString *)methodName parameters:(id)parameters fileData:(nullable NSData *)data hud:(nullable NSString *)hud success:(void (^)(id))success failure:(void (^)(NSError *error))failure;

- (NSURLSessionTask *)payment:(NSString *)methodName parameters:(id)parameters hud:(nullable NSString *)hud success:(void (^)(id))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
