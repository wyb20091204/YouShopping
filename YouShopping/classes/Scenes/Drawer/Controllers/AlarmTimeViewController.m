//
//  AlarmTimeViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/18.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AlarmTimeViewController.h"
#import "AlarmTimeTableViewCell.h"
#import "UIViewController+BackButtonHandler.h"

@interface AlarmTimeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *titleArr;
@property(nonatomic, strong)NSMutableSet *dateSet;
@end

@implementation AlarmTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.titleArr = @[@"当天", @"提前一天", @"提前两天", @"提前三天", @"提前四天", @"提前五天", @"提前六天", @"提前一周"];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AlarmTimeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AlarmTimeTableViewCell"];
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 31;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlarmTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmTimeTableViewCell"];
    // cell 标题
    cell.titleLabel.text = self.titleArr[indexPath.row];
    // cell 内容
    cell.myImageView.hidden = [self.hideArr[indexPath.row] boolValue];
    
    // 判断如果 图片显示的话, 则把 内容加入Set  ----- 从上个页面跳转进来就知道已经选了哪些,Set里有哪些值
    if (cell.myImageView.hidden == NO) {
        [self.dateSet addObject:self.titleArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    // 所有cell都显示在屏幕里, 可见的就是所有cell. 根据indexPath的判断cell图片是否隐藏, 显示的话就将标题加入到Set, 否则就从Set中移除
    if ([self.tableView.visibleCells[indexPath.row] myImageView].hidden == NO) {
        [self.tableView.visibleCells[indexPath.row] myImageView].hidden = YES;
        [self.dateSet removeObject:self.titleArr[indexPath.row]];

        self.hideArr[indexPath.row] = @YES;
    } else {
        [self.tableView.visibleCells[indexPath.row] myImageView].hidden = NO;
        [self.dateSet addObject:self.titleArr[indexPath.row]];
        self.hideArr[indexPath.row] = @NO;
    }
}

// 借用一个开源的extension，点击系统的back按钮触发的方法
- (BOOL)navigationShouldPopOnBackButton {

    [self.delegate passAlarmTimeWithSet:self.dateSet array:self.hideArr];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 懒加载
- (NSMutableSet *)dateSet{
    if (_dateSet == nil) {
        _dateSet = [[NSMutableSet alloc]init];
    }
    return _dateSet;
}

@end
