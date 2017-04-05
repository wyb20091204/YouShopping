//
//  NameViewController.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^returnBlock)(NSString *string);
@interface NameViewController : BaseViewController

@property(nonatomic, copy)returnBlock block;
@end
