//
//  ApplyAndNewCell.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/21.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ApplyAndNewCell.h"

@implementation ApplyAndNewCell

- (void)awakeFromNib {
    UIImage *image  = [UIImage imageNamed:@"aply"];
    self.backImgView.image = image;
    self.badgeValueLabel.layer.masksToBounds = YES;
    self.badgeValueLabel.layer.cornerRadius = 10;
    self.badgeValueLabel.hidden = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
