//
//  AKT_BaseWebVC.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "AKT_BaseWebVC.h"

@interface AKT_BaseWebVC ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView * webview;
@end

@implementation AKT_BaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化web
    /*self.webview.allowsBackForwardNavigationGestures = YES;
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, MS_NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MS_NavigationBarHeight)];
    self.webview.UIDelegate = self;
    self.webview.navigationDelegate =self;
    [self.view addSubview:self.webview];
    
    [self refurbishWeb];*/
    [WebViewJavascriptBridge enableLogging];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_progressView)
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_progressView)
    [_progressView removeFromSuperview];
}

- (NSURLRequest *)getRequestWithUrl:(NSString *)url{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutSecond];
}

#pragma mark - set progress 、 bridge
- (void)setWebProgressWithWebView:(UIWebView *)webView{ //进度条
    _progressProxy = [[NJKWebViewProgress alloc] init];
    webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)setBridgeWithWebView:(UIWebView *)webView withRefresh:(BOOL) isRefresh{
    id delegate = self;
    webView.allowsInlineMediaPlayback = YES;//视频非全屏播放
    if (_progressProxy)
    delegate =_progressProxy;
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:delegate handler:^(id data, WVJBResponseCallback responseCallback) {
        [self didReceivedDataFormJS:data callBack:responseCallback];
    }];
    if (!isRefresh) [webView hiddenBackGroundInBlack];
}
#pragma mark - js action
- (void)didReceivedDataFormJS:(id)data callBack:(WVJBResponseCallback) responseCallback{
    
}
#pragma mark - send data web
- (void)doSendDataToJS:(id)data callback:(WVJBResponseCallback) responseCallback{
    [self.bridge send:data responseCallback:responseCallback];
}

#pragma mark - reset method
- (void)didFinishLoad:(UIWebView *)webView{  }// 成功加载
- (void)didFailLoadL:(UIWebView *)webView error:(NSError *)error{ }// 加载失败
- (void)didReceivedDataFormJS:(NSDictionary *)dict{ } //接收消息

#pragma mark - NJWebViewProgress
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [self.progressView setProgress:progress animated:YES];
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //    NSLog(@"baseWebViewDidStartLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self didFailLoadL:webView error:error];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self didFinishLoad:webView];
}


#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation");
    [[AppDelegate sharedDelegate] hidHUD];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didFinishNavigation");
    [self closedPopview];
}
/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败");
    [self customerAlertView];
    [[AppDelegate sharedDelegate] hidHUD];
}

-(void)customerAlertView{
    UIView * popview = [[UIView alloc] initWithFrame:CGRectMake(0,0, 100, 50)];
    popview.center = self.view.center;
    popview.layer.cornerRadius = 10.0;//5.0是圆角的弧度，根据需求自己更改
    popview.layer.masksToBounds = YES;
    popview.backgroundColor = [UIColor colorWithHexString:@"a2c8f9"];
    //popview.alpha=0.7;
    UIButton * Rbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [popview setTag:10];
    
    [Rbtn setTitle:@"点击刷新" forState:UIControlStateNormal];
    [Rbtn addTarget:self action:@selector(refurbishWeb) forControlEvents:UIControlEventTouchUpInside];
    [Rbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Rbtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [popview addSubview: Rbtn];
    
    [self.view addSubview:popview];
    
    [Rbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
}

-(void)closedPopview{
    for(UIView * v in self.view.subviews){
        if(v.tag == 10){
            [v removeFromSuperview];
        }
    }
}

-(void)refurbishWeb{
    NSString *strurl = [[NSString stringWithFormat:@"%@",webUrl([[NSUserDefaults standardUserDefaults] objectForKey:@"OId"], [[NSUserDefaults standardUserDefaults] objectForKey:@"AId"])] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest * uq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", strurl]]];
    uq.timeoutInterval = 0.3f;
    [self.webview loadRequest:uq];
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
