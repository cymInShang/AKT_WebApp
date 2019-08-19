//
//  NSString+Hex.h
//  MisaBaseDemo
//
//  Created by stone on 2018/10/4.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Hex)
/**
 *  返回UILabel自适应后的size
 *  @param aString 字符串
 *  @param width   指定宽度
 *  @param height  指定高度
 */
+ (CGSize)sizeLabelToFit:(NSAttributedString *)aString width:(CGFloat)width height:(CGFloat)height;

/**
 *  return 动态返回字符串size大小
 *  @param aString 字符串
 *  @param width   指定宽度
 *  @param height  指定宽度
 */
+ (CGSize)getStringRect:(NSAttributedString *)aString width:(CGFloat)width height:(CGFloat)height;

/**
 @{
 NSFontAttributeName://(字体)
 NSBackgroundColorAttributeName://(字体背景色)
 NSForegroundColorAttributeName://(字体颜色)
 NSParagraphStyleAttributeName://(段落)
 NSLigatureAttributeName://(连字符)
 NSKernAttributeName://(字间距)
 NSStrikethroughStyleAttributeName://NSUnderlinePatternSolid(实线) | NSUnderlineStyleSingle(删除线)
 NSUnderlineStyleAttributeName://(下划线)
 NSStrokeColorAttributeName://(边线颜色)
 NSStrokeWidthAttributeName://(边线宽度)
 NSShadowAttributeName://(阴影)
 NSVerticalGlyphFormAttributeName://(横竖排版)
 };
 */
+ (NSMutableAttributedString *)getNSAttributedString:(NSString *)labelStr labelDict:(NSDictionary *)labelDic;


+ (BOOL)isEmpty:(NSString*)text;

+ (BOOL)isMobileNumberOnly:(NSString *)mobileNum;


+ (BOOL)checkPWD:(NSString *)pwd;

+ (BOOL)checkNickName:(NSString *)name;

+(BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)checkIDCard:(NSString *)ID;
@end

NS_ASSUME_NONNULL_END
