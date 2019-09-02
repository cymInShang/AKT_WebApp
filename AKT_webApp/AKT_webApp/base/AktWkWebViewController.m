//
//  AktWkWebViewController.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/22.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "AktWkWebViewController.h"

@interface AktWkWebViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    WKWebView *webView;
}
@end

@implementation AktWkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    webView = [[WKWebView alloc] init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
   
    NSString *strurl = [[NSString stringWithFormat:@"%@",webUrl([[NSUserDefaults standardUserDefaults] objectForKey:@"OId"], [[NSUserDefaults standardUserDefaults] objectForKey:@"AId"])] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strurl]]];
}

#pragma mark - uiwkweb delegete
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成之后调用");
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载失败");
}

#pragma mark - 交互
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"--收到响应后，决定是否跳转--%@",navigationResponse.response.URL.absoluteString);
}



-(void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController{
    
    
}



//-(UIViewController webview{
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
