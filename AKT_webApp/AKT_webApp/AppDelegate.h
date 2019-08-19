//
//  AppDelegate.h
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign) BOOL IsAutoLogin;//是否自动登陆

+ (AppDelegate *)sharedDelegate;
+ (UIViewController *)getCurrentVC;

- (void)showLoadingHUD:(UIView *)vi msg:(NSString *)msg;
- (void)showTextOnly:(NSString *)msg;
- (void)hidHUD;
- (void)showAlertView:(NSString *)title des:(NSString *)des cancel:(NSString *)cl action:(NSString *)ac acHandle:(void (^)(UIAlertAction *action))handler;


@end

