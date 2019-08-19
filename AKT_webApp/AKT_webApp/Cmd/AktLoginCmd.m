//
//  AktLoginCmd.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "AktLoginCmd.h"

@implementation AktLoginCmd
- (void)requestLoginWithPhone:(NSString *)phone code:(NSString *)code success:(void(^)(id))succ{
    self.methodName = Akt_Login;
    [self doPostRequestWithParameters:@{@"organizeNo":phone,@"assessorNo":code} success:^(id responseObj) {
        succ(responseObj);
    } failure:nil];
}
@end
