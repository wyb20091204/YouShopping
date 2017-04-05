//
//  LeftDrawerViewController.h
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extra.h"

#define kScreenSize           [[UIScreen mainScreen] bounds].size

#define kMainPageDistance kScreenWidth / 4 //打开左侧窗时, 中视图(右视图)露出的宽度
#define kLeftBottomDistance 100  // 左侧窗 底部预留空间高度
#define kMainPageScale    1   //打开左侧窗时, 中视图(右视图)缩放比例
#define kMainPageCenter   CGPointMake(kScreenWidth + kScreenWidth * kMainPageScale / 2.0 - kMainPageDistance, kScreenHeight/ 2)  //打开左侧窗时，中视图中心点

#define vCouldChangeDeckStateDistance (kScreenWidth - kMainPageDistance) / 2.0 - 40           // 滑动距离大于此数时, 状态改变 (关-->开,  开-->关)
#define vSpeedFloat  0.7       //滑动速度
#define kLeftAlpha   0.9       //左侧蒙版的最大值
#define kLeftCenterX 30        //左侧初始偏移量
#define kLeftScale   1       //左侧初始缩放比例

#define vDeckCanNotPanViewTag  987654   // 不响应此侧滑的View的tag


@interface LeftDrawerViewController : UIViewController
// 滑动速度 默认为0.5
@property(nonatomic, assign)CGFloat speedf;
// 左侧窗控制器
@property(nonatomic, strong)UIViewController *leftVC;
//
@property(nonatomic, strong)UIViewController *mainVC;
// 点击手势, 是否允许视图恢复视图位置. 默认为yes
@property(nonatomic, strong)UITapGestureRecognizer *sideslipTapGes;
// 滑动手势
@property(nonatomic, strong)UIPanGestureRecognizer *pan;
// 侧滑窗是否隐藏
@property(nonatomic, assign)BOOL isClosed;

/*
 初始化侧滑控制器
 leftVC 右视图控制器
 mainVC 中间视图控制器
 instancetype 初始化的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                        mainView:(UIViewController *)mainVC;
/*
 @brief  关闭左视图
 */
- (void)closeLeftView;
/*
 @brief  打开左视图
 */

- (void)openLeftView;
/*
 @brief  设置滑动开关是否开启
 @param  enable YES : 支持滑动手势, NO : 不支持滑动手势
 */
- (void)setPanEnabled:(BOOL)enbled;
@end
