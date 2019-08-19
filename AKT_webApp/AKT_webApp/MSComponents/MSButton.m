//
//  MSButton.m
//  MisaBaseDemo
//
//  Created by iOSMS on 2019/3/30.
//  Copyright © 2019年 Misa. All rights reserved.
//

#import "MSButton.h"

@interface MSButton ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation MSButton

+ (instancetype)initViewWithTitle:(NSString *)title imageName:(NSString *)imgName clickBtnBlock:(void (^)(NSString * _Nonnull))btnClick
{
    MSButton *btn = [[MSButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3.0, KPXIMGWIDTH(44))];
    btn.clickBtnBlock = btnClick;
    [btn initViewsTitle:title imageName:imgName];
    return btn;
}

- (void)initViewsTitle:(NSString *)title imageName:(NSString *)imgName
{
    [self addSubview:self.imgIcon];
    [self addSubview:self.labTitle];
    [self addSubview:self.btn];
    
    self.labTitle.text = title;
    self.imgIcon.image = [UIImage imageNamed:imgName];

    [self.imgIcon makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(KPXIMGWIDTH(17), KPXIMGWIDTH(17)));
        make.left.equalTo(self).offset(KPXIMGWIDTH(23));
        make.centerY.equalTo(self);
    }];
    
    [self.labTitle makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).offset(KPXIMGWIDTH(2));
        make.centerY.equalTo(self.imgIcon);
    }];
    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.center.equalTo(self);
    }];
}

- (void)btnClick:(UIButton *)btn
{
    if (btn == self.btn) {
        if (self.clickBtnBlock) {
            self.clickBtnBlock(@"click");
        }
    }
}

- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [UILabel new];
        _labTitle.font = [UIFont systemFontOfSize:16];
        _labTitle.textColor = TEXTCOLOR;
    }
    return _labTitle;
}

- (UIImageView *)imgIcon
{
    if (!_imgIcon) {
        _imgIcon = [UIImageView new];
    }
    return _imgIcon;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
       [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
