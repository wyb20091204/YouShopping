//
//  WCell.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "WCell.h"
#import <UIImageView+AFNetworking.h>
@interface WCell()

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UILabel *temp;

@end

@implementation WCell
-(void)setWd:(Weather_data *)wd {
    
    _wd = wd;
    self.date.text = wd.date;
    [self.img setImageWithURL:[NSURL URLWithString:wd.dayPictureUrl]];
    self.weather.text = wd.weather;
    self.wind.text = wd.wind;
    self.temp.text = wd.temperature;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
