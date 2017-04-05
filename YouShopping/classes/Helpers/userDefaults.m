//
//  userDefaults.m
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "userDefaults.h"
/**
 *  存储对象类型
 */
#define kUserObjectDefaults(object,key)\
[[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
/**
 *  存储bool类型
 */
#define kUserBoolDefaults(value,key)\
[[NSUserDefaults standardUserDefaults] setBool:value forKey:key]
/**
 *  获取对象类型
 */
#define kGetObjectUserDefaults(key)\
[[NSUserDefaults standardUserDefaults] objectForKey:key]
/**
 *  获取bool类型
 */
#define kGetBoolUserDefaults(key)\
[[NSUserDefaults standardUserDefaults] boolForKey:key]

@implementation userDefaults

/**
 *  存储用户信息
 *
 *  @param user 用户
 */
+ (void)saveUserInfo:(User *)user{
    kUserObjectDefaults(user.userId, @"userId");
    kUserObjectDefaults(user.userName, @"userName");
    kUserObjectDefaults(user.password, @"password");
    kUserBoolDefaults(user.loginState, @"loginState");
}
/**
 *  获取用户信息
 *
 *  @return 用户
 */
+ (User *)getUserInfo{
    User *user = [[User alloc] init];
    user.userId = kGetObjectUserDefaults(@"userId");
    user.userName = kGetObjectUserDefaults(@"userName");
    user.password = kGetObjectUserDefaults(@"password");
    user.loginState = kGetBoolUserDefaults(@"loginState");
    return user;
}
/**
 *  删除用户信息
 */
+ (void)removeUserInfo{
    kUserObjectDefaults(nil, @"userId");
    kUserObjectDefaults(nil, @"userName");
    kUserObjectDefaults(nil, @"password");
    kUserBoolDefaults(NULL, @"loginState");
}

@end
