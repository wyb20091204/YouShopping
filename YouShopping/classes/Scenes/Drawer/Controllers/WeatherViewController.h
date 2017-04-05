//
//  WeatherViewController.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^retrunToDrawerBlock)(NSString *cityName, NSString *temp);
@interface WeatherViewController : BaseViewController

@property(nonatomic, copy)retrunToDrawerBlock block;
@end
