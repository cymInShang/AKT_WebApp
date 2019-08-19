//
//  XQTextField.m
//  MisaBaseDemo
//
//  Created by iOSMS on 2019/1/14.
//  Copyright © 2019年 Misa. All rights reserved.
//

#import "XQTextField.h"

@interface XQTextField ()<UITextFieldDelegate>
@property(nonatomic, strong) UIImageView *imgLine;
@property(nonatomic, strong) UITextField *textField;

@end

@implementation XQTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;

}

- (void)initViews
{
    _canEdit = YES;
    [self addSubview:self.textField];
    [self addSubview:self.imgLine];
    
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.imgLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
}


-(void)textFieldDidChange :(UITextField *)theTextField{
    if (self.XQDelegate) {
        [self.XQDelegate XQTextFieldDidChange:theTextField.text textField:self];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (_canEdit) {
        
        return YES;
        
    }
    
    return NO;
    
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

- (void)setAlignment:(NSTextAlignment)alignment
{
    _alignment = alignment;
    self.textField.textAlignment = alignment;
}

- (void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
}

- (void)setRightOffset:(CGFloat)rightOffset
{
    _rightOffset = rightOffset;
    self.textField.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rightOffset, 0)];
    self.textField.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setLeftOffset:(CGFloat)leftOffset
{
    _leftOffset = leftOffset;
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftOffset, 0)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    self.textField.font = [UIFont systemFontOfSize:fontSize];//MSSystemFontOfSize(fontSize);
}
- (void)setSetText:(NSString *)setText
{
    _setText = setText;
    self.textField.text = setText;

}

- (NSString *)text
{
    return self.textField.text;
}

- (UIImageView *)imgLine
{
    if (!_imgLine) {
        _imgLine = [UIImageView new];
        _imgLine.backgroundColor = LINECOLOR;
    }
    return _imgLine;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.font = [UIFont systemFontOfSize:18]; //MSSystemFontOfSize(18);
        _textField.textColor = TEXTCOLOR;
        _textField.delegate = self;
    }
    return _textField;
}
@end
