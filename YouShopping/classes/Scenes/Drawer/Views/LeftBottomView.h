//
//  LeftBottomView.h
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherButton.h"


@class LeftBottomView;
@protocol DrawerBOttomViewDelegate <NSObject>

- (void)setUpButtonAction;

- (void)alarmClockButtonAction;

- (void)weatherButtonAction;

@end
@interface LeftBottomView : UIView
// 设置按钮
@property(nonatomic, strong)UIButton *setUpButton;
// 设置label
@property(nonatomic, strong)UILabel *setUpLabel;
// 闹铃按钮
@property(nonatomic, strong)UIButton *alarmClockButton;
// 闹铃label
@property(nonatomic, strong)UILabel *alarmClockLabel;

// 天气button
@property(nonatomic, strong)WeatherButton *weatherButton;

// 代理
@property(nonatomic, assign)id<DrawerBOttomViewDelegate> delegate;
@end
