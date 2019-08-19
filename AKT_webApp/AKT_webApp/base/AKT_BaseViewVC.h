//
//  AKT_BaseViewVC.h
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SYNAVCBar;
@interface AKT_BaseViewVC : UIViewController

@property (nonatomic, copy) NSString *titleVC;
@property (nonatomic, assign) CGFloat NAVCHeight;
@property (nonatomic, strong) SYNAVCBar *NAVCBar;

@property (nonatomic, strong) MJRefreshGifHeader *mj_header;
@property (nonatomic, strong) MJRefreshBackGifFooter *mj_footer;

- (void)setNAVCBarHidden:(BOOL)hidden arrowHidden:(BOOL)arrowHidden title:(NSString *)title;
- (void)setRightBtn:(NSString *)btnTitle;

@end

NS_ASSUME_NONNULL_END
