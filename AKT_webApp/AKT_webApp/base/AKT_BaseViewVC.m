//
//  AKT_BaseViewVC.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "AKT_BaseViewVC.h"
#import "SYNAVCBar.h"

@interface AKT_BaseViewVC ()<UIGestureRecognizerDelegate>

@end

@implementation AKT_BaseViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    
    [self initNAVCBar];
    
    [self initBase];
    
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self setupLeftBarButton];
    }
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^(void){[self loadHeaderData:self.mj_header];}];
    //    self.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^(void){[self loadFooterData:self.mj_footer];}];
    self.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [weakSelf loadFooterData:weakSelf.mj_footer];
    }];
    
}

#pragma mark - mj header action and footer action
- (void)loadHeaderData:(MJRefreshGifHeader *)mj{NSLog(@"load ");}
- (void)loadFooterData:(MJRefreshBackGifFooter *)mj{NSLog(@"load more");}

- (void)initNAVCBar
{
    [self.view addSubview:self.NAVCBar];
    self.NAVCBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, MS_StatusBarAndNavigationBarHeight);
}

- (void)setNAVCBarHidden:(BOOL)hidden arrowHidden:(BOOL)arrowHidden title:(NSString *)title
{
    self.NAVCBar.hidden = hidden;
    self.NAVCBar.strTitle = title;
    self.NAVCBar.btnBack.hidden = arrowHidden;
}

- (CGFloat)NAVCHeight
{
    return MS_StatusBarAndNavigationBarHeight;
}

- (SYNAVCBar *)NAVCBar
{
    if (!_NAVCBar) {
        _NAVCBar = [SYNAVCBar new];
        [_NAVCBar.btnBack addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _NAVCBar;
}

-(void)initBase
{
    // 设置应用的背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 不允许 viewController 自动调整，我们自己布局；如果设置为YES，视图会自动下移 64 像素
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 自定义返回按钮
- (void)setupLeftBarButton {
    // 自定义 leftBarButtonItem ，UIImageRenderingModeAlwaysOriginal 防止图片被渲染
    
    MSBarButtonItem *navLeftItem = [[MSBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"后退_pro.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
    self.navigationItem.leftBarButtonItem = navLeftItem;
    
    // 防止返回手势失效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)setRightBtn:(NSString *)btnTitle{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [right setTitleColor:ColorWhite forState:UIControlStateNormal];
    [right setTitle:btnTitle forState:UIControlStateNormal];
    [right addTarget:self action:@selector(doRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.NAVCBar addSubview:right];
    [right makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(KPXIMGWIDTH_UI(70), KPXIMGWIDTH_UI(50)));
        make.centerY.equalTo(self.NAVCBar.btnBack);
        make.right.equalTo(@(-10));
    }];
}

- (void)doRightBtnAction:(UIButton *)sender{}

- (void)setTitleVC:(NSString *)titleVC
{
    _titleVC = titleVC;
    
    LabelForNavBar *navTitleLabel = [[LabelForNavBar alloc] init];
    navTitleLabel.text = titleVC;
    self.navigationItem.titleView = navTitleLabel;
}

#pragma mark - 返回按钮的点击事件
- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //禁止返回
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
