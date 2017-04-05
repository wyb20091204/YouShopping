//
//  User.m
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "User.h"

@implementation User

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"userName:%@ password:%@ userId:%@ avatar:%@ loginState:%d", _userName,_password,_userId,_avatar,_loginState];
}

@end
