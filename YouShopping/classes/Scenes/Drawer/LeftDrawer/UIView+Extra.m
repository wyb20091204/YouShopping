//
//  UIView+Extra.m
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)
//告诉编译器，不自动生成getter/setter方法，避免编译期间产生警告
@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
@dynamic origin;
@dynamic size;

#pragma mark ----------- setter ---------
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin{
    self.x = origin.x;
    self.y = origin.y;
}

- (void)setSize:(CGSize)size{
    self.width = size.width;
    self.height = size.height;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right = frame.size.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y  = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark ---------- getter ------------
-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

-(CGSize)size{
    return CGSizeMake(self.width, self.height);
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)centerX {
    return self.center.x;
}

-(CGFloat)centerY {
    return self.center.y;
}


- (UIView *)lastSubviewOnX{
    if (self.subviews.count > 0) {
        UIView *outView = self.subviews[0];
        
        for (UIView *view in self.subviews) {
            if (view.x > outView.x) {
                outView = view;
                return outView;
            }
        }
    }
    return nil;
}


- (UIView *)lastSubviewOnY{
    
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        
        for(UIView *view in self.subviews)
            if(view.y > outView.y)
                outView = view;
        return outView;
    }
    return nil;
}

#pragma mark --------- other -------------

/*
 @brief  移除此view上的所有子视图
 */
- (void)removeAllSubviews{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

/*
 @brief  弹窗
 @param  title 弹窗标题
 message 弹窗信息
 */
+ (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = title;
        alert.message = message;
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        alert = nil;
    });
}
/*
 @brief  弹窗
 @param  title 弹窗标题
 message 弹窗信息
 delegate 弹窗代理
 */

+ (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message
                  delegate:(UIViewController<UIAlertViewDelegate> *)delegate{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = title;
        alert.message = message;
        alert.delegate = delegate;
        alert.tag = vAlertTag;
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        alert = nil;
    });
}














@end
