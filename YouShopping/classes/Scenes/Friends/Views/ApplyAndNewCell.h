//
//  ApplyAndNewCell.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/21.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const applyAndNewCell_Identify = @"applyAndNewCell_Identify";

@interface ApplyAndNewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImgView;

@property (weak, nonatomic) IBOutlet UILabel *badgeValueLabel;


@end
