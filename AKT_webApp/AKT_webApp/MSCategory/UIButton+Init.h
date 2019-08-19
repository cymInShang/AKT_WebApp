//
//  UIButton+Init.h
//  PFDoctors
//
//  Created by K.E. on 2019/7/11.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Init)
/** parameter
 *  icon (title font size color) bgimg/bgcolor
 */
+ (UIButton *)initWithParameter:(NSDictionary *)parameter;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
