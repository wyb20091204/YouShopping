//
//  AppDelegate+UMenSocial.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AppDelegate+UMenSocial.h"



@implementation AppDelegate (UMenSocial)


- (void)setUpUMenSocialWithAppKey:(NSString *)appKey{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:appKey];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f"
                            appSecret:@"db426a9829e4b49a0dcac7b4162da6b6"
                                  url:@"http://www.umeng.com/social"];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要
    [UMSocialQQHandler setQQWithAppId:@"100424468"
                               appKey:@"c7394704798a158208a74ab60104f0ba"
                                  url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"65135572"
                                              secret:@"4563416c6e3cbfc47db6b6044e807846"
                                         RedirectURL:@"https://itunes.apple.com/cn/genre/yin-le/id34"];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];

}

@end
