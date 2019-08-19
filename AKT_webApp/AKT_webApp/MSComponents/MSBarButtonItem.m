//
//  MSBarButtonItem.m
//  MisaBaseDemo
//
//  Created by stone on 2018/10/5.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import "MSBarButtonItem.h"

@implementation MSBarButtonItem
-(id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    self = [super initWithImage:image style:style target:target action:action];
    if (self) {
        
    }
    return self;
}
-(id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    self=[super initWithTitle:title style:style target:target action:action];
    if (self) {
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor],  NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateNormal];
        
    }
    return self;
}
-(void)setTitleColor:(UIColor*)color
{
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: color,  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}

@end
