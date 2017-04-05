//
//  CommentTableViewCell.m
//  YouShopping
//
//  Created by 李帅 on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headerView.layer.masksToBounds = YES;
    self.headerView.layer.cornerRadius = self.headerView.bounds.size.width/2.0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommentModel *)model
{
    _model = model;
    [_headerView setImageWithURL:[NSURL URLWithString:model.avatar_url]];
    _nameLabel.text = model.nickname;
    _contectLabel.text = model.content;
    _praiseLabel.text = [NSString stringWithFormat:@"%ld",model.likes_count];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    CGFloat totalTime = ((NSInteger)nowTime - model.created_at)/1000.0;
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


}
- (IBAction)addAction:(UIButton *)sender {
    sender.tag = !sender.tag;
    if (sender.tag) {
        [sender setImage:[UIImage imageNamed:@"good"] forState:UIControlStateNormal];
        self.praiseLabel.text = [NSString stringWithFormat:@"%ld",_model.likes_count + 1];
    }else
    {
        [sender setImage:[UIImage imageNamed:@"goodH"] forState:UIControlStateNormal];
        self.praiseLabel.text = [NSString stringWithFormat:@"%ld",_model.likes_count];
    }

}


@end
