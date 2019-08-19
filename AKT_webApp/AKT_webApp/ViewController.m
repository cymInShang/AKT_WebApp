//
//  ViewController.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "ViewController.h"
#import "AKT_BaseWebVC.h"
#import "AktLoginCmd.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfActivityCode;
@property (weak, nonatomic) IBOutlet UITextField *tfUserCode;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnLoginUserAction:(id)sender {
//    [[[AktLoginCmd alloc] init] requestLoginWithPhone:self.tfActivityCode.text code:self.tfUserCode.text success:^(id Object) {
//        NSDictionary *dic = Object;
//    }];
    
    AKT_BaseWebVC *web = [AKT_BaseWebVC new];
    [self.navigationController pushViewController:web animated:YES];
}

@end
