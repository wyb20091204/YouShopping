//
//  userDefaults.h
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface userDefaults : NSObject

/**
 *  存储用户信息
 *
 *  @param user 用户对象
 */
+ (void)saveUserInfo:(User *)user;

/**
 *  获取用户信息
 *
 *  @return 有用户信息的用户
 */
+ (User *)getUserInfo;

/**
 *  删除用户信息
 */
+ (void)removeUserInfo;

@end
