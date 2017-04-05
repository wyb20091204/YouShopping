//
//  MessageModel.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/29.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_friendID forKey:@"friendID"];
    [aCoder encodeObject:_lastMessage forKey:@"lastMessage"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _friendID = [aDecoder decodeObjectForKey:@"friendID"];
        _lastMessage = [aDecoder decodeObjectForKey:@"lastMessage"];
    }
    return self;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,,%@", _friendID,_lastMessage];
}

@end
