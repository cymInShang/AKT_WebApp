//
//  LoginViewController.m
//  AKT_webApp
//
//  Created by 常永梅 on 2019/8/19.
//  Copyright © 2019 常永梅. All rights reserved.
//

#import "LoginViewController.h"
#import "AktLoginCmd.h"
#import "YWLWebBaseVC.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfActivityCode;
@property (weak, nonatomic) IBOutlet UITextField *tfUserCode;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.btnLogin.layer.masksToBounds = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"OId"]) {
        self.tfActivityCode.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"OId"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AId"]) {
        self.tfUserCode.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"AId"];
    }
}

- (IBAction)btnLoginUserAction:(id)sender {
    [[AppDelegate sharedDelegate] showLoadingHUD:self.view msg:@""];
    [[[AktLoginCmd alloc] init] requestLoginWithPhone:self.tfActivityCode.text code:self.tfUserCode.text success:^(id Object) {
        NSDictionary *dic = Object;
        if ([dic objectForKey:@"assessOrganizeId"] && [dic objectForKey:@"assessor"]) {
            YWLWebBaseVC *webbase = [[YWLWebBaseVC alloc] init];
            [self.navigationController pushViewController:webbase animated:YES];
        }
        [[AppDelegate sharedDelegate] hidHUD];
    }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.tfActivityCode resignFirstResponder];
    [self.tfUserCode resignFirstResponder];
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
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
