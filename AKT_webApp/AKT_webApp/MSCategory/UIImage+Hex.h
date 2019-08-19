//
//  UIImage+Hex.h
//  MisaBaseDemo
//
//  Created by stone on 2018/10/4.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Hex)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *) partialImageWithPercentage:(float)percentage
                                vertical:(BOOL)vertical
                           grayscaleRest:(BOOL)grayscaleRest;
@end

NS_ASSUME_NONNULL_END
