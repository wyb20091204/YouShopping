//
//  WeatherButton.m
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "WeatherButton.h"

@implementation WeatherButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        

        // 设置label大小以及位置
        self.temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2 / 3)];
        self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.temperatureLabel.frame), self.frame.size.width, self.frame.size.height / 3)];
        
        // 设置label 字体颜色
        self.temperatureLabel.textColor = [UIColor whiteColor];
        self.cityLabel.textColor = [UIColor whiteColor];
        
        // 设置label 字号和大小
        self.temperatureLabel.font = [UIFont fontWithName:@"Helvetica" size:kScreenWidth / 12];
        self.cityLabel.font = [UIFont fontWithName:@"宋体-简" size:kScreenWidth / 22];
        
        
        self.myImageViewt = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth / 7, kScreenWidth / 7)];
        self.myImageViewt.image = [UIImage imageNamed:@"weather"];
        
//        self.myImageViewq = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width, self.frame.size.height)];
//        self.myImageViewq.image = [UIImage imageNamed:@"qi"];
        // 添加到self
        [self addSubview:self.temperatureLabel];
        [self addSubview:self.cityLabel];
        [self addSubview:self.myImageViewt];
//        [self addSubview:self.myImageViewq];
    }
    return self;
}

@end
