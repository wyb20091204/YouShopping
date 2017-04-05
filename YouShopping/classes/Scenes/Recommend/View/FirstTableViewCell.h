//
//  FirstTableViewCell.h
//  YouShoping
//
//  Created by 李帅 on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllModel.h"
@class FirstTableViewCell;

@protocol FirstTableViewCellDelegate <NSObject>

- (void)FirstTableviewPushBtnClicked:(FirstTableViewCell *)cell;

@end


#define FirstTableViewCell_Id @"FirstTableViewCell_Id"
@interface FirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (weak, nonatomic) IBOutlet UIImageView *dataView;
@property (weak, nonatomic) IBOutlet UILabel *contectLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (assign, nonatomic) id<FirstTableViewCellDelegate>delegate;

@property (strong, nonatomic) AllModel *model;

@end
