//
//  FriendsManager.h
//  YouShopping
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsManager : NSObject

+ (instancetype)shareFriendsManager;



/**
 *  添加好友
 *
 *  @param friendName 想要添加的好友名称
 */
- (void)addFriendWithName:(NSString *)friendName message:(NSString *)aMessage;
/**
 *  删除好友
 *
 *  @param userName 好友ID
 */
- (void)deleteFriendWithName:(NSString *)userName;
/**
 *  从网络获取好友列表
 *
 *  @return 好友数组
 */
- (NSArray *)requestFriendsListWithNet;
/**
 *  从本地数据获取好友列表
 *
 *  @return 好友数组
 */
- (NSArray *)requestFriendsListWithManager;
/**
 *  从网络获取黑名单列表
 *
 *  @return 黑名单列表
 */
- (NSArray *)requestBlackListWithNet;
/**
 *  从本地获取黑名单列表
 *
 *  @return 黑名单列表
 */
- (NSArray *)requestBlackListWithManager;

/**
 *  将好友移到黑名单
 *
 *  @param userName 好友ID
 */
- (BOOL)moveFriendToBlackListWithUserName:(NSString *)userName;
/**
 *  将好友从黑名单删除
 *
 *  @param userName 好友ID
 */
- (void)removeBlackListWithUserName:(NSString *)userName;

/**
 *  同意好友请求
 *
 *  @param userName 好友ID
 */
- (void)agreeRuestWithName:(NSString *)userName;
/**
 *  拒绝好友请求
 *
 *  @param userName 好友ID
 */
- (void)refuseRuestWithName:(NSString *)userName;
/**
 *  退出登录
 */
- (BOOL)loginOut;

@end
