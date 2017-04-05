//
//  PictureCell.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/28.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "PictureCell.h"
#define kPictureWidth 54
#define kPictureHeight 90


@interface PictureCell ()

@property (strong,nonatomic)UIImageView *pictureImageView;
@property (strong,nonatomic)UIImageView *headerImgView;
@property (strong,nonatomic)UIImageView *backImageView;

@end


@implementation PictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backImageView = [UIImageView new];
        _pictureImageView = [UIImageView new];
        _headerImgView = [UIImageView new];
        [self.contentView addSubview:_headerImgView];
        [self.contentView addSubview:_backImageView];
        [self.contentView addSubview:_pictureImageView];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setImage:(UIImage *)image{
    if (_image != image ) {
        _image = nil;
        _image = image;
    }
    
    
    _headerImgView.image = [UIImage imageNamed:@"addHeaderP"];
    
    _pictureImageView.image = image;
    _headerImgView.frame = CGRectMake(kScreenWidth - 55, 10, 45, 45);
    _backImageView.image = [UIImage imageNamed:@"chatto_bg_normal"];
    _backImageView.image = [_backImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
    
    _pictureImageView.frame = CGRectMake(kScreenWidth - 45 - 20 - kPictureWidth -10 , 12, kPictureWidth, kPictureHeight);
    _backImageView.frame = CGRectMake(CGRectGetMinX(_pictureImageView.frame )- 5, 10, kPictureWidth + 15, kPictureHeight + 8);
    
    
}


- (void)setResaveUrl:(NSString *)resaveUrl{
    
    if (_resaveUrl != resaveUrl) {
        _resaveUrl = nil;
        _resaveUrl = resaveUrl;
    }
    
    
    
    _headerImgView.image = [UIImage imageNamed:@"addHeaderP"];
    
    [_pictureImageView setImageWithURL:[NSURL URLWithString:self.resaveUrl]];
    
    _headerImgView.frame = CGRectMake(10, 10, 45, 45);
    _backImageView.image = [UIImage imageNamed:@"chatfrom_bg_normal"];
    _backImageView.image = [_backImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
    _pictureImageView.frame = CGRectMake(55 + 10 + 10, 12, kPictureWidth, kPictureHeight);
    _backImageView.frame = CGRectMake(65, 10, kPictureWidth + 15, kPictureHeight +8);
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
