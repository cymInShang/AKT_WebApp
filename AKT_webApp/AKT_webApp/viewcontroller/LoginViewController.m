//
//  LoginViewController.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "LoginViewController.h"
#import "AktLoginCmd.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfActivityCode;
@property (weak, nonatomic) IBOutlet UITextField *tfUserCode;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnLoginUserAction:(id)sender {
    //    [[[AktLoginCmd alloc] init] requestLoginWithPhone:self.tfActivityCode.text code:self.tfUserCode.text success:^(id Object) {
    //        NSDictionary *dic = Object;
    //    }];
    [self dismissViewControllerAnimated:YES completion:nil];
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
