//
//  OrdersTableViewCell.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/29.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@end
