//
//  User.h
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/** 用户名 */
@property (strong,nonatomic)NSString *userName;
/** 密码 */
@property (strong,nonatomic)NSString *password;
/** 用户ID */
@property (strong,nonatomic)NSString *userId;
/** 头像名 */
@property (strong,nonatomic)NSString *avatar;
/** 是否登录 */
@property (assign,nonatomic)BOOL	 loginState;

@end
