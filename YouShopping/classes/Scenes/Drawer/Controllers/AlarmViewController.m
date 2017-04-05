//
//  AlarmViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AlarmViewController.h"
#import "AlarmTableViewCell.h"
#import "AddAlarmViewController.h"

@interface AlarmViewController ()<
UITableViewDelegate,
UITableViewDataSource,
passToAlarmViewDelegate      // 页面通信
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *noAlarmView;
//
@property(nonatomic, strong)NSMutableArray *alarmArr;
//
@property(nonatomic, strong)NSArray *saveArr;
@end

@implementation AlarmViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.alarmArr.count != 0) {
        self.noAlarmView.hidden = YES;
    } else {
        self.noAlarmView.hidden = NO;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"送礼提醒";
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[ud objectForKey:@"alarmArr"] mutableCopy];
    
    if (array.count == 0) {
        self.alarmArr = [NSMutableArray array];
    } else {
        self.alarmArr = array;
    }

    [self createTableView];
}
- (void)createTableView{
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"AlarmTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AlarmTableViewCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addAlarmClockAction)];

}
- (void)addAlarmClockAction{
    AddAlarmViewController *addVC = [[AddAlarmViewController alloc]init];
    addVC.delegate  = self;
    [self.navigationController pushViewController:addVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.alarmArr.count != 0) {
        self.noAlarmView.hidden = YES;
    } else {
        self.noAlarmView.hidden = NO;
    }
    return self.alarmArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmTableViewCell"];
    
    cell.titleLabel.text = self.alarmArr[indexPath.row][@"title"];
    cell.dateLabel.text = [self.alarmArr[indexPath.row][@"date"] substringFromIndex:5];
    cell.timeLabel.text = self.alarmArr[indexPath.row][@"time"];
    return cell;
}

- (void)passToAlarmViewDelegateWithTitle:(NSString *)title date:(NSString *)date time:(NSString *)time{
    NSDictionary *dict = @{@"title":title, @"date":date, @"time":time};
    [self.alarmArr addObject:dict];
    [self.tableView reloadData];
}

#pragma ---------------------左划删除cell

// 左划进入编辑模式(可以什么都不写,实现方法就行)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 进行逻辑操作(删数据)
    //    NSMutableArray *newArr = [NSMutableArray arrayWithArray:self.alarmArr];
    //
    //    [newArr removeObjectAtIndex:indexPath.row];
    [self.alarmArr removeObjectAtIndex:indexPath.row];
    // 更新视图
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
}

// 借用一个开源的extension，点击系统的back按钮触发的方法
- (BOOL)navigationShouldPopOnBackButton {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.alarmArr forKey:@"alarmArr"];
    return YES;
}
@end
