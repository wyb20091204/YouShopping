//
//  AlarmTableViewCell.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
