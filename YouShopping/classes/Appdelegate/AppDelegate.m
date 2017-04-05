//
//  AppDelegate.m
//  YouShopping
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "DrawerViewController.h"
#import "AppDelegate+HuanXin.h"
#import "AppDelegate+UMenSocial.h"
#import "AppDelegate+BaiduMap.h"




@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //
    RootViewController *rootVC = [RootViewController new];
    DrawerViewController *drawerVC = [DrawerViewController new];
    
    
    self.mainNC = [[UINavigationController alloc]initWithRootViewController:rootVC];
    self.mainNC.navigationBar.hidden = YES;
    self.leftDrawerVC = [[LeftDrawerViewController alloc]initWithLeftView:drawerVC mainView:self.mainNC];
    
    self.window.rootViewController = self.leftDrawerVC;
    [self.window makeKeyAndVisible];
    
    // 环信
    [self setUpHuanXinWithAppKey:@"wyb2010#youshoping" andApnsCertName:@"DevPush"];
    //添加自动登录回调监听代理:
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    //    友盟分享
    [self setUpUMenSocialWithAppKey:@"578e10c767e58e570f0035f9"];
    
    // 百度
    [self setBaiduManegerWithKey:@"euSwG3BYI3sDoECROy61hAqF7yquQa7N"];
    
    return YES;
}

// 自动登录回调
- (void)didAutoLoginWithError:(EMError *)aError{
//    NSLog(@"自动登录成功");
}


#pragma mark - 添加系统回调
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    // 环信APP进入后台
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    // 环信APP将要从后台返回
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
