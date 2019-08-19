//
//  UIView+MasonryPlus.h
//  PFDoctors
//
//  Created by K.E. on 2019/7/11.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define CONS(a) [NSNumber numberWithDouble:a]

@interface UIView (MasonryPlus)
- (void)setCornerRadius:(CGFloat)radius;
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;

/** parameter
 *  x:0|y:0|l:0|r:0|t:0|b:0|w:0|h:0|m:0.1 高宽比
 *  --------------or--------------------
 *  @{@"x":0|@"y":0|@"l":0|@"r":0|@"t":0|@"b":0|@"w":0|@"h":0|@"m":0.1}
 }
 */
- (void)mas_layoutWithCons:(id)parameter;
- (void)mas_modifyWithCons:(id)parameter;

/** Vi 参照view
 *  parameter x:0 / y:0   or  @{@"x":0} / @{@"y":0}
 */
- (void)mas_centerWithView:(UIView *)Vi cons:(id)parameter;

/** Vis 参照view 在前
 *  parameter H/V   m b a
 */
- (void)mas_equalWithBrother:(NSArray *)Vis cons:(id)parameter;

/** Vi 参照view 在前
 *  parameter H:0 / V:0   or  @{@"H":0} / @{@"V":0}
 */
- (void)mas_layoutWithBrother:(UIView *)Vi cons:(id)parameter;
@end

NS_ASSUME_NONNULL_END
