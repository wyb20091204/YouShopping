//
//  LeftHeaderView.h
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeftHeaderView;
@protocol DrawerHeaderViewQRCodeDelegate <NSObject>

- (void)getMyQRCodeClicked;

@end

@interface LeftHeaderView : UIView

// 头像
@property(nonatomic, strong)UIImageView *avatorImageView;
// 昵称
@property(nonatomic, strong)UILabel *nameLabel;
// 我的二维码
@property(nonatomic, strong)UIButton *qrCodeButton;
// 代理
@property(nonatomic, assign)id<DrawerHeaderViewQRCodeDelegate> delegate;
@end
