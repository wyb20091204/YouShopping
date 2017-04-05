//
//  SetupTableViewCell.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/25.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SetupTableViewCell.h"

@implementation SetupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageWidth.constant = kScreenWidth / 18;
    self.imageHeight.constant = kScreenWidth / 18;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
