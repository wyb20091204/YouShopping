//
//  AppDelegate+UMenSocial.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"


@interface AppDelegate (UMenSocial)

- (void)setUpUMenSocialWithAppKey:(NSString *)appKey;

@end
