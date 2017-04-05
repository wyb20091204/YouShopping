//
//  ApplyViewController.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/21.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"
#import "NewFriendModel.h"

typedef void(^newFriend)(NSMutableArray *agreeMuArr);


@interface ApplyViewController : BaseViewController


@property (strong,nonatomic)NSMutableArray *tempMuArr;

/** 把同意后的新好友名字传出去的Block */
@property (copy,nonatomic)newFriend newFriendBlock;


@property (strong,nonatomic)NewFriendModel *nModel;



@end
