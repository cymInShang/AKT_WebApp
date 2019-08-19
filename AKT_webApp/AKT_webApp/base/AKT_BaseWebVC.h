//
//  AKT_BaseWebVC.h
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKT_BaseViewVC.h"
#import "WebViewJavascriptBridge.h"
#import "UIWebView+WebViewPlus.h"

#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

#define kTimeOutSecond 60.0f

NS_ASSUME_NONNULL_BEGIN

@interface AKT_BaseWebVC : AKT_BaseViewVC<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (strong, nonatomic) WebViewJavascriptBridge *bridge;
@property (strong, nonatomic) NSURLRequest *request;

@property (nonatomic,strong) NJKWebViewProgressView *progressView;
@property (nonatomic,strong) NJKWebViewProgress *progressProxy;

#pragma mark - 这两个方法同时调用时 必须是当前显示的顺序
- (void)setWebProgressWithWebView:(UIWebView *)webView;
- (void)setBridgeWithWebView:(UIWebView *)webView withRefresh:(BOOL) isRefresh;
#pragma mark -

- (NSURLRequest *)getRequestWithUrl:(NSString *)url;
- (void)didFinishLoad:(UIWebView *)webView;
- (void)doSendDataToJS:(id)data callback:(WVJBResponseCallback) responseCallback;

@end

NS_ASSUME_NONNULL_END
