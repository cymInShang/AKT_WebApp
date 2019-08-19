//
//  UIView+Layer.m
//  MisaBaseDemo
//
//  Created by edz on 2019/8/10.
//  Copyright © 2019 Misa. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth < 0) return;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

@end
