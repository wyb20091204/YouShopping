//
//  FriendsCell.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const friends_Identify = @"friends_Identify";

@interface FriendsCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *friendNmaeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@property (strong,nonatomic)User *user;

@end
