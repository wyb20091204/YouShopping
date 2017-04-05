//
//  AppDelegate+HuanXin.m
//  YouShopping
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AppDelegate+HuanXin.h"



@implementation AppDelegate (HuanXin)

- (void)setUpHuanXinWithAppKey:(NSString *)appKey andApnsCertName:(NSString *)apnsCertName{
    
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:appKey];
    options.apnsCertName = apnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
   
}



@end
