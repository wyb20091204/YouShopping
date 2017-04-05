//
//  CommentTableViewCell.h
//  YouShopping
//
//  Created by 李帅 on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

#define CommentTableViewCell_ID @"CommentTableViewCell_ID"

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contectLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;

@property (nonatomic, strong) CommentModel *model;

@end
