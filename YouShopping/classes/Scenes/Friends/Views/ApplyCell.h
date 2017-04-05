//
//  ApplyCell.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/23.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewFriendModel.h"
@class ApplyCell;

static NSString *const ApplyCell_Identify = @"ApplyCell_Identify";

@protocol ApplyCellDelegate <NSObject>

- (void)applyCellDidAgreeButttonAction:(ApplyCell *)cell;
- (void)applyCellDidRefuseButttonAction:(ApplyCell *)cell;


@end


@interface ApplyCell : UITableViewCell


/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
/** 附加消息 */
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *refuseLabel;

@property (weak, nonatomic) IBOutlet UIButton *refuseButton;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (strong,nonatomic)NewFriendModel *nModel;

@property (weak,nonatomic)id<ApplyCellDelegate> applyCelldelegate;

@end
