//
//  HomeViewController.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"

@interface HomeViewController ()<UIWebViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AId"]) {
        [self setWebProgressWithWebView:self.webViewBg];
        [self setBridgeWithWebView:self.webViewBg withRefresh:YES];

        [self loadWebView:webUrl];
    }else{
        LoginViewController *loginvc = [[LoginViewController alloc] init];
        [self.navigationController presentViewController:loginvc animated:YES completion:nil];
    }
   
}
- (void)loadWebView:(NSString *)url{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSLog(@"----%@",url);
    [_webViewBg loadRequest:request];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
