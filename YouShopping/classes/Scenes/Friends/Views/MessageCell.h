//
//  MessageCell.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"


static NSString *const messageCell_Identify = @"messageCell_Identify";


@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *friendHeaderImgeView;

@property (weak, nonatomic) IBOutlet UILabel *friendsIDLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastMessageLabel;

@property (weak, nonatomic) IBOutlet UILabel *unreadMessageLabel;

@property (strong,nonatomic)MessageModel *messageModel;



@end
