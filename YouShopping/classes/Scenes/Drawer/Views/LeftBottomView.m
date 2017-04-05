//
//  LeftBottomView.m
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "LeftBottomView.h"

@implementation LeftBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景颜色 - 透明
        self.backgroundColor = [UIColor clearColor];
        
        // 设置button,label 位置以及大小
        self.setUpButton = [[UIButton alloc]initWithFrame:CGRectMake(20, self.frame.size.height / 2, kScreenWidth / 17, kScreenWidth / 17)];
        self.setUpLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.setUpButton.frame), CGRectGetMinY(self.setUpButton.frame), kScreenWidth / 9, CGRectGetHeight(self.setUpButton.frame))];
        self.alarmClockButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.setUpLabel.frame) + kScreenWidth / 50, CGRectGetMinY(self.setUpButton.frame), CGRectGetWidth(self.setUpButton.frame), CGRectGetHeight(self.setUpButton.frame))];
        self.alarmClockLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.alarmClockButton.frame), CGRectGetMinY(self.setUpButton.frame), CGRectGetWidth(self.setUpLabel.frame), CGRectGetHeight(self.setUpButton.frame))];
        
        // 设置button图案
        [self.setUpButton setImage:[UIImage imageNamed:@"setUp"] forState:(UIControlStateNormal)];
        [self.alarmClockButton setImage:[UIImage imageNamed:@"alarmClock"] forState:(UIControlStateNormal)];
        
        // 设置label 字体字号
        self.setUpLabel.font = [UIFont fontWithName:@"宋体-简" size:kScreenWidth / 22];
        self.alarmClockLabel.font = [UIFont fontWithName:@"宋体-简" size:kScreenWidth / 22];
        // 设置label 内容
        self.setUpLabel.text = @"设置";
        self.alarmClockLabel.text = @"提醒";
        // 设置label 字体颜色
        self.setUpLabel.textColor = [UIColor whiteColor];
        self.alarmClockLabel.textColor = [UIColor whiteColor];
        
        // 天气button
        self.weatherButton = [[WeatherButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.alarmClockLabel.frame), 0, kScreenWidth / 5, kScreenWidth / 5)];
        
        // 添加到view上
        [self addSubview:self.setUpButton];
        [self addSubview:self.setUpLabel];
        [self addSubview:self.alarmClockButton];
        [self addSubview:self.alarmClockLabel];
        [self addSubview:self.weatherButton];
        
        // 设置button点击方法
        [self.setUpButton addTarget:self action:@selector(setUpButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
        [self.alarmClockButton addTarget:self action:@selector(alarmClockButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
        [self.weatherButton addTarget:self action:@selector(weatherButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

- (void)setUpButtonClicked{
    if (_delegate && [_delegate respondsToSelector:@selector(setUpButtonAction)]) {
        [_delegate setUpButtonAction];
    }
}

- (void)alarmClockButtonClicked{
    if (_delegate && [_delegate respondsToSelector:@selector(alarmClockButtonAction)]) {
        [_delegate alarmClockButtonAction];
    }
}

- (void)weatherButtonClicked{
    if (_delegate && [_delegate respondsToSelector:@selector(weatherButtonAction)]) {
        [_delegate weatherButtonAction];
    }
}
@end
