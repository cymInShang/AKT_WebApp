//
//  UIWebView+WebViewPlus.m
//  HomeDo
//
//  Created by Lynn on 15/12/3.
//  Copyright © 2015年 Lynn. All rights reserved.
//

#import "UIWebView+WebViewPlus.h"

@implementation UIWebView (WebViewPlus)

- (void)hiddenBackGroundInBlack{
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    for (UIView *subView in [self subviews]){
        if ([subView isKindOfClass:[UIScrollView class]]){
            ((UIScrollView *)subView).bounces = NO; //去掉UIWebView的底图
            for (UIView *scrollview in subView.subviews){
                if ([scrollview isKindOfClass:[UIImageView class]])
                    scrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
            }
        }
    }
}
@end
