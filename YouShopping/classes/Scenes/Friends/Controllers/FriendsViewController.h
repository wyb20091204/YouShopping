//
//  FriendsViewController.h
//  YouShop
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"

@interface FriendsViewController : BaseViewController
/** 好友数组 */
@property (strong,nonatomic)NSMutableArray *friendsMuArr;
/** 会话消息数组 */
@property (strong,nonatomic)NSMutableArray *messageMuArr;
/** 消息数 */
@property (assign,nonatomic)NSString *messageCount;
/** 消息数组 */
@property (strong,nonatomic)NSArray *nMessageArr;
/** 黑名单数组 */
@property (strong,nonatomic)NSMutableArray *blackListMuArr;
/** 用户 */
@property (strong,nonatomic)User *user;


@end
