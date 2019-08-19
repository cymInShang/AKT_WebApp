//
//  UITextField+Plus.m
//  PFDoctors
//
//  Created by K.E. on 2019/7/12.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "UITextField+Plus.h"

@implementation UITextField (Plus)
+ (UITextField *)initWithParameter:(NSDictionary *)parameter{
    UITextField *tf = [[UITextField alloc] init];
    if (parameter[@"holder"]) [tf setPlaceholder:parameter[@"holder"]];
    if (parameter[@"bgColor"]) [tf setBackgroundColor:parameter[@"bgColor"]];
    if (parameter[@"color"]) [tf setTextColor:parameter[@"color"]];
    if (parameter[@"size"]) [tf setFont:[UIFont fontWithName:(parameter[@"font"] == nil ? @"PingFang-SC-Regular" : parameter[@"font"]) size:[parameter[@"size"] integerValue]]];
    return tf;
}
@end
