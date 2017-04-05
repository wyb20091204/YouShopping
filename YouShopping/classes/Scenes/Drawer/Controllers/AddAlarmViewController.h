//
//  AddAlarmViewController.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"

@protocol passToAlarmViewDelegate <NSObject>


- (void)passToAlarmViewDelegateWithTitle:(NSString *)title
                                    date:(NSString *)date
                                    time:(NSString *)time;

@end
@interface AddAlarmViewController : BaseViewController


@property(nonatomic, weak)id<passToAlarmViewDelegate> delegate;

@end
