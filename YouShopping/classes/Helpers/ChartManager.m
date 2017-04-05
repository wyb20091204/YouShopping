//
//  ChartManager.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/27.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ChartManager.h"
static ChartManager *chartManager = nil;


@implementation ChartManager

+ (instancetype)shareChartManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chartManager = [ChartManager new];
    });
    return chartManager;
}


/** 构造文字消息 */
- (EMMessage *)buildTextMessageWithText:(NSString *)text
                  ConverSationID:(NSString *)ID
                              to:(NSString *)to
                       chartType:(EMChatType)chartType{
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:text];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:ID from:from to:ID body:body ext:nil];
    message.chatType = chartType;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
    return message;
}

/** 构造图片消息 */
- (void)buidPictrueMessagerWithImageName:(UIImage *)image
                          ConverSationID:(NSString *)ID
                                      to:(NSString *)to
                               chartType:(EMChatType)chartType{
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:@"imag.png"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:ID from:from to:ID body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
    
}

/** 构造位置消息 */
- (void)buidAddressMeesageWithLatitude:(CGFloat)latitude
                             longitude:(CGFloat)longitude
                               address:(NSString *)address
                        ConverSationID:(NSString *)ID
                                    to:(NSString *)to
                             chartType:(EMChatType)chartType{
    EMLocationMessageBody *body = [[EMLocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:address];
    NSString *from = [[EMClient sharedClient] currentUsername];
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:ID from:from to:ID body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
}

/** 构造语音消息 */
- (void)buidAudioMessageWithLocalPath:(NSString *)localPath
                          displayName:(NSString *)displayName
                       ConverSationID:(NSString *)ID
                                   to:(NSString *)to
                            chartType:(EMChatType)chartType{
    
    /*
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:@"audioPath" displayName:@"audio"];
    body.duration = duration;
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:ID from:from to:ID body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
     
    */
}

/** 构造视频消息 */
- (void)buidVideoMessageWithLocalPath:(NSString *)localPath
                          displayName:(NSString *)displayName
                       ConverSationID:(NSString *)ID
                                   to:(NSString *)to
                            chartType:(EMChatType)chartType{
    
    /*
    EMVideoMessageBody *body = [[EMVideoMessageBody alloc] initWithLocalPath:@"videoPath" displayName:@"video.mp4"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:@"6001" from:from to:@"6001" body:body ext:messageExt];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
     */
    
    
}
/** 构造文件消息 */
- (void)buidFileMessageWithLocalPath:(NSString *)localPath
                         displayName:(NSString *)displayName
                      ConverSationID:(NSString *)ID
                                  to:(NSString *)to
                           chartType:(EMChatType)chartType{
    /*
     EMCmdMessageBody *body = [[EMCmdMessageBody alloc] initWithAction:action];
     NSString *from = [[EMClient sharedClient] currentUsername];
     
     // 生成message
     EMMessage *message = [[EMMessage alloc] initWithConversationID:@"6001" from:from to:@"6001" body:body ext:messageExt];
     message.chatType = EMChatTypeChat;// 设置为单聊消息
     //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
     //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
     */
    
}

/** 构造透传消息 */
- (void)buidCmdMessageWithConversationID:(NSString *)conversationID
                                      to:(NSString *)to
                               chartType:(EMChatType)chartType{
    /*
    EMCmdMessageBody *body = [[EMCmdMessageBody alloc] initWithAction:action];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:@"6001" from:from to:@"6001" body:body ext:messageExt];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
     */
    
}

/** 构造扩展消息 */


/** 插入消息 */



/** 更新消息属性 */


/** 新建/获取一个会话 */
- (void)buidAConversationWithFriendID:(NSString *)friendID type:(EMConversationType)conversationType{
    [[EMClient sharedClient].chatManager getConversation:friendID type:conversationType createIfNotExist:YES];
    //EMConversationTypeChat            单聊会话
    //EMConversationTypeGroupChat       群聊会话
    //EMConversationTypeChatRoom        聊天室会话
}


/** 删除单个会话 */

- (void)deleteConversationWithFriendID:(NSString *)friendID{
    [[EMClient sharedClient].chatManager deleteConversation:friendID deleteMessages:YES];

}

/** 根据conversation批量删除会话 */
- (void)deletaConversationsWithFriendsIDArr:(NSArray *)friendsIDArr{
    [[EMClient sharedClient].chatManager deleteConversations:friendsIDArr deleteMessages:YES];

}

/** 获取或创建会话列表 */
- (EMConversation *)getConversationWithID:(NSString *)friendID type:(EMConversationType)conversationType{
    
    return [[EMClient sharedClient].chatManager getConversation:friendID type:conversationType createIfNotExist:YES];

    
}

/** 获取内存中所有会话 */
- (NSArray *)getAllConversations{
    return [[EMClient sharedClient].chatManager getAllConversations];
}
/** 获取DB中所有会话 */
- (NSArray *)getAllConversationsFromDB{
    return [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
}
///** 获取会话未读消息数 */
//- (int)getUnreadMessageCount{
//    int count =[EMConversation unreadMessagesCount];
//    
//    return count;
//}








@end
