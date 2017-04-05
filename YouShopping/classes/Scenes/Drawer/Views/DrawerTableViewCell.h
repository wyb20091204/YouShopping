//
//  DrawerTableViewCell.h
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@end
