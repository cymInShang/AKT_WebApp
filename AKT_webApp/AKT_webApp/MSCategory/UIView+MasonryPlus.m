//
//  UIView+MasonryPlus.m
//  PFDoctors
//
//  Created by K.E. on 2019/7/11.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "UIView+MasonryPlus.h"
#import "Masonry.h"

@implementation UIView (MasonryPlus)


- (void)setCornerRadius:(CGFloat)radius{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width{
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}

- (void)mas_layoutWithCons:(id)parameter{
    NSDictionary *dict = [self dictFormString:parameter];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        [self makeConstraints:make cons:dict];
    }];
}

- (void)mas_modifyWithCons:(id)parameter{
    NSDictionary *dict = [self dictFormString:parameter];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        [self makeConstraints:make cons:dict];
    }];
}

- (void)mas_centerWithView:(UIView *)Vi cons:(id)parameter{
    NSDictionary *dict = [self dictFormString:parameter];
    NSInteger num = [[[dict allValues] firstObject] doubleValue];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([[dict allKeys] containsObject:@"x"]) make.centerX.mas_equalTo(Vi.mas_centerX).with.offset(kAdaptWidth(num));
        if ([[dict allKeys] containsObject:@"y"]) make.centerY.mas_equalTo(Vi.mas_centerY).with.offset(kAdaptHeight(num));
    }];
}

- (void)mas_layoutWithBrother:(UIView *)Vi cons:(id)parameter{
    NSDictionary *dict = [self dictFormString:parameter];
    NSInteger num = [[[dict allValues] firstObject] doubleValue];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([[dict allKeys] containsObject:@"H"]) make.left.equalTo(Vi.mas_right).with.offset(kAdaptWidth(num));
        if ([[dict allKeys] containsObject:@"V"]) make.top.equalTo(Vi.mas_bottom).with.offset(kAdaptHeight(num));
    }];
}

- (void)mas_equalWithBrother:(NSArray *)Vis cons:(id)parameter{
    NSMutableArray *vis = [NSMutableArray arrayWithArray:Vis];
    [vis addObject:self];
    NSDictionary *dict = [self dictFormString:parameter];
    MASAxisType type = ([[dict allKeys] containsObject:@"H"] ? MASAxisTypeHorizontal : MASAxisTypeVertical);
    [vis mas_distributeViewsAlongAxis:type withFixedSpacing:[dict[@"m"] doubleValue] leadSpacing:[dict[@"b"] doubleValue] tailSpacing:[dict[@"a"] doubleValue]];
}

- (void)makeConstraints:(MASConstraintMaker *)make cons:(NSDictionary *)cDict{
    if ([[cDict allKeys] containsObject:@"l"])
        make.left.equalTo(self.superview.mas_left).with.offset(kAdaptWidth([cDict[@"l"] doubleValue]));
    if ([[cDict allKeys] containsObject:@"t"])
        make.top.equalTo(self.superview.mas_top).with.offset(kAdaptHeight([cDict[@"t"] doubleValue]));
    if ([[cDict allKeys] containsObject:@"r"])
        make.right.equalTo(self.superview.mas_right).with.offset(-(kAdaptWidth([cDict[@"r"] doubleValue])));
    if ([[cDict allKeys] containsObject:@"b"])
        make.bottom.equalTo(self.superview.mas_bottom).with.offset(-(kAdaptHeight([cDict[@"b"] doubleValue])));
    if ([[cDict allKeys] containsObject:@"x"])
        make.centerX.mas_equalTo(self.superview.mas_centerX).with.offset(kAdaptWidth([cDict[@"x"] doubleValue]));
    if ([[cDict allKeys] containsObject:@"y"])
        make.centerY.mas_equalTo(self.superview.mas_centerY).with.offset(kAdaptHeight([cDict[@"y"] doubleValue]));
    if ([[cDict allKeys] containsObject:@"w"])
        make.width.equalTo(@(kAdaptWidth([cDict[@"w"] doubleValue])));
    if ([[cDict allKeys] containsObject:@"h"])
        make.height.equalTo(@(kAdaptHeight([cDict[@"h"] doubleValue])));
    if ([[cDict allKeys] containsObject:@"m"])
        make.height.mas_equalTo(self.mas_width).multipliedBy([cDict[@"m"] doubleValue]);
    
    if ([[cDict allKeys] containsObject:@"lw"]) // 小于等于
        make.width.lessThanOrEqualTo(@(kAdaptWidth([cDict[@"lw"] doubleValue])));
    if ([[cDict allKeys] containsObject:@"gw"]) // 大于等于
        make.width.greaterThanOrEqualTo(@(kAdaptWidth([cDict[@"gw"] doubleValue])));
    if ([[cDict allKeys] containsObject:@"lh"])
        make.height.lessThanOrEqualTo(@(kAdaptHeight([cDict[@"lh"] doubleValue])));
    if ([[cDict allKeys] containsObject:@"gh"])
        make.height.greaterThanOrEqualTo(@(kAdaptHeight([cDict[@"gh"] doubleValue])));
    
    // 不使用比例
    if ([[cDict allKeys] containsObject:@"W"])
        make.width.equalTo(@([cDict[@"W"] doubleValue]));
    if ([[cDict allKeys] containsObject:@"H"])
        make.height.equalTo(@([cDict[@"H"] doubleValue]));
}

- (NSDictionary *)dictFormString:(id)parameter{
    if ([parameter isKindOfClass:[NSDictionary class]]) return (NSDictionary *)parameter;
    if ([parameter isKindOfClass:[NSString class]]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        NSArray *ary = [(NSString *)parameter componentsSeparatedByString:@"|"];
        for (NSString *str in ary){
            NSRange range = [str rangeOfString:@":"];
            if (range.length == 0) [dict setObject:@"0" forKey:str];
            else [dict setObject:[str substringFromIndex:(range.location + 1)] forKey:[str substringToIndex:range.location]];
        }
        return dict;
    }
    return @{};
}
@end
