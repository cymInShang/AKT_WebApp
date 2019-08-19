//
//  UIView+Layer.h
//  MisaBaseDemo
//
//  Created by edz on 2019/8/10.
//  Copyright © 2019 Misa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Layer)

/**
 可视化设置边框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor * borderColor;

/**
 可视化设置边框圆角
 */
@property (nonatomic,assign)IBInspectable CGFloat cornerRadius;

/**
 可视化设置边框宽度
 */
@property (nonatomic,assign)IBInspectable CGFloat borderWidth;

@end

NS_ASSUME_NONNULL_END
