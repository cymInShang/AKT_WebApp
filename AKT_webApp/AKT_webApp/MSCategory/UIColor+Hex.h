//
//  UIColor+Hex.h
//  MisaBaseDemo
//
//  Created by stone on 2018/10/4.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
