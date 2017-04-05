//
//  SetupTableViewCell.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/25.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *logonLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@end
