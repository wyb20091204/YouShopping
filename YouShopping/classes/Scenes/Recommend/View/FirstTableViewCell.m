//
//  FirstTableViewCell.m
//  YouShoping
//
//  Created by 李帅 on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AllModel *)model
{
    _model = model;
    self.typeLabel.text = model.user.category;
    [self.titleBtn setTitle:model.user.title forState:UIControlStateNormal];
    [self.dataView setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    self.contectLabel.text = model.title;
    self.likeLabel.text = [NSString stringWithFormat:@"%ld",model.likes_count];
}
- (IBAction)dateilPageAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(FirstTableviewPushBtnClicked:)]) {
        [_delegate FirstTableviewPushBtnClicked:self];
    }
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
