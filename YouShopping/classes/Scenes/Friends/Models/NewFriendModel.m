//
//  NewFriendModel.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/21.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "NewFriendModel.h"

@implementation NewFriendModel

- (instancetype)initWithName:(NSString *)nUserName nMessage:(NSString *)friendMessage{
    
    if (self = [super init]) {
        _nUserName = nUserName;
        _friendMessage = friendMessage;
    }
    return self;
}


+ (instancetype)newFriendModelWithName:(NSString *)nUserName nMessage:(NSString *)friendMessage{
    
    return [[self alloc] initWithName:nUserName nMessage:friendMessage];
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"nUserName : %@,friendMessage : %@", _nUserName,_friendMessage];
}




@end
