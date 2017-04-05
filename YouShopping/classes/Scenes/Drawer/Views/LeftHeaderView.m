//
//  LeftHeaderView.m
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "LeftHeaderView.h"

@implementation LeftHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        // 设置头像位置 和 大小
        self.avatorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, self.bounds.size.height / 2, kScreenWidth / 7, kScreenWidth / 7)];
        self.avatorImageView.layer.cornerRadius = self.avatorImageView.frame.size.height / 2.0;
        self.avatorImageView.layer.masksToBounds = YES;
        // imageView开交互
        self.avatorImageView.userInteractionEnabled = YES;
        // 昵称label
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.avatorImageView.frame) + 5, CGRectGetMinY(self.avatorImageView.frame), kScreenWidth / 2.5, CGRectGetHeight(self.avatorImageView.frame) / 2.0)];
        self.nameLabel.textColor = [UIColor yellowColor];
        self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:kScreenWidth / 18.75];
        
        // 二维码
        self.qrCodeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.qrCodeButton setImage:[UIImage imageNamed:@"G-qrCode"] forState:(UIControlStateNormal)];
        self.qrCodeButton.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame), CGRectGetMinY(self.avatorImageView.frame), kScreenWidth / 12, kScreenWidth / 12);
        [self.qrCodeButton addTarget:self action:@selector(qrCodeButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:self.avatorImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.qrCodeButton];
        
    }
    
    return self;
}

- (void)qrCodeButtonClicked{
    if (_delegate && [_delegate respondsToSelector:@selector(getMyQRCodeClicked)]) {
        [_delegate getMyQRCodeClicked];
    }
}


@end
