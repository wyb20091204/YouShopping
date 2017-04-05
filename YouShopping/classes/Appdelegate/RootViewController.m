//
//  RootViewController.m
//  YouShop
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "SixthViewController.h"
#import "FifthViewController.h"
#import "SeventhViewController.h"
#import "EighthViewController.h"
#import "NinethViewController.h"
#import "TenthViewController.h"
#import "EleventhViewController.h"
#import "TwelfthViewController.h"
#import "ThirteenthViewController.h"
#import "FourteenthViewController.h"
#import "FifteenthViewController.h"
#import "SixteenthViewController.h"
#import "HotViewController.h"
#import "FriendsViewController.h"
#import "MineViewController.h"
#import <WMPageController.h>
#import "AppDelegate.h"
@interface RootViewController ()
@property(nonatomic, strong)UIImage *avatorImage;

@property(nonatomic, strong)UIButton *drawerButton;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createChildViewController];
    [self setTabBarItemTextAttributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255 / 255.0 green:89 / 255.0 blue:114 / 255.0 alpha:1]];
    
    self.tabBar.tintColor = [UIColor colorWithRed:255 / 255.0 green:89 / 255.0 blue:114 / 255.0 alpha:1];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avatorImageAction) name:@"avator" object:nil];
    
    
}

- (void)avatorImageAction{
   
    //
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"avator"];
    if (data == nil) {
//         NSLog(@"1111122211111");
        self.avatorImage = [UIImage imageNamed:@"avatorImage"];
    } else {
//        NSLog(@"本地的头像");
        self.avatorImage = [UIImage imageWithData:data];
    }
    
    [self.drawerButton setBackgroundImage:self.avatorImage forState:(UIControlStateNormal)];
}

- (void)createChildViewController{

    //
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"avator"];
    if (data == nil) {
        
        self.avatorImage = [UIImage imageNamed:@"avatorImage"];
    } else {
        self.avatorImage = [UIImage imageWithData:data];
    }
    // navigationBar 左侧头像按钮
    self.drawerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.drawerButton.frame = CGRectMake(0, 0, kScreenWidth / 10, kScreenWidth / 10);
    self.drawerButton.layer.cornerRadius = self.drawerButton.frame.size.height / 2;
    self.drawerButton.layer.masksToBounds = YES;
    [self.drawerButton setBackgroundImage:self.avatorImage forState:(UIControlStateNormal)];
    [self.drawerButton addTarget:self action:@selector(openOrCloseLeftDrawerClicked) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 推荐
    WMPageController *wPage = [self setFirst];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:wPage]
                              title:@"推荐" normalImage:@"礼物" selectImage:@"礼物S"];
    wPage.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.drawerButton];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    image.image = [UIImage imageNamed:@"toubiaoti12"];
    wPage.navigationItem.titleView = image;
    
    // 热门
    [self addOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[HotViewController new]]
                              title:@"热门" normalImage:@"热门" selectImage:@"热门S"];
    // 好友
    [self addOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[FriendsViewController new]]
                              title:@"好友" normalImage:@"好友" selectImage:@"好友S"];
    // 商家地图
    [self addOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[MineViewController new]]
                              title:@"商家" normalImage:@"地图" selectImage:@"地图S"];
    
}
#pragma mark ======  创建顶部items视图 ======
- (WMPageController *)setFirst{
    //视图数组
    NSMutableArray *viewController = [NSMutableArray array];
    //items数组
    NSMutableArray *titles = [NSMutableArray array];
    for (int i = 0; i < 16; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [FirstViewController class];
                title = @"精选";
                break;
            case 1:
                vcClass = [SecondViewController class];
                title = @"海淘";
                break;
            case 2:
                vcClass = [ThirdViewController class];
                title = @"创意生活";
                break;
            case 3:
                vcClass = [FourthViewController class];
                title = @"送女票";
                break;
            case 4:
                vcClass = [FifthViewController class];
                title = @"科技范";
                break;
            case 5:
                vcClass = [SixthViewController class];
                title = @"送爸妈";
                break;
            case 6:
                vcClass = [SeventhViewController class];
                title = @"设计感";
                break;
            case 7:
                vcClass = [EighthViewController class];
                title = @"文艺风";
                break;
            case 8:
                vcClass = [NinethViewController class];
                title = @"奇葩搞怪";
                break;
            case 9:
                vcClass = [TenthViewController class];
                title = @"萌萌哒";
                break;
            case 10:
                vcClass = [EleventhViewController class];
                title = @"礼物";
                break;
            case 11:
                vcClass = [TwelfthViewController class];
                title = @"美食";
                break;
            case 12:
                vcClass = [ThirteenthViewController class];
                title = @"送自己";
                break;
            case 13:
                vcClass = [FourteenthViewController class];
                title = @"饰品";
                break;
            case 14:
                vcClass = [FifteenthViewController class];
                title = @"穿搭";
                break;
            case 15:
                vcClass = [SixteenthViewController class];
                title = @"家居";
                break;
    
            default:
                break;
        }
        [viewController addObject:vcClass];
        [titles addObject:title];
        
    }
    WMPageController *pageVC = [[WMPageController alloc]initWithViewControllerClasses:viewController andTheirTitles:titles];
    //每个item的宽度
    pageVC.menuItemWidth = 80;
    //item的样式
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    //选中时的标题尺寸
    pageVC.titleSizeSelected = 15;
    return pageVC;
    
}



/**
 *  给tabBarController添加一个子视图控制器
 *
 *  @param viewController 子控制器
 *  @param title          标题
 *  @param normalImage    正常状态下的图片
 *  @param selectImage    选中状态下的图片
 */
- (void)addOneChildViewController:(UINavigationController *)navigationController title:(NSString *)title normalImage:(NSString *)normalImage selectImage:(NSString *)selectImage {
    
//    navigationController.viewControllers.firstObject.view.backgroundColor = [UIColor colorWithRed:200 green:200 blue:150 alpha:1.0];
    navigationController.tabBarItem.title = title;
    
    UIImage *nImage = [UIImage imageNamed:normalImage];
    nImage = [nImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sImage = [UIImage imageNamed:selectImage];
    sImage = [sImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    navigationController.tabBarItem.image = nImage;
    navigationController.tabBarItem.selectedImage = sImage;
    // 添加子控制器
    [self addChildViewController:navigationController];
    
}

- (void)setTabBarItemTextAttributes{
    // 设置普通状态下文本的颜色
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs [NSForegroundColorAttributeName] = [UIColor grayColor];
    // 设置选中状态下文本的颜色
    NSMutableDictionary *selectArtts = [NSMutableDictionary dictionary];
    selectArtts [NSForegroundColorAttributeName] = [UIColor colorWithRed:255 / 255.0 green:89 / 255.0 blue:114 / 255.0 alpha:1];
    // 配置文本属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:(UIControlStateNormal)];
    [tabBarItem setTitleTextAttributes:selectArtts forState:(UIControlStateSelected)];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---------- Drawer ----------
// 头像按钮 点击方法
- (void)openOrCloseLeftDrawerClicked{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // 根据isClosed (BOOL)判断 抽屉的状态, 展开<->隐藏
    if (app.leftDrawerVC.isClosed) {
        [app.leftDrawerVC openLeftView];
    } else {
        [app.leftDrawerVC closeLeftView];
    }
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC setPanEnabled:NO];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 隐藏TabBar 的navigationbar 以免遮盖
    self.navigationController.navigationBar.hidden = YES;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC setPanEnabled:YES];
}





- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"avator"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
