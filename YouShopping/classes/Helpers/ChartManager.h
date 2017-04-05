//
//  ChartManager.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/27.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartManager : NSObject

+ (instancetype)shareChartManger;
/** 构造文字消息 */
- (EMMessage *)buildTextMessageWithText:(NSString *)text
                  ConverSationID:(NSString *)ID
                              to:(NSString *)to
                       chartType:(EMChatType)chartType;

/** 构造图片消息 */
- (void)buidPictrueMessagerWithImageName:(UIImage *)imageName
                          ConverSationID:(NSString *)ID
                                      to:(NSString *)to
                               chartType:(EMChatType)chartType;

/** 构造位置消息 */
- (void)buidAddressMeesageWithLatitude:(CGFloat)latitude
                             longitude:(CGFloat)longitude
                               address:(NSString *)address
                        ConverSationID:(NSString *)ID
                                    to:(NSString *)to
                             chartType:(EMChatType)chartType;

/** 构造语音消息 */
- (void)buidAudioMessageWithLocalPath:(NSString *)localPath
                          displayName:(NSString *)displayName
                       ConverSationID:(NSString *)ID
                                   to:(NSString *)to
                            chartType:(EMChatType)chartType;

/** 构造视频消息 */
- (void)buidVideoMessageWithLocalPath:(NSString *)localPath
                          displayName:(NSString *)displayName
                       ConverSationID:(NSString *)ID
                                   to:(NSString *)to
                            chartType:(EMChatType)chartType;
/** 构造文件消息 */
- (void)buidFileMessageWithLocalPath:(NSString *)localPath
                          displayName:(NSString *)displayName
                       ConverSationID:(NSString *)ID
                                   to:(NSString *)to
                            chartType:(EMChatType)chartType;

/** 构造透传消息 */
- (void)buidCmdMessageWithConversationID:(NSString *)conversationID
                                      to:(NSString *)to
                               chartType:(EMChatType)chartType;

/** 构造扩展消息 */


/** 插入消息 */



/** 更新消息属性 */


/** 新建/获取一个会话 */
- (void)buidAConversationWithFriendID:(NSString *)friendID type:(EMConversationType)conversationType;


/** 删除单个会话 */

- (void)deleteConversationWithFriendID:(NSString *)friendID;

/** 根据conversation批量删除会话 */
- (void)deletaConversationsWithFriendsIDArr:(NSArray *)friendsIDArr;

/** 获取或创建会话列表 */
- (EMConversation *)getConversationWithID:(NSString *)friendID type:(EMConversationType)conversationType;

/** 获取内存中所有会话 */
- (NSArray *)getAllConversations;
/** 获取DB中所有会话 */
- (NSArray *)getAllConversationsFromDB;
///** 获取会话未读消息数 */
//- (int)getUnreadMessageCount;










@end
