//
//  DrawerViewController.m
//  YouShoping
//
//  Created by Akira_Hideto on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "DrawerViewController.h"
#import "AppDelegate.h"
#import "DrawerTableViewCell.h"
#import "LeftHeaderView.h"
#import "LeftBottomView.h"
#import "PersonInformationViewController.h"
#import "QRCodeViewController.h"
#import "AlarmViewController.h"
#import "WeatherViewController.h"
#import "SetupViewController.h"
#import "OtherViewController.h"
#import "CouponsViewController.h"
#import "OrdersViewController.h"


#define kBottomViewHeight 100
@interface DrawerViewController ()<
UITableViewDelegate,
UITableViewDataSource,
DrawerHeaderViewQRCodeDelegate,    // 头视图代理
DrawerBOttomViewDelegate           // 底视图代理
>

// tableView cell 标题数组
@property(nonatomic, strong)NSArray *nameArr;

// tableView cell 图片数组
@property(nonatomic, strong)NSArray *imageArr;
// 头视图高度
@property(nonatomic, assign)CGFloat heightForHeader;
//
@property(nonatomic, strong)NSString *name;
//
@property(nonatomic, strong)LeftBottomView *bottomView;
//
@property(nonatomic, strong)UIImage *avatorImage;
@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameArr = @[@"小金库", @"我的收藏", @"我的订单", @"我的礼券", @"附近的人", @"热门"];
    self.imageArr = @[@"purse", @"collection", @"orders", @"coupon", @"nearPeople", @"hotDoor"];
    
    [self setUpViews];

}
- (void)setUpViews{
    // 设置 背景图片
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"flower"];
    [self.view addSubview:backImageView];
    
    // 设置tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- kBottomViewHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // cell间无线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DrawerTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DrawerTableViewCell"];
    
    // 头视图高
    self.heightForHeader = kScreenHeight / 4;
    
    // 设置bottomView
    self.bottomView = [[LeftBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth, kBottomViewHeight)];
    [self.view addSubview:self.bottomView];
    // 设置bottom的代理
    self.bottomView.delegate = self;
    
}
#pragma mark ---------- tableView -----------
// cell 数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
// cell 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
// headView 高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.heightForHeader;
}
// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DrawerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrawerTableViewCell" forIndexPath:indexPath];
    
    cell.nameLabel.text = self.nameArr[indexPath.row];
    cell.myImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    
    return cell;
}


#pragma mark ------ 头视图 ------
// 返回头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LeftHeaderView *headerView = [[LeftHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.heightForHeader)];
    if (self.name.length == 0) {
        headerView.nameLabel.text = @"我的小可爱在吗";
    } else {
        headerView.nameLabel.text = self.name;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"avator"];
    if (data == nil) {
        
        self.avatorImage = [UIImage imageNamed:@"avatorImage"];
    } else {
//        NSLog(@"我去你的");
        self.avatorImage = [UIImage imageWithData:data];
    }
    
    headerView.avatorImageView.image = self.avatorImage;
    
    headerView.delegate = self;
    
    // 头视图开交互
    headerView.userInteractionEnabled = YES;

    // headView添加手势
    UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewTapClicked)];
    [headerView addGestureRecognizer:tapGeture];
    
    return headerView;
}
#pragma mark ------ 各种跳转方法

- (void)headerViewTapClicked{
//    NSLog(@"headerView");
    // 隐藏抽屉
    AppDelegate *app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC closeLeftView];
    DrawerViewController *drawer = self;
    
    PersonInformationViewController *personVC = [PersonInformationViewController new];
    personVC.block = ^(NSString *string)
    {
        drawer.name = string;
        [drawer.tableView reloadData];
    };
    
    [app.mainNC pushViewController:personVC animated:YES];
}
// 点击cell方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    // 隐藏抽屉
    AppDelegate *app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC closeLeftView];
    if (indexPath.row ==1) {
        OtherViewController *otherVC = [OtherViewController new];
        [app.mainNC pushViewController:otherVC animated:YES];
        
    } else if (indexPath.row == 2) {
        OrdersViewController *ordersVC = [[OrdersViewController alloc]init];
        [app.mainNC pushViewController:ordersVC animated:YES];
    } else if (indexPath.row == 3) {
        CouponsViewController *couponsVC = [[CouponsViewController alloc]init];
        [app.mainNC pushViewController:couponsVC animated:YES];
    }
}

// LeftHeaderView代理方法 ---> 去跳转页面展示自己的二维码
- (void)getMyQRCodeClicked{

    // 隐藏抽屉
    AppDelegate *app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC closeLeftView];
    
    QRCodeViewController *qrCodeVC = [[QRCodeViewController alloc]init];
    [app.mainNC pushViewController:qrCodeVC animated:YES];
}

// BottomView的代理方法
// 设置button点击方法
- (void)setUpButtonAction{
    // 隐藏抽屉
    AppDelegate *app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC closeLeftView];
    
    SetupViewController *setupVC = [[SetupViewController alloc]init];
    [app.mainNC pushViewController:setupVC animated:YES];
}
// 闹铃button点击方法
- (void)alarmClockButtonAction{
    // 隐藏抽屉
    AppDelegate *app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC closeLeftView];
    
    AlarmViewController *alarmVC = [[AlarmViewController alloc]init];
    [app.mainNC pushViewController:alarmVC animated:YES];
}
// 天气button点击方法
- (void)weatherButtonAction{
    
    // 隐藏抽屉
    AppDelegate *app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC closeLeftView];
    
    WeatherViewController *weatherVC = [[WeatherViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    weatherVC.block = ^(NSString *cityName, NSString *temp)
    {
        weakSelf.bottomView.weatherButton.cityLabel.text = cityName;
        weakSelf.bottomView.weatherButton.temperatureLabel.text = temp;
        weakSelf.bottomView.weatherButton.myImageViewt.hidden = YES;
        weakSelf.bottomView.weatherButton.myImageViewq.hidden = YES;
    };
    
    [app.mainNC pushViewController:weatherVC animated:YES];
    
}

#pragma mark --------- viewWillAppear

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"leftViewWillAppear -- ");
    self.view.backgroundColor = [UIColor clearColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
