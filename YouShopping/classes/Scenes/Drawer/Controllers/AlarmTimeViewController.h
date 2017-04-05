//
//  AlarmTimeViewController.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/18.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"
// 代理 ---- 向前一个页面传值
@protocol ReturnAlarmTimeActionDelegate <NSObject>

- (void)passAlarmTimeWithSet:(NSMutableSet *)aSet
                       array:(NSMutableArray *)aArray;

@end

@interface AlarmTimeViewController : BaseViewController

@property(nonatomic, weak)id<ReturnAlarmTimeActionDelegate> delegate;
// 属性传值 --- 从前个页面拿值
@property(nonatomic, strong)NSMutableArray *hideArr;


@end
