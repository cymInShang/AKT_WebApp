//
//  UITextField+Plus.h
//  PFDoctors
//
//  Created by K.E. on 2019/7/12.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Plus)

/** parameter
 *  holder (font size color) bgColor
 */
+ (UITextField *)initWithParameter:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
