//
//  MSButton.h
//  MisaBaseDemo
//
//  Created by iOSMS on 2019/3/30.
//  Copyright © 2019年 Misa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSButton : UIView
@property (nonatomic, copy) void(^clickBtnBlock)(NSString *signal);
+(instancetype)initViewWithTitle:(NSString *)title
                       imageName:(NSString *)imgName
            clickBtnBlock:(void(^)(NSString *signal))btnClick;
@end

NS_ASSUME_NONNULL_END
