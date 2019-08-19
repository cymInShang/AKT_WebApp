//
//  AktLoginCmd.h
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFBaseCmd.h"

#define Akt_Login @""

NS_ASSUME_NONNULL_BEGIN

@interface AktLoginCmd : PFBaseCmd
/*登录*/
- (void)requestLoginWithPhone:(NSString *)phone code:(NSString *)code success:(void(^)(id))succ;

@end

NS_ASSUME_NONNULL_END
