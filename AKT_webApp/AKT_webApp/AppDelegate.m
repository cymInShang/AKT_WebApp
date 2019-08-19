//
//  AppDelegate.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation AppDelegate

+ (AppDelegate *)sharedDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    // 根视图
    HomeViewController *vcMain = [[HomeViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vcMain];
    nvc.navigationBarHidden = YES;
    _window.rootViewController = nvc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - loading and message hud
- (void)showLoadingHUD:(UIView *)vi msg:(NSString *)msg{
    HUD = [MBProgressHUD showHUDAddedTo:(vi == nil ? self.window : vi) animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.delegate = self;
    if (msg && msg.length > 0) HUD.label.text = msg;
    [HUD showAnimated:YES];
}

- (void)showTextOnly:(NSString *)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hidHUD{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->HUD hideAnimated:YES];
    }];
}

#pragma mark - hud delegate
- (void)hudWasHidden:(MBProgressHUD *)_hud {
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)showAlertView:(NSString *)title des:(NSString *)des cancel:(NSString *)cl action:(NSString *)ac acHandle:(void (^)(UIAlertAction *action))handler{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:des preferredStyle:UIAlertControllerStyleAlert];
    if (handler) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:(ac==nil?@"确定":ac) style:UIAlertActionStyleDefault handler:handler];
        [actionSheet addAction:action];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:(cl==nil?@"取消":cl) style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:cancel];
    [[AppDelegate getCurrentVC] presentViewController:actionSheet animated:YES completion:nil];
}


@end
