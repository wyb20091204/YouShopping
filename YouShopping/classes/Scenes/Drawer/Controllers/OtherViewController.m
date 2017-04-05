//
//  OtherViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/28.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "OtherViewController.h"
#import "SaveTableViewCell.h"
#import "AllUrlModel.h"
#import "UrlViewController.h"
@interface OtherViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (strong,nonatomic)NSMutableArray *modelArr;


@end



@implementation OtherViewController

- (NSMutableArray *)modelArr {
    
    if (!_modelArr) {
        _modelArr = @[].mutableCopy;
    }
    return _modelArr;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    // 反归档,得到model数组
    self.dataArray = [[NSUserDefaults standardUserDefaults]arrayForKey:@"Key"].mutableCopy;
    
    if (self.modelArr.count == 0) {
        for (NSData *data in self.dataArray) {
            AllUrlModel * mo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.modelArr addObject:mo];
        }
    } else {
    
        // 如果是本地数组没值,移除所有数组,刷新UI;
        if (self.dataArray.count == 0) {
            [self.modelArr removeAllObjects];
            [self.tableView reloadData];
            // 如果本地数组小于model数组,说明减少了一个收藏
        } else if (self.dataArray.count < self.modelArr.count){
            [self.modelArr removeAllObjects];
            for (NSData *data in self.dataArray) {
                AllUrlModel * mo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [self.modelArr addObject:mo];
            }
            [self.tableView reloadData];
            // 如果相等,说明没有减少收藏
        } else if (self.dataArray.count == self.modelArr.count){
            return;
        }
    
    }
    
    
    
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.title = @"攻略";
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor grayColor];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SaveTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SaveTableViewCell_ID];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SaveTableViewCell_ID];
  
    AllUrlModel *model = [AllUrlModel new];
   model = self.modelArr[indexPath.row];
    
    [cell.Image setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.titleLabel.text = model.title;
    cell.Image.backgroundColor = [UIColor redColor];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UrlViewController *urlVC = [UrlViewController new];
    AllUrlModel *model = self.modelArr[indexPath.row];
    urlVC.ID = model.ID;
    [self.navigationController pushViewController:urlVC animated:YES];
    
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
