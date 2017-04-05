//
//  PersonInformationViewController.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^returnToDrawerBlock)(NSString *string);
@interface PersonInformationViewController : BaseViewController

@property(nonatomic, strong)returnToDrawerBlock block;
@end
