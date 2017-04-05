//
//  WCell.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather_data.h"

@interface WCell : UITableViewCell
@property (nonatomic, strong) Weather_data *wd;
@end
