//
//  UIView+Extra.h
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#define vAlertTag    10086

#import <UIKit/UIKit.h>

@interface UIView (Extra)

@property (nonatomic, assign) CGFloat   x;
@property (nonatomic, assign) CGFloat   y;
@property (nonatomic, assign) CGFloat   width;
@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, assign) CGPoint   origin;
@property (nonatomic, assign) CGSize    size;
@property (nonatomic, assign) CGFloat   bottom;
@property (nonatomic, assign) CGFloat   right;
@property (nonatomic, assign) CGFloat   centerX;
@property (nonatomic, assign) CGFloat   centerY;
@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;
@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

/*
 @brief  移除此view上的所有子视图
 */
- (void)removeAllSubviews;

/*
 @brief  弹窗
 @param  title 弹窗标题
         message 弹窗信息
 */
+ (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message;
/*
 @brief  弹窗
 @param  title 弹窗标题
         message 弹窗信息
         delegate 弹窗代理
 */

+ (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message
                  delegate:(UIViewController<UIAlertViewDelegate> *)delegate;


@end

