//
//  FriendsCell.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setUser:(User *)user{
    if (_user != user) {
        _user = nil;
        _user = user;
    }
    
    _friendNmaeLabel.text = user.userName;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
