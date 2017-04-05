//
//  AddFriendCell.m
//  YouShopping
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell

- (void)awakeFromNib {
    
    UIImage *image = [UIImage imageNamed:@"addHeaderP"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.friendHeaderImgView.image = image;
    
    // Initialization code
}


- (IBAction)addAction:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(addFriendsViewControllerDidCellAddButtonAction:)]) {
        [_delegate addFriendsViewControllerDidCellAddButtonAction:self];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
