//
//  MSLabel.m
//  MisaBaseDemo
//
//  Created by stone on 2018/10/5.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import "MSLabel.h"

@implementation MSLabel

-(id)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextAlignment:NSTextAlignmentLeft];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
-(CGSize)getLabelSize
{
    CGSize maxiLabelSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    return [self sizeThatFits:maxiLabelSize];
}
-(float)getLabelHeightWithLimitWidth:(float)limitWidth
{
    CGSize maxiLabelSize = CGSizeMake(limitWidth, CGFLOAT_MAX);
    return [self sizeThatFits:maxiLabelSize].height;
}

@end


#pragma mark - LabelForNavBar

@implementation LabelForNavBar

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 160, MS_NavigationBarHeight)];
    if (self) {
        [self setTextColor:[UIColor colorWithHexString:@"#666666"]];
        [self setFont:[UIFont systemFontOfSize:18]];
        [self setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}

@end

