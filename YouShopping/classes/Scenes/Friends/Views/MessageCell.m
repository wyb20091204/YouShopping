//
//  MessageCell.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    self.unreadMessageLabel.layer.masksToBounds = YES;
    self.unreadMessageLabel.layer.cornerRadius = 10;
    self.unreadMessageLabel.hidden = YES;
    
}

- (void)setMessageModel:(MessageModel *)messageModel{
    if (_messageModel != messageModel) {
        _messageModel = nil;
        _messageModel = messageModel;
    }
    
    _friendsIDLabel.text = messageModel.friendID;
    _lastMessageLabel.text = messageModel.lastMessage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
