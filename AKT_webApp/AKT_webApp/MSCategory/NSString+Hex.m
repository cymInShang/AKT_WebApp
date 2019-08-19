//
//  NSString+Hex.m
//  MisaBaseDemo
//
//  Created by stone on 2018/10/4.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import "NSString+Hex.h"
#import <CoreText/CoreText.h>

@implementation NSString (Hex)
static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
    return ceil(cgfloat);
#else
    return ceilf(cgfloat);
#endif
}

+ (NSRange)getFirstRangeWithLinkString:(NSString *)linkString inTextString:(NSString *)string {
    NSRange linkRange = [string rangeOfString:linkString];
    return linkRange;
}

+ (NSArray *)getRangeArrayWithLinkString:(NSString *)linkString
                            inTextString:(NSString *)string
                               lastRange:(NSRange)lastRange
                              rangeArray:(NSMutableArray *)array
{
    NSRange range = [string rangeOfString:linkString];
    if (range.location == NSNotFound){
        return array;
    }else{
        NSRange curRange = NSMakeRange(lastRange.location+lastRange.length+range.location, range.length);
        [array addObject:NSStringFromRange(curRange)];
        NSString *tempString = [string substringFromIndex:(range.location+range.length)];
        [self getRangeArrayWithLinkString:linkString inTextString:tempString lastRange:curRange rangeArray:array];
        return array;
    }
}

+ (CGSize)sizeLabelToFit:(NSAttributedString *)aString width:(CGFloat)width height:(CGFloat)height {
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tempLabel.attributedText = aString;
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    CGSize size = tempLabel.frame.size;
    size = CGSizeMake(CGFloat_ceil(size.width), CGFloat_ceil(size.height));
    return size;
}

+ (CGSize)getStringRect:(NSAttributedString *)aString width:(CGFloat)width height:(CGFloat)height
{
    CGSize size = CGSizeZero;
    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc] initWithAttributedString:aString];
    NSRange range = NSMakeRange(0, atrString.length);
    
    //获取指定位置上的属性信息，并返回与指定位置属性相同并且连续的字符串的范围信息。
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    //不存在段落属性，则存入默认值
    NSMutableParagraphStyle *paragraphStyle = dic[NSParagraphStyleAttributeName];
    if (!paragraphStyle || nil == paragraphStyle) {
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineSpacing = 0.0;//增加行高
        paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
        paragraphStyle.tailIndent = 0;//相当于右padding
        paragraphStyle.lineHeightMultiple = 0;//行间距是多少倍
        paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
        paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
        paragraphStyle.paragraphSpacing = 0;//段落后面的间距
        paragraphStyle.paragraphSpacingBefore = 0;//段落之前的间距
        [atrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
    
    //设置默认字体属性
    UIFont *font = dic[NSFontAttributeName];
    if (!font || nil == font) {
        font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
        [atrString addAttribute:NSFontAttributeName value:font range:range];
    }
    
    NSMutableDictionary *attDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [attDic setObject:font forKey:NSFontAttributeName];
    [attDic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    CGSize strSize = [[aString string] boundingRectWithSize:CGSizeMake(width, height)
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:attDic
                                                    context:nil].size;
    
    size = CGSizeMake(CGFloat_ceil(strSize.width), CGFloat_ceil(strSize.height));
    return size;
}

+ (NSMutableAttributedString *)getNSAttributedString:(NSString *)labelStr labelDict:(NSDictionary *)labelDic
{
    
    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSRange range = NSMakeRange(0, atrString.length);
    if (labelDic && labelDic.count > 0) {
        NSEnumerator *enumerator = [labelDic keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) {
            [atrString addAttribute:key value:labelDic[key] range:range];
        }
    }
    //段落属性
    NSMutableParagraphStyle *paragraphStyle = labelDic[NSParagraphStyleAttributeName];
    if (!paragraphStyle || nil == paragraphStyle) {
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineSpacing = 0.0;//增加行高
        paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
        paragraphStyle.tailIndent = 0;//相当于右padding
        paragraphStyle.lineHeightMultiple = 0;//行间距是多少倍
        paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
        paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
        paragraphStyle.paragraphSpacing = 0;//段落后面的间距
        paragraphStyle.paragraphSpacingBefore = 0;//段落之前的间距
        [atrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
    
    //字体
    UIFont *font = labelDic[NSFontAttributeName];
    if (!font || nil == font) {
        font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
        [atrString addAttribute:NSFontAttributeName value:font range:range];
    }
    
    return atrString;
}


#pragma - mark 计算AttributedStringHeight，包含的三种方法计算结果均有误差，UILabel显示时上下会有空白行，且留白范围与所显示内容呈递增关系
+ (CGFloat)getAttributedStringHeightWithString:(NSAttributedString *)string width:(CGFloat)width {
    CGFloat heightValue = 0;
    //string 为要计算高的NSAttributedString
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)string);
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    CGSize suggestedSize= CTFramesetterSuggestFrameSizeForAttributedStringWithConstraints(framesetter,string,size,CGFLOAT_MAX);
    heightValue = suggestedSize.height;
    
    //这里的高要设置足够大
    CGFloat height = CGFLOAT_MAX;
    CGRect drawingRect = CGRectMake(0, 0, width, height);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    CFArrayRef lines = CTFrameGetLines(textFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), lineOrigins);
    
    heightValue = 0;
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;//上行行高
        CGFloat lineDescent;//下行行高
        CGFloat lineLeading;//行距
        CGFloat lineHeight;//行高
        //获取每行的高度
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        lineHeight = lineAscent +  fabs(lineDescent) + lineLeading;
        heightValue = heightValue + lineHeight;
    }
    heightValue = CGFloat_ceil(heightValue);
    
    heightValue = 0;
    CGFloat line_y = (CGFloat)lineOrigins[CFArrayGetCount(lines)-1].y;  //最后一行line的原点y坐标
    CGFloat lastAscent = 0;//上行行高
    CGFloat lastDescent = 0;//下行行高
    CGFloat lastLeading = 0;//行距
    CTLineRef lastLine = CFArrayGetValueAtIndex(lines, CFArrayGetCount(lines)-1);
    CTLineGetTypographicBounds(lastLine, &lastAscent, &lastDescent, &lastLeading);
    //height - line_y为除去最后一行的字符原点以下的高度，descent + leading为最后一行不包括上行行高的字符高度
    heightValue = height - line_y + (CGFloat)(fabs(lastDescent) + lastLeading);
    heightValue = CGFloat_ceil(heightValue);
    //    NSLog(@"3、最后一行原点y坐标加最后一行高度");
    //    NSLog(@"heightValue %@",@(heightValue));
    
    CFRelease(textFrame);
    return heightValue;
}

static inline CGSize CTFramesetterSuggestFrameSizeForAttributedStringWithConstraints(CTFramesetterRef framesetter, NSAttributedString *attributedString, CGSize size, NSUInteger numberOfLines) {
    CFRange rangeToSize = CFRangeMake(0, (CFIndex)[attributedString length]);
    CGSize constraints = CGSizeMake(size.width, CGFLOAT_MAX);
    
    if (numberOfLines == 1) {
        // If there is one line, the size that fits is the full width of the line
        constraints = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    } else if (numberOfLines > 0) {
        // If the line count of the label more than 1, limit the range to size to the number of lines that have been set
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0.0f, 0.0f, constraints.width, CGFLOAT_MAX));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CFArrayRef lines = CTFrameGetLines(frame);
        
        if (CFArrayGetCount(lines) > 0) {
            NSInteger lastVisibleLineIndex = MIN((CFIndex)numberOfLines, CFArrayGetCount(lines)) - 1;
            CTLineRef lastVisibleLine = CFArrayGetValueAtIndex(lines, lastVisibleLineIndex);
            
            CFRange rangeToLayout = CTLineGetStringRange(lastVisibleLine);
            rangeToSize = CFRangeMake(0, rangeToLayout.location + rangeToLayout.length);
        }
        CFRelease(frame);
        CGPathRelease(path);
    }
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, rangeToSize, NULL, constraints, NULL);
    return CGSizeMake(CGFloat_ceil(suggestedSize.width), CGFloat_ceil(suggestedSize.height));
}

+(BOOL)isEmpty:(NSString*)text{
    
    if ([text isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (text == nil){
        return YES;
    }
    
    if (!text) {
        return YES;
    }
    if ([text isEqualToString:@""]){
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [text stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

//判断是否为电话号码
+ (BOOL)isMobileNumberOnly:(NSString *)mobileNum
{
    NSString * MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)checkPWD:(NSString *)pwd
{
    if (!pwd) {
        return NO;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [pwd stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return NO;
        } else {
            NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{8,16}$";
            
            NSPredicate *regextestPassWord = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
            
            
            BOOL isOk = [regextestPassWord evaluateWithObject:pwd];
            return isOk;
        }
    }
    
}

+ (BOOL)checkNickName:(NSString *)name
{
    if (!name) {
        return NO;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [name stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return NO;
        } else {
            NSRange range = [name rangeOfString:@" "];
            if (range.location != NSNotFound) {
                return NO; //NO代表包含空格
            } else {
                return YES; //反之
            }
        }
    }
    
    
}

+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)checkIDCard:(NSString *)ID
{
    //长度不为18的都排除掉
    if (ID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:ID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[ID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [ID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}

@end
