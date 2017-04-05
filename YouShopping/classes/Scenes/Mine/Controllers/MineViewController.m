//
//  MineViewController.m
//  YouShop
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "MineViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "FriendsManager.h"
//地图页面
#import "BaiDuMapViewController.h"
//3D云标签
#import "DBSphereView.h"

@interface MineViewController ()
@property(nonatomic, strong)UIImage *avatorImage;

@property (nonatomic, strong) DBSphereView *sphereView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家锁定";
    //这种方式，如果原始图片不小不够，则会拉伸以满足View的尺寸,----背景图
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"mapTemp.png"];
    [self.view addSubview:imageView];
    
    //    3D云标签各个省会
    _sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(kScreenWidth*0.1, kScreenHeight*0.3, kScreenWidth*0.8, kScreenHeight*0.5)];
    
    NSArray *arr = @[@"北京市     海淀区毛纺路金五星商厦",@"上海市     陆家嘴",@"天津市",@"重庆市",@"哈尔滨市",@"长春市",@"沈阳市",@"呼和浩特",@"石家庄市",@"乌鲁木齐",@"兰州市",@"西宁市",@"西安市",@"银川市",@"郑州市",@"济南市",@"太原市",@"合肥市",@"长沙市",@"武汉市",@"南京市",@"成都市",@"贵阳市",@"昆明市",@"南宁市",@"拉萨市",@"杭州市",@"南昌市",@"广州市",@"福州市",@"台北市",@"海口市",@"香港",@"澳门"];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 34; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24.];
        btn.frame = CGRectMake(0, 0, 100, 20);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        //以btn边界为止 后面的文字就不显示了!!
        btn.titleLabel.lineBreakMode = NSLineBreakByClipping;
        [array addObject:btn];
        [_sphereView addSubview:btn];
    }
    
    [_sphereView setCloudTags:array];
    _sphereView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_sphereView];
    
    
//  牛犊子------------
    [self createNavigtionBarAvator];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createNavigtionBarAvator) name:@"avator" object:nil];
}



//点击后 跳转到地图显示城市
- (void)buttonPressed:(UIButton *)btn
{
    [_sphereView timerStop];
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
            
            BaiDuMapViewController * baiDuMapVC = [BaiDuMapViewController new];
            [self.navigationController pushViewController:baiDuMapVC animated:YES];
            //    按钮上的文字
            baiDuMapVC.cityStr = btn.titleLabel.text;
            
        }];
    }];
}




//  牛犊子------------
- (void)createNavigtionBarAvator{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"avator"];
    if (data == nil) {
        
        self.avatorImage = [UIImage imageNamed:@"avatorImage"];
    } else {
        self.avatorImage = [UIImage imageWithData:data];
    }
    // navigationBar 左侧头像按钮
    UIButton *drawerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    drawerButton.frame = CGRectMake(0, 0, 40, 40);
    [drawerButton setBackgroundImage:self.avatorImage forState:(UIControlStateNormal)];
    drawerButton.layer.cornerRadius = drawerButton.frame.size.height / 2;
    drawerButton.layer.masksToBounds = YES;
    [drawerButton addTarget:self action:@selector(openOrCloseLeftDrawerClicked) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:drawerButton];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"avator"];
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
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC setPanEnabled:YES];
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
