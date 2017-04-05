//
//  RegisterViewController.m
//  优GO
//
//  Created by 李帅 on 16/7/12.
//  Copyright © 2016年 linda. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"




@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *againPassWordTF;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


// 跳回到进来的界面
- (IBAction)backMyAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerAction:(UIButton *)sender {
    //判断用户名,密码
    if (self.userNameTF.text.length == 0) {
        [self showAlertViewWithMessage:@"用户名不能为空"];
    } else if (self.passWordTF.text.length == 0){
        [self showAlertViewWithMessage:@"密码不能为空"];
    } else if (![self.passWordTF.text isEqualToString:self.againPassWordTF.text]){
        [self showAlertViewWithMessage:@"两次输入的密码不一致"];
    } else {
        [self registerUserInfo];
    }
    
}
// 注册
- (void)registerUserInfo{
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.userNameTF.text password:self.passWordTF.text];
    if (error==nil) {
        UIAlertController *alertView = [UIAlertController  alertControllerWithTitle:nil message:@"注册成功"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *goLoginAction = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
//            //TODO:跳到登录界面
            // 通过Block把注册时候的用户名传到登录界面
            self.registBlock(self.userNameTF.text);
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"还要注册" style:UIAlertActionStyleCancel handler:nil];
        [alertView addAction:goLoginAction];
        [alertView addAction:noAction];
        [self presentViewController:alertView animated:YES completion:nil];
    } else {
        [self showAlertViewWithMessage:@"啊呀用户名被使用了"];
    }


}

- (void)showAlertViewWithMessage:(NSString *)message
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:2];
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)dismissAlertView:(UIAlertController *)alertView
{
    [alertView dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
