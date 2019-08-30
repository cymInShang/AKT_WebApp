//
//  PFBaseCmd.m
//  PFDoctors
//
//  Created by K.E. on 2019/7/22.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "PFBaseCmd.h"

@implementation PFBaseCmd

- (id)init{
    self = [super init];
    if (self) {
        self.hud = @"";
        self.isPayment = false;
    }
    return self;
}

- (void)doGetRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(void(^)(id))fail{
    [[PFHttpManager sharedHttpManager] setMethod:HttpRequestMethodGET];
    [self doRequestWithParameters:parameters success:succ failure:fail];
}

- (void)doPostRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(void(^)(id))fail{
    [[PFHttpManager sharedHttpManager] setMethod:HttpRequestMethodPOST];
//    [self doRequestWithParameters:@{@"result":parameters} success:succ failure:fail];
    [self doRequestWithParameters:parameters success:succ failure:fail];
}

- (void)doPutRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(void(^)(id))fail{
    [[PFHttpManager sharedHttpManager] setMethod:HttpRequestMethodPUT];
    [self doRequestWithParameters:parameters success:succ failure:fail];
}

- (void)doDeleteRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(void(^)(id))fail{
    [[PFHttpManager sharedHttpManager] setMethod:HttpRequestMethodDELETE];
    [self doRequestWithParameters:parameters success:succ failure:fail];
}

- (void)doUploadFileWithFile:(id)parameters file:(NSData *)file success:(void(^)(id))succ failure:(void(^)(id))fail{
    [[PFHttpManager sharedHttpManager] setMethod:HttpRequestMethodPOST];
    if (self.isPayment) {
        [[PFHttpManager sharedHttpManager] payment:self.methodName parameters:parameters hud:self.hud success:succ failure:^(NSError *err){
            if (fail) fail(err);
            else [[AppDelegate sharedDelegate] showTextOnly:err.localizedDescription];
        }];
    }else{
        [[PFHttpManager sharedHttpManager] request:self.methodName parameters:parameters fileData:file hud:self.hud success:succ failure:^(NSError *err){
            if (fail) fail(err);
            else [[AppDelegate sharedDelegate] showTextOnly:err.localizedDescription];
        }];
    }
}

- (void)doRequestWithParameters:(id)parameters success:(void (^)(id))succ failure:(void (^)(id))fail{
    [[PFHttpManager sharedHttpManager] request:kMethodFormat(self.methodName) parameters:parameters fileData:nil hud:self.hud success:succ failure:^(NSError *err){
        if (fail) fail(err);
        else [[AppDelegate sharedDelegate] showTextOnly:err.localizedDescription];
    }];
}

- (void)saveUserID:(NSString *)OId accessorId:(NSString *)Aid{
    [[NSUserDefaults standardUserDefaults] setObject:OId forKey:@"OId"];
    [[NSUserDefaults standardUserDefaults] setObject:Aid forKey:@"AId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - 删除userID
- (void)DeleteUserID{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    NSUserDefaults * defautls = [NSUserDefaults standardUserDefaults];
    [defautls removePersistentDomainForName:appDomain];
}
@end
