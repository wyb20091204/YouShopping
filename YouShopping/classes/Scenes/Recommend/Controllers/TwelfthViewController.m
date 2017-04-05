//
//  TwelfthViewController.m
//  YouShopping
//
//  Created by 李帅 on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "TwelfthViewController.h"
#import "UrlViewController.h"
#import "FristAllRequest.h"
#import "AllModel.h"
#import "FirstTableViewCell.h"
#import "OnTitleViewController.h"
#import <MJRefresh.h>
@interface TwelfthViewController ()<UITableViewDelegate,UITableViewDataSource,FirstTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *nextUrl;

@end

@implementation TwelfthViewController

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
}

- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    [[FristAllRequest shareAllRequest]requestTwelfthSuccess:^(NSDictionary *dic) {
        NSDictionary *dict = [dic[@"data"] valueForKey:@"paging"];
        weakSelf.nextUrl = [dict valueForKey:@"next_url"];
        weakSelf.dataArray = [AllModel parseShufflingWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
            //明杰第三方中没有if 没有下面这一句代码  只有默认先隐藏footer
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
    UrlViewController *dateilVC = [UrlViewController new];
    AllModel *model = self.dataArray[indexPath.row];
    dateilVC.ID = model.ID;
    [self.navigationController pushViewController:dateilVC animated:YES];
}

- (void)FirstTableviewPushBtnClicked:(FirstTableViewCell *)cell
{
    OnTitleViewController *onTitleVC = [OnTitleViewController new];
    onTitleVC.ID = cell.model.user.ID;
    [self.navigationController pushViewController:onTitleVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
