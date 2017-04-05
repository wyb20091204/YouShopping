//
//  AppDelegate.h
//  YouShopping
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftDrawerViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
// 抽屉 参数
@property(nonatomic, strong)LeftDrawerViewController *leftDrawerVC;
@property(nonatomic, strong)UINavigationController *mainNC;

@end

