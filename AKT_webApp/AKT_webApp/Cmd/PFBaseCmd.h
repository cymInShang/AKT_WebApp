//
//  PFBaseCmd.h
//  PFDoctors
//
//  Created by K.E. on 2019/7/22.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFHttpManager.h"

#define kMethodFormat(b) [NSString stringWithFormat:@"%@",b]

NS_ASSUME_NONNULL_BEGIN

@interface PFBaseCmd : NSObject
@property (nonatomic, strong) NSString *hud;             
@property (nonatomic, strong) NSString *methodName;             //接口方法名
@property (nonatomic, assign) BOOL isPayment;

- (void)saveUserID:(NSNumber *)userID;
- (void)DeleteUserID;

- (void)doGetRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(nullable void(^)(id))fail;
- (void)doPostRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(nullable void(^)(id))fail;
- (void)doPutRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(nullable void(^)(id))fail;
- (void)doDeleteRequestWithParameters:(id)parameters success:(void(^)(id))succ failure:(nullable void(^)(id))fail;

- (void)doUploadFileWithFile:(id)parameters file:(NSData *)file success:(void(^)(id))succ failure:(nullable void(^)(id))fail;
@end

NS_ASSUME_NONNULL_END
