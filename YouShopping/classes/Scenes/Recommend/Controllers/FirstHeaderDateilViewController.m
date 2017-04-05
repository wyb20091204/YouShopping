//
//  FirstHeaderDateilViewController.m
//  YouShopping
//
//  Created by 李帅 on 16/7/22.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FirstHeaderDateilViewController.h"
#import "FirstTableViewCell.h"
#import "UrlViewController.h"
#import "OnTitleViewController.h"
#import "FirstDateilRequest.h"
#import "FristAllRequest.h"
#import <MJRefresh.h>
@interface FirstHeaderDateilViewController ()<UITableViewDataSource,UITableViewDelegate,FirstTableViewCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataArray;



@end

@implementation FirstHeaderDateilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:FirstTableViewCell_Id];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backHot"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];

    [self pullUpLoad];
    

}

- (void)backAction:(UIBarButtonItem *)barButtonItem
{
    //    self.rootVC.tabBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)requestData
{
     __weak typeof(self) weakSelf = self;
    [[FirstDateilRequest shareFirstDateil]requestFirstHeaderDatrilWithID:self.ID success:^(NSDictionary *dic) {
        NSDictionary *dict = [dic valueForKey:@"data"];
        
        weakSelf.title = [dict valueForKey:@"title"];
        for (NSDictionary *temDic in dict[@"posts"]) {
            AllModel *model = [AllModel new];
            [model setValuesForKeysWithDictionary:temDic];
            [weakSelf.dataArray addObject:model];
        }
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
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
