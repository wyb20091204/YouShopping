//
//  DrawerTableViewCell.m
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "DrawerTableViewCell.h"

@implementation DrawerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.font = [UIFont fontWithName:@"简-宋体" size:kScreenWidth / 16];
    self.imageWidth.constant = kScreenWidth / 18;
    self.imageHeight.constant = kScreenWidth / 18;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
