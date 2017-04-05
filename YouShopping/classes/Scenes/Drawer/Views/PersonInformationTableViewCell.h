//
//  PersonInformationTableViewCell.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInformationTableViewCell : UITableViewCell
// cell标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 详情label
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
//
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
// 向右的箭头
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@end
