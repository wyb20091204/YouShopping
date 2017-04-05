//
//  LoginViewController.m
//  优GO
//
//  Created by 李帅 on 16/7/12.
//  Copyright © 2016年 linda. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"
#import "FriendsViewController.h"
#import "FriendsManager.h"

//static LoginViewController *loginVC =nil;

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation LoginViewController

//+ (instancetype)shareLonginController{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        loginVC = [LoginViewController new];
//    });
//    return loginVC;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ===== 不登录了返回 =====

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark ===== 去注册 ======

- (IBAction)registerAction:(UIButton *)sender {
    RegisterViewController *registerVC = [RegisterViewController new];
    // 展开Block
    registerVC.registBlock = ^(NSString *text){
        self.userNameTF.text = text;
    };
    [self presentViewController:registerVC animated:YES completion:nil];
}

#pragma mark ===== 登录 =====

- (IBAction)loginAction:(UIButton *)sender {
 
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.userNameTF.text password:self.passWordTF.text];
    if (!error) {
        
        // 设置自动登录
        [[EMClient sharedClient].options setIsAutoLogin:YES];

        //跳转登录成功后操作
        User *user = [User new];
        user.userId = self.userNameTF.text;
        user.password = self.passWordTF.text;
        user.loginState = YES;      // 登录状态为YES
        // 将登陆状态存储本地
        [userDefaults saveUserInfo:user];
//        // 获取好友列表
        /*
//        NSArray *arr = [[FriendsManager shareFriendsManager] requestFriendsListWithNet];
//        NSArray *blackArr = [[FriendsManager shareFriendsManager] requestBlackListWithNet];
//        // 发送登录后得到好友通知
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"longinGetFriendsArr" object:nil userInfo:@{@"getFriendsArr":arr,@"getBlackList":blackArr}];
         */
        
        

        // 回到tabbarController
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self showAlertViewWithMessage:@"用户名或密码错误"];
//        NSLog(@"login error = %@",error.description);
    }

}

#pragma mark ===== 忘记密码 ======
- (IBAction)forgotPassWord:(id)sender {
    [self  showAlertViewWithMessage:@"对不起,我们没有后台找回密码!忘记密码你就重新注册一个吧"];
    
}

#pragma markr ===== AlertView ===== 

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
