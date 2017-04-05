//
//  SaveTableViewCell.h
//  YouShopping
//
//  Created by 李帅 on 16/8/2.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SaveTableViewCell_ID @"SaveTableViewCell_ID"
@interface SaveTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
