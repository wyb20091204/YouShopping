//
//  FriendChartCell.h
//  YouShopping
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartMessage.h"

static NSString *const FriendChatCell_Identify = @"FriendChatCell_Identify";


@interface FriendChartCell : UITableViewCell


@property (strong,nonatomic)ChartMessage *chartMessage;


@end
