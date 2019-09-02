//
//  SYNAVCBar.m
//  MisaBaseDemo
//
//  Created by iOSMS on 2019/3/12.
//  Copyright © 2019年 Misa. All rights reserved.
//

#import "SYNAVCBar.h"

@interface SYNAVCBar ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imgLine;
@property (nonatomic, strong) UIImageView *imgBG;


@end

@implementation SYNAVCBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    [self addSubview:self.imgBG];
    [self addSubview:self.labTitle];
    [self addSubview:self.imgLine];
    [self addSubview:self.btnBack];
    
    [self.imgBG makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.center.equalTo(self);
    }];
    
    [self.labTitle makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-16);
        make.centerX.equalTo(self);
        make.width.lessThanOrEqualTo(@(SCREEN_WIDTH - KPXIMGWIDTH(90)));
        
    }];
    
    [self.imgLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    [self.btnBack makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(KPXIMGWIDTH_UI(50), KPXIMGWIDTH_UI(50)));
        make.centerY.equalTo(self.labTitle);
        make.left.equalTo(@(10));
    }];
}

- (void)setStrTitle:(NSString *)strTitle
{
    _strTitle = strTitle;
    self.labTitle.text = strTitle;
}

- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [UILabel new];
        _labTitle.font = FONTBOLDFACEWITHSIZE(18);
        _labTitle.textColor = ColorWhite;
    }
    return _labTitle;
}

- (UIImageView *)imgLine
{
    if (!_imgLine) {
        _imgLine = [UIImageView new];
        _imgLine.backgroundColor = LINECOLOR;
        _imgLine.backgroundColor = ColorClear;

    }
    return _imgLine;
}

- (UIImageView *)imgBG
{
    if (!_imgBG) {
        _imgBG = [UIImageView new];
//        _imgBG.image = [UIImage imageNamed:@"sy-bannerkongbai"];
//        _imgBG.backgroundColor = TEXTCOLOR;
    }
    return _imgBG;
}

- (UIButton *)btnBack
{
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBack setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
//        _btnBack.backgroundColor = TEXTCOLOR;
    }
    return _btnBack;
}

@end
