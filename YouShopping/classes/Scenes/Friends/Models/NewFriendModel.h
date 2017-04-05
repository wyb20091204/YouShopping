//
//  NewFriendModel.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/21.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewFriendModel : NSObject

@property (strong,nonatomic)NSString *nUserName;
@property (strong,nonatomic)NSString *friendMessage;

- (instancetype)initWithName:(NSString *)nUserName nMessage:(NSString *)friendMessage;
+ (instancetype)newFriendModelWithName:(NSString *)nUserName nMessage:(NSString *)friendMessage;

@end
