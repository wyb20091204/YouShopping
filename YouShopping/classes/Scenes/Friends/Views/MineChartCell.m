//
//  MineChartCell.m
//  YouShopping
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "MineChartCell.h"


@interface MineChartCell ()

@property (strong,nonatomic)UILabel *contentLabel;
@property (strong,nonatomic)UIImageView *headerImageView;
@property (strong,nonatomic)UIImageView *contentImgView;

@end

@implementation MineChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _contentImgView = [UIImageView new];
        _headerImageView = [UIImageView new];
        _contentLabel = [UILabel new];
        
        [self.contentView addSubview:_headerImageView];
        [self.contentView addSubview:_contentImgView];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setChartMessage:(ChartMessage *)chartMessage{
    if (_chartMessage != chartMessage) {
        _chartMessage = nil;
        _chartMessage = chartMessage;
    }
    
    
    _contentLabel.frame = CGRectZero;
    _contentLabel.numberOfLines = 0;
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.text = chartMessage.content;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.font = [UIFont systemFontOfSize:16.0];
    
    _headerImageView.frame = CGRectMake(kScreenWidth - 55, 10, 45, 45);
    _headerImageView.image = [UIImage imageNamed:@"addHeaderP"];
    
    _contentImgView.image = [UIImage imageNamed:@"chatto_bg_normal"];
    //  设置气泡拉伸
    _contentImgView.image = [_contentImgView.image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
    _contentImgView.frame = CGRectMake(kScreenWidth - 45 - 20 - chartMessage.frame.size.width - 35,
                                       10,
                                       chartMessage.frame.size.width + 35,
                                       chartMessage.frame.size.height + 25);
    
    _contentLabel.frame = CGRectMake(kScreenWidth - 45 - 20 - chartMessage.frame.size.width - 20,
                                     20,
                                     chartMessage.frame.size.width,
                                     chartMessage.frame.size.height);
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
