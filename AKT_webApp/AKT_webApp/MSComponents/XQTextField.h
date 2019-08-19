//
//  XQTextField.h
//  MisaBaseDemo
//
//  Created by iOSMS on 2019/1/14.
//  Copyright © 2019年 Misa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XQTextField;
@protocol XQTextFieldDelegate <NSObject>

- (void)XQTextFieldDidChange:(NSString *)text textField:(XQTextField *)textField;

@end

@interface XQTextField : UIView
@property (nonatomic, weak) id<XQTextFieldDelegate> XQDelegate;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *setText;
@property (nonatomic, assign) CGFloat rightOffset;
@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic) NSTextAlignment alignment;
@property (nonatomic) UIKeyboardType keyboardType;                  

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) BOOL secureTextEntry;

@end

NS_ASSUME_NONNULL_END
