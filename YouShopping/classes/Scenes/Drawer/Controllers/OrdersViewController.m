
//
//  OrdersViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/29.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrdersTableViewCell.h"

@interface OrdersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self createViews];
}

- (void)createViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrdersTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"orders_cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orders_cell"];
    cell.titleLabel.text = @"我的淘宝订单";
    cell.leftImage.image = [UIImage imageNamed:@"taobao"];
    cell.rightImage.image = [UIImage imageNamed:@"rightImage"];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
