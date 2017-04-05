//
//  LeftDrawerViewController.m
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "LeftDrawerViewController.h"
#import "HcdGuideView.h"
@interface LeftDrawerViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat _scalef;    //实时横向位移
}
//#warning 有修改
/*
 注释 : 这是没 bottomView tableView滑动
//@property(nonatomic, strong)UITableView *leftTableView;
 */
// 这是leftDrawer 有bottomView 跟随leftView滑动
@property(nonatomic, strong)UIView *leftTableView;
@property(nonatomic, assign)CGFloat leftTableViewWidth;
@property(nonatomic, strong)UIView *contentView;
@end

@implementation LeftDrawerViewController

/*
 初始化侧滑控制器
 leftVC 右视图控制器
 mainVC 中间视图控制器
 instancetype 初始化的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                        mainView:(UIViewController *)mainVC{
    
    self = [super init];
    if (self) {
        // 设置滑动速度
        self.speedf = vSpeedFloat;
        
        // 设置中心视图和左侧视图
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        
        // 初始化滑动手势
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanAction:)];
        // 中视图上添加滑动手势
        [self.mainVC.view addGestureRecognizer:self.pan];
        //
        [self.pan setCancelsTouchesInView:YES];
        // 设置代理
        self.pan.delegate = self;
        // 左视图初始默认为隐藏
        self.leftVC.view.hidden = YES;
        // 左视图添加到View上
        [self.view addSubview:self.leftVC.view];
        
        // 蒙版 即左视图展开隐藏时的蒙版
        UIView *view = [[UIView alloc]init];
        view.frame = self.leftVC.view.bounds;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        self.contentView = view;
        [self.leftVC.view addSubview:view];
//#warning 有修改 --> 为了leftDrawer下部bottomView 跟随一起滑动
        /*
         注释 : 这是没 bottomView tableView滑动
        // 获取左侧tableView
//        for (UIView *temp in self.leftVC.view.subviews) {
//            if ([temp isKindOfClass:[UITableView class]]) {
//                self.leftTableView = (UITableView *)temp;
//            }
//        }
         */
        
        // 这是leftDrawer 有bottomView
        self.leftTableView = self.leftVC.view;
        
        
        
        // 设置tableView为透明和大小
        self.leftTableView.backgroundColor = [UIColor clearColor];
        self.leftTableView.frame = CGRectMake(0, 0, kScreenWidth - kMainPageDistance, kScreenHeight);
        
        // 设置左侧tableView的初始位置和缩放系数
        self.leftTableView.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        self.leftTableView.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        
        [self.view addSubview:self.mainVC.view];
        // 初始时 左侧窗默认隐藏
        self.isClosed = YES;
    }
    return self;
}
#pragma mark -------------- 滑动手势
- (void)handlePanAction:(UIPanGestureRecognizer *)pan{
    // 转化成指定视图的坐标
    CGPoint point = [pan translationInView:self.view];
    
    _scalef = (point.x * self.speedf + _scalef);
    
    // 是否还需要跟随手指移动
    BOOL needMoveWithTap = YES;
    if (((self.mainVC.view.x <= 0) && (_scalef <= 0)) || ((self.mainVC.view.x >= (kScreenWidth - kMainPageDistance)) && (_scalef >= 0))) {
        
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    // 根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap && (pan.view.frame.origin.x >= 0) && (pan.view.frame.origin.x <= (kScreenWidth - kMainPageDistance))) {
        CGFloat panCenterX = pan.view.center.x + point.x * self.speedf;
        if (panCenterX < kScreenWidth * 0.5 - 2) {
            panCenterX = kScreenWidth * 0.5;
        }
        CGFloat panCenterY = pan.view.center.y;
        
        pan.view.center = CGPointMake(panCenterX, panCenterY);
        
        // scale 1.0 - kMainPageScale  中视图缩放比例
        CGFloat scale = 1 - (1 - kMainPageScale) * (pan.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) * 0.5 - kLeftCenterX) * (pan.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        NSLog(@"leftTabCenterX -- %f", leftTabCenterX);
        
        // leftScale kLeftScale - 1.0;   左视图缩放比例
        CGFloat leftScale = kLeftScale + (1 - kLeftScale) * (pan.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        self.leftTableView.center = CGPointMake(leftTabCenterX, kScreenHeight * 0.5);
        self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale, leftScale);
        
        // tempAlpha kLeftAlpha ~ 0;      contentView透明度随滑动变化
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (pan.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.contentView.alpha = tempAlpha;
    
    }
    else
    {
        if (self.mainVC.view.x < 0) {
            [self closeLeftView];
            _scalef = 0;
        } else if (self.mainVC.view.x > (kScreenWidth - kMainPageDistance)) {
            [self openLeftView];
            _scalef = 0;
        }
    }
    
    // 手势结束后, 修正位置. 超过约一半时向多出的一半偏移
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance) {
            if (self.isClosed) {
                [self openLeftView];
            } else {
                [self closeLeftView];
            }
        } else {
            if (self.isClosed) {
                [self closeLeftView];
            } else {
                [self openLeftView];
            }
        }
        _scalef = 0;
    }

}
#pragma mark -------------- 点击手势
- (void)handleTapAction:(UITapGestureRecognizer *)tap{
    
    if ((!self.isClosed) && (tap.state == UIGestureRecognizerStateEnded)) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        tap.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        self.isClosed = YES;
        
        self.leftTableView.center = CGPointMake(kLeftCenterX, kScreenHeight / 2);
        self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, kLeftScale, kLeftScale);
        self.contentView.alpha = kLeftAlpha;
        
        [UIView commitAnimations];
        _scalef = 0;
        [self removeSingleTap];
    }
}


// 视图想要出现时, 隐藏左视图
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.leftVC.view.hidden = NO;
}
/*
 @brief  关闭左视图
 */
- (void)closeLeftView{
    
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.mainVC.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    self.isClosed = YES;
    
    self.leftTableView.center = CGPointMake(kLeftCenterX, kScreenHeight / 2);
    self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, kLeftScale, kLeftScale);
    self.contentView.alpha = kLeftAlpha;
    
    [UIView commitAnimations];
    [self removeSingleTap];
}
/*
 @brief  打开左视图
 */

- (void)openLeftView{
    
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kMainPageScale, kMainPageScale);
    self.mainVC.view.center = kMainPageCenter;
    self.isClosed = NO;
    
    self.leftTableView.center = CGPointMake((kScreenWidth - kMainPageDistance) / 2, kScreenHeight / 2);
    self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.contentView.alpha = 0;
    
    [UIView commitAnimations];
    [self disableTapButton];
}
#pragma mark ---------- 行为收敛 -----------
- (void)disableTapButton{
    
    for (UIButton *tempButton in [_mainVC.view subviews]) {
        [tempButton setUserInteractionEnabled:NO];
    }
    
    // 点击
    if (!self.sideslipTapGes) {
        // 点击手势
        self.sideslipTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
        // 单击
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        // 点击事件盖住其他的响应事件但是不盖住 抽屉button
        self.sideslipTapGes.cancelsTouchesInView = YES;
    }
}


// 关闭行为收敛
- (void)removeSingleTap{
    
    for (UIButton *tempButton in [self.mainVC.view subviews]) {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}
/*
 @brief  设置滑动开关是否开启
 @param  enable YES : 支持滑动手势, NO : 不支持滑动手势
 */
- (void)setPanEnabled:(BOOL)enbled{
    [self.pan setEnabled:enbled];
}
// 根据tag设置不响应侧滑的view
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (touch.view.tag == vDeckCanNotPanViewTag) {
//        NSLog(@"  不响应侧滑");
        return NO;
    } else {
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *images = [NSMutableArray new];
    [images addObject:[UIImage imageNamed:@"000"]];
    [images addObject:[UIImage imageNamed:@"234"]];
    [images addObject:[UIImage imageNamed:@"132"]];
    
    [[HcdGuideViewManager sharedInstance] showGuideViewWithImages:images
                                                   andButtonTitle:@"立即体验"
                                              andButtonTitleColor:[UIColor whiteColor]
                                                 andButtonBGColor:[UIColor clearColor]
                                             andButtonBorderColor:[UIColor whiteColor]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






@end
