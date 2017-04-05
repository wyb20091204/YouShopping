//
//  DateilTableViewCell.m
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "DateilTableViewCell.h"

@implementation DateilTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.addBtn setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state1468544663
}

- (void)setModel:(FirstDateilModel *)model
{
    _model = model;
    [self.titleView setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    self.titleLabel.text = model.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd/ HH:mm:ss"];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    CGFloat totalTime = ((NSInteger)nowTime - model.updated_at)/1000.0;
    NSInteger day = totalTime/86400;
    NSInteger hour = totalTime/3600;
    NSInteger min = totalTime/60;
    if (day > 0) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld天前",day];
    } else if (hour > 0) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld小时前",hour];
    } else if (min > 0){
        self.timeLabel.text = [NSString stringWithFormat:@"%ld分钟前",min];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"小于1分钟"];
    }

    self.nameLabel.text = model.nickname;
    self.likeLabel.text = [NSString stringWithFormat:@"%ld",model.likes_count];
}
- (IBAction)addAction:(UIButton *)sender {
    sender.tag = !sender.tag;
    if (sender.tag) {
        [sender setImage:[UIImage imageNamed:@"starY"] forState:UIControlStateNormal];
        self.likeLabel.text = [NSString stringWithFormat:@"%ld",_model.likes_count + 1];
    }else
    {
        [sender setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        self.likeLabel.text = [NSString stringWithFormat:@"%ld",_model.likes_count];
    }

}

@end
