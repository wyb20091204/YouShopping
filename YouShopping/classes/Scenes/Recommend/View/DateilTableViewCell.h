//
//  DateilTableViewCell.h
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DateilTableViewCell_ID @"DateilTableViewCell_ID"
#import "FirstDateilModel.h"

@interface DateilTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (nonatomic, strong)FirstDateilModel *model;

@end
