//
//  OnTitleViewController.m
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "OnTitleViewController.h"
#import "FirstDateilRequest.h"
#import "FirstDateilModel.h"
#import "DateilTableViewCell.h"
#import "Author.h"
#import "UrlViewController.h"
@interface OnTitleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *contectDateilLabel;

@end

@implementation OnTitleViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self headerView];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DateilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DateilTableViewCell_ID];
    [self requestData];
    [self headerData];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backHot"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
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
  //  self.rootVC.tabBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;

}


- (void)requestData
{
    __weak typeof(self)weakSelf = self;
    [[FirstDateilRequest shareFirstDateil]requestFirstDateilWithID:self.ID Success:^(NSDictionary *dic) {
        weakSelf.dataArray = [FirstDateilModel parseFirstDateilAllWithDic:dic];
        Author *model = [Author new];
        NSDictionary *dict = [dic valueForKey:@"data"];
        [model setValuesForKeysWithDictionary:dict];
       dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf updateSubViews:model];
           [weakSelf.tableView reloadData];
           
       });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)headerData
{
    //添加到tableView头视图的View
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight *0.5)];
    self.tableView.tableHeaderView = view;
    
    //最上边的图片
    self.headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight *0.3)];
    [view addSubview:_headerView];
    
    //简介的label
    UILabel *contectLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_headerView.frame) +10, 50, 20)];
    contectLabel.text = @"简介";
    contectLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:contectLabel];
    
    UILabel *firstlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contectLabel.frame)+5 , kScreenWidth, 1)];
    firstlineLabel.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1];
    [view addSubview:firstlineLabel];
    
    //简介的详情
    self.contectDateilLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(firstlineLabel.frame) + 10, kScreenWidth - 20, 40)];
    _contectDateilLabel.numberOfLines = 0;
    _contectDateilLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:_contectDateilLabel];
    UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_contectDateilLabel.frame) + 10, kScreenWidth, 10)];
    colorLabel.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1];
    [view addSubview:colorLabel];
    
    UILabel *listingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(colorLabel.frame) + 10, 50, 20)];
    listingLabel.text = @"列表";
    listingLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:listingLabel];
    
    UILabel *secondlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(listingLabel.frame) +5, kScreenWidth, 1)];
    secondlineLabel.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1];
    [view addSubview:secondlineLabel];
    
}
- (void)updateSubViews:(Author *)dateilModel
{
    [self.headerView setImageWithURL:[NSURL URLWithString:dateilModel.cover_image_url]];
    self.contectDateilLabel.text = dateilModel.Description;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DateilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DateilTableViewCell_ID];
    FirstDateilModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UrlViewController *urlVC = [UrlViewController new];
    FirstDateilModel *model = self.dataArray[indexPath.row];
    urlVC.ID = model.ID;
    NSLog(@"%@",urlVC.ID);
    [self.navigationController pushViewController:urlVC animated:YES];
    
}

/*
//当cell滑动的时候隐藏导航栏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationController.navigationBarHidden = YES;
}

//当cell停止滑动的时候出现导航栏
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   self.navigationController.navigationBarHidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
