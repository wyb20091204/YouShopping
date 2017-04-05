//
//  ApplyCell.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/23.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ApplyCell.h"

@implementation ApplyCell

- (void)awakeFromNib {
    
    self.agreeLabel.hidden = YES;
    self.refuseLabel.hidden = YES;
    
}


- (void)setNModel:(NewFriendModel *)nModel{
    if (_nModel != nModel) {
        _nModel = nil;
        _nModel = nModel;
    }
    self.IDLabel.text = nModel.nUserName;
    self.messageLabel.text = nModel.friendMessage;
}


- (IBAction)agreeAction:(id)sender {
    if (_applyCelldelegate && [_applyCelldelegate respondsToSelector:@selector(applyCellDidAgreeButttonAction:)]) {
        [_applyCelldelegate applyCellDidAgreeButttonAction:self];
    }
}

- (IBAction)refuseAction:(id)sender {
    if (_applyCelldelegate && [_applyCelldelegate respondsToSelector:@selector(applyCellDidRefuseButttonAction:)]) {
        [_applyCelldelegate applyCellDidRefuseButttonAction:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
