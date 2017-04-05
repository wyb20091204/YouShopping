//
//  PersonInformationTableViewCell.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "PersonInformationTableViewCell.h"

@implementation PersonInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.myImageView.layer.masksToBounds = YES;
    self.myImageView.layer.cornerRadius = self.myImageView.frame.size.height / 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
