//
//  MessageModel.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/29.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject<NSCoding>

@property (strong,nonatomic)NSString *lastMessage;
@property (strong,nonatomic)NSString *friendID;
@property (assign,nonatomic)NSInteger timestamp;

@end
