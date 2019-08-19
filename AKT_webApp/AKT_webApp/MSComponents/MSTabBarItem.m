//
//  MSTabBarItem.m
//  MisaBaseDemo
//
//  Created by stone on 2018/10/4.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import "MSTabBarItem.h"

@implementation MSTabBarItem
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag
{
    self = [super initWithTitle:title image:image tag:tag];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage NS_AVAILABLE_IOS(7_0)
{
    self = [super initWithTitle:title image:image selectedImage:selectedImage];
    if (self) {
        // tabbar颜色 选中和未选中的颜色
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]} forState:UIControlStateNormal];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:COMMENCOLOR} forState:UIControlStateSelected];
    }
    return self;
}
- (instancetype)initWithTabBarSystemItem:(UITabBarSystemItem)systemItem tag:(NSInteger)tag
{
    self = [super initWithTabBarSystemItem:systemItem tag:tag];
    if (self) {
        
    }
    return self;
}

@end
