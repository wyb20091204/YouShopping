//
//  AlarmTableViewCell.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AlarmTableViewCell.h"

@implementation AlarmTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dateLabel.font = [UIFont systemFontOfSize:kScreenWidth / 22];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
