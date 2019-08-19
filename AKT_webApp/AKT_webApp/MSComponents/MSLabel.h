//
//  MSLabel.h
//  MisaBaseDemo
//
//  Created by stone on 2018/10/5.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSLabel : UILabel
-(CGSize)getLabelSize;

-(float)getLabelHeightWithLimitWidth:(float)limitWidth;
@end

#pragma -mark navbar titleView
@interface LabelForNavBar : UILabel

@end
NS_ASSUME_NONNULL_END
