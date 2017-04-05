//
//  FriendsManager.m
//  YouShopping
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FriendsManager.h"

static FriendsManager *friendsSingleTon  = nil;

@implementation FriendsManager

+ (instancetype)shareFriendsManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        friendsSingleTon = [FriendsManager new];
    });
    return friendsSingleTon;
}

#pragma mark ===== 添加好友 =====
- (void)addFriendWithName:(NSString *)friendName message:(NSString *)aMessage{
    EMError *error = [[EMClient sharedClient].contactManager addContact:friendName message:aMessage];
    if (!error) {
//        NSLog(@"发送添加成功");
    }
}

#pragma mark ==== 删除好友 =====
- (void)deleteFriendWithName:(NSString *)userName{
    EMError *error = [[EMClient sharedClient].contactManager deleteContact:userName];
    if (!error) {
//        NSLog(@"删除%@成功",userName);
    }
    
}

#pragma mark ==== 从服务器获取好友列表 ====
- (NSArray *)requestFriendsListWithNet{
    NSArray *arr = nil;
    EMError *error = nil;
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
//        NSLog(@"获取好友列表成功 -- %@",userlist);
        arr = userlist;
    }
    return arr;
}

#pragma mark ====== 从本地数据获取好友列表 ======
- (NSArray *)requestFriendsListWithManager{
    return [[EMClient sharedClient].contactManager getContactsFromDB];
}


#pragma mark ====== 从网络获取黑名单列表 ======
- (NSArray *)requestBlackListWithNet{
    EMError *error = nil;
    NSArray *blacklist = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];
    if (!error) {
//        NSLog(@"获取黑名单成功 -- %@",blacklist);
    }
    return blacklist;
}
#pragma mark ====== 从本地获取黑名单列表 ======
- (NSArray *)requestBlackListWithManager{
    return  [[EMClient sharedClient].contactManager getBlackListFromDB];
}


#pragma mark ===== 将好友添加到黑名单 ====
- (BOOL)moveFriendToBlackListWithUserName:(NSString *)userName{
    EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:userName relationshipBoth:YES];
    if (!error) {
//        NSLog(@"将%@添加黑名单成功",userName);
        return YES;
    } else {
        return NO;
    }
}

#pragma mark ===== 将好友从黑名单移除 =====
- (void)removeBlackListWithUserName:(NSString *)userName{
    EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:userName];
    if (!error) {
//        NSLog(@"将%@移出黑名单成功",userName);
    }
}

#pragma mark ====== 同意好友请求 ===== 
- (void)agreeRuestWithName:(NSString *)userName{
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:userName];
    if (!error) {
//        NSLog(@"发送同意成功");
    }
}

#pragma mark ====== 拒绝好友请求 ===== 
- (void)refuseRuestWithName:(NSString *)userName{
    EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:userName];
    if (!error) {
//        NSLog(@"发送拒绝成功");
    }
}


#pragma mark ===== 退出登录 =====
- (BOOL)loginOut{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
//        NSLog(@"退出成功");
        return YES;
    } else {
        return NO;
    }
}



@end
