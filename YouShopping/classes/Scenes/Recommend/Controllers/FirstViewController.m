//
//  FirstViewController.m
//  YouShoping
//
//  Created by 李帅 on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FirstViewController.h"

#import "UrlViewController.h"
#import "FristAllRequest.h"
#import "ShufflingModel.h"
#import "AllModel.h"
#import "FirstTableViewCell.h"
#import "OnTitleViewController.h"
#import <MJRefresh.h>
#import "FirstHeaderDateilViewController.h"
#import "CXCarouselView.h"
#import "FriendsManager.h"
#import "NewFriendModel.h"


@interface FirstViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate,
    FirstTableViewCellDelegate,
    CXCarouseViewDelegate,
    EMContactManagerDelegate
>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *pictureMuArr;
@property (strong, nonatomic) CXCarouselView * carousel;
@property (nonatomic, copy) NSString *nextUrl;

@property (strong,nonatomic)NSMutableArray *IDMuArr;

@property (strong,nonatomic)NSMutableArray *tempMuArr;

@end

@implementation FirstViewController

- (NSMutableArray *)tempMuArr
{
    if (!_tempMuArr) {
        
        _tempMuArr = [NSMutableArray array];
    }
    
    return _tempMuArr;

}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)pictureMuArr{
    if (!_pictureMuArr) {
        _pictureMuArr = [NSMutableArray array];
    }
    return _pictureMuArr;
}

- (NSMutableArray *)IDMuArr{
    if (!_IDMuArr) {
        _IDMuArr = @[].mutableCopy;
    }
    return _IDMuArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:FirstTableViewCell_Id];
    
    [self pullUpLoad];
    [self requestPictrues];
    
    // 注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    // 注册通知,用来接收处理完好友请求之后删除temArr
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removrAllObjectsWithTempArr:) name:@"nillTempArr" object:nil];
    
    
}


#pragma mark ===== 请求tablView数据 ======
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    
    [[FristAllRequest shareAllRequest]requestDataSuccess:^(NSDictionary *dic) {
        NSDictionary *dict = [dic[@"data"] valueForKey:@"paging"];
        weakSelf.nextUrl = [dict valueForKey:@"next_url"];
        weakSelf.dataArray = [AllModel parseShufflingWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark  ====== 请求轮播图数据 ======
- (void)requestPictrues{
    
    __weak typeof (self)weakSelf = self;
    [[FristAllRequest shareAllRequest]requestShufflingSuccess:^(NSDictionary *dic) {
        NSDictionary *dict = [dic valueForKey:@"data"];
        NSArray *array = [dict objectForKey:@"banners"];
        
        for (NSDictionary *temDic in array) {
            NSString *IDStr = temDic[@"target_id"];
            [self.IDMuArr addObject:IDStr];
        }
        // 得到轮播图url数组
        NSMutableArray *muArr = [NSMutableArray array];
        weakSelf.pictureMuArr = [ShufflingModel parseShufflingWithDic:dic];
        for (ShufflingModel *model in weakSelf.pictureMuArr) {
            [muArr addObject:model.image_url];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 创建轮播图
            weakSelf.carousel = [CXCarouselView initWithFrame:CGRectMake(0, 20, kScreenWidth , 200) hasTimer:YES interval:3 placeHolder:[UIImage imageNamed:@"tupianjiazaizhong"]];
            weakSelf.carousel.delegate = weakSelf;
            weakSelf.tableView.tableHeaderView = weakSelf.carousel;
            [weakSelf.carousel setupWithArray:muArr];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)carouselTouch:(CXCarouselView *)carousel atIndex:(NSUInteger)index
{
    if (index == 0 || index == self.IDMuArr.count-1) {
        UrlViewController *urlVC = [UrlViewController new];
        urlVC.ID = self.IDMuArr[index];
        [self.navigationController pushViewController:urlVC animated:YES];
    }else{
        FirstHeaderDateilViewController *dateilVC = [FirstHeaderDateilViewController new];
        
        dateilVC.ID = self.IDMuArr[index];
//        NSLog(@"%@",dateilVC.ID);
        [self.navigationController pushViewController:dateilVC animated:YES];
    }
}

//下拉刷新 上拉加载数据,
- (void)pullUpLoad
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestData];
        //                // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestMore:weakSelf.nextUrl];
        
        //                // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    if (self.nextUrl.length) {
        //   明杰第三方中没有if 没有下面这一句代码  只有默认先隐藏footer
        [self.tableView.mj_footer beginRefreshing];
        // 默认先隐藏footer
        self.tableView.mj_footer.hidden = YES;
    }
}


- (void)requestMore:(NSString *)nextUrl
{
    __weak typeof(self) weakSelf = self;
    [[FristAllRequest shareAllRequest]requestAllpageWithUrl:_nextUrl success:^(NSDictionary *dic) {
        NSDictionary *dict = [dic[@"data"] valueForKey:@"paging"];
        weakSelf.nextUrl = [dict valueForKey:@"next_url"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        tmpArr = [AllModel parseShufflingWithDic:dic];
        for (NSDictionary *nextDic in tmpArr) {
            [weakSelf.dataArray addObject:nextDic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstTableViewCell_Id];
    AllModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 256;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UrlViewController *firstDateil = [UrlViewController new];
    AllModel *model = self.dataArray[indexPath.row];
    firstDateil.ID = model.ID;
    [self.navigationController pushViewController:firstDateil animated:YES] ;
}

- (void)FirstTableviewPushBtnClicked:(FirstTableViewCell *)cell
{
    OnTitleViewController *onTitleVC = [OnTitleViewController new];
    onTitleVC.ID = cell.model.user.ID;
    onTitleVC.navigationItem.title = cell.model.user.title;
    [self.navigationController pushViewController:onTitleVC animated:YES];
}





#pragma mark ===== 收到好友请求的回调 ======
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage{
    
    
    NSArray *tempFriendsArr = [[FriendsManager shareFriendsManager] requestFriendsListWithNet];
    // 如果收到已有好友的请求,则忽略
    if ([tempFriendsArr containsObject:aUsername]) {
        return;
    } else {
        NewFriendModel *nModel = [NewFriendModel newFriendModelWithName:aUsername nMessage:aMessage];
        [self.tempMuArr addObject:nModel];
        // 添加通知,发送出去新好友请求
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getFriendsRuquest" object:nil userInfo:@{@"newRuest":self.tempMuArr}];
        
        
    }
}

- (void)removrAllObjectsWithTempArr:(NSNotification *)notifiCation{
    self.tempMuArr = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
