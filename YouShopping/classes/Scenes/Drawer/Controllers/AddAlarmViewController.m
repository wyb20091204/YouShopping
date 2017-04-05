//
//  AddAlarmViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "AddAlarmTableViewCell.h"
#import "STPickerDate.h"
#import "AlarmTimeViewController.h"

@interface AddAlarmViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
STPickerDateDelegate,     // 时间选择代理
ReturnAlarmTimeActionDelegate,
UITextFieldDelegate       // TF代理
>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)NSArray *titleArr;
@property(nonatomic, strong)NSMutableArray *detailArr;

@property(nonatomic, strong)UILabel *label;

@property(nonatomic, strong)NSMutableSet *dateSet;

@property(nonatomic, strong)NSArray *passArr;

@property(nonatomic, strong)NSMutableString *time;

@property(nonatomic, strong)UIButton *button;

@property(nonatomic, strong)NSString *string;
@end

@implementation AddAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加提醒";
    self.navigationController.navigationBar.hidden = NO;
    
    self.titleArr = @[@"发生日期", @"提醒时间", @"重复"];
    
    self.detailArr = [@[@"未选择", @"未选择", @"未选择"] mutableCopy];
    // 传入下个页面 图片是否隐藏
    self.passArr = @[@YES, @YES, @YES, @YES, @YES, @YES, @YES, @YES];

    self.dateSet = [@[] mutableCopy];

    [self createTableView];

}

- (void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStyleGrouped)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AddAlarmTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddAlarmTableViewCell"];
    
    self.tableView.sectionHeaderHeight = 80;
    self.tableView.sectionFooterHeight = 80;
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_button];

    [_button addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [_button setTitle:@"完成" forState:(UIControlStateNormal)];
        [_button setEnabled:NO];
        [_button setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.4] forState:(UIControlStateNormal)];

    // 注册观察者, 观察textfield的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.textField];

    // 注册
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:@"sureIsNull" object:nil];

}

// 行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddAlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAlarmTableViewCell"];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    
    cell.detailLabel.text = self.detailArr[indexPath.row];
    
    return cell;
}

// 头视图行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

// 返回头视图 -- 事件提醒
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSLog(@"header");
    
    // 创建UIView 作为头视图的底板, 其他控件放view上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    view.backgroundColor = [UIColor clearColor];
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    self.textField.backgroundColor = [UIColor clearColor];
    [view addSubview:self.textField];
    self.textField.placeholder = @"    事件提醒";
    self.textField.text = self.string;
    return view;
}

// 返回尾视图 -- 备注
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    NSLog(@"footer");
    
    // 创建一个UIView 作为尾视图的底板,  其他控件放view上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 15)];
    label.text = @"    备注";
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 80)];
    self.textView.backgroundColor = [UIColor clearColor];
    [view addSubview:self.textView];
    [view addSubview:label];
    return view;
}

// 点击cell方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {       //   发生日期
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];

    } else if (indexPath.row == 1) {      //    提醒时间
        // 跳转到提醒日期页面
        AlarmTimeViewController *timeVC = [[AlarmTimeViewController alloc]init];
        // 设置代理人, 代理传值
        timeVC.delegate = self;
        timeVC.hideArr = [self.passArr mutableCopy];
        self.string = self.textField.text;
        [self.navigationController pushViewController:timeVC animated:YES];
    } else {                                 // 是否重复
        
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *onceAction = [UIAlertAction actionWithTitle:@"一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.detailArr[2] = @"一次";
            // 回到主线程 刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }];
        UIAlertAction *yearAction = [UIAlertAction actionWithTitle:@"每年" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.detailArr[2] = @"每年";
            // 回到主线程 刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        
        [alertC addAction:onceAction];
        [alertC addAction:yearAction];
        [alertC addAction:cancelAction];
        [self presentViewController:alertC animated:YES completion:nil];
        
    }
    
}
#pragma mark --------------  发生日期选择
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)year, (long)month, (long)day];
    self.detailArr[0] = text;
    [self.tableView reloadData];
}

#pragma mark --------------  提醒时间
// ReturnAlarmTimeActionDelegate代理
- (void)passAlarmTimeWithSet:(NSMutableSet *)aSet array:(NSMutableArray *)aArray{
    
    // 判断如果set已存在的话, 移除之前所有元素
    if (_dateSet == nil) {
    self.dateSet = [[NSMutableSet alloc]init];
    
    } else {
    [self.dateSet removeAllObjects];
    self.time = [@"1" mutableCopy];
    }

    self.dateSet = aSet;
    
    
//    NSLog(@"1111 %@", self.dateSet);
    // 判断set是否为空, 为空则未选择
    if (self.dateSet.count != 0) {
    
    for (NSString *string in self.dateSet) {
        self.time = [NSMutableString stringWithFormat:@"%@、%@",self.time, string];
        self.detailArr[1] = self.time;
//        NSLog(@"2222 %@", self.time);
    }
    self.detailArr[1] = [self.time substringFromIndex:2];

    } else {
        self.detailArr[1] = @"未选择";
        
    }
    
    // 获取图片隐藏数组
    self.passArr = aArray;
    
    [self.tableView reloadData];
}

// 懒加载
- (NSMutableString *)time{
    if (_time == nil) {
        _time = [NSMutableString stringWithString:@"1"];
    }
    return _time;
}
//hide keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (void)rightBarButtonClicked{
//    NSLog(@"传值 -- %@", self.dateSet);
    [_delegate passToAlarmViewDelegateWithTitle:self.textField.text date:self.detailArr[0] time:self.detailArr[1]];
//    NSLog(@"完成");
    [self.navigationController popViewControllerAnimated:YES];
    
}
//观察者触发方法. 判断textfield和和发生日期是否填写过了, 否则button变浅,不能触发方法
- (void)change:(NSNotification *)notification{
    if ((self.textField.text.length == 0) || [self.detailArr[0] isEqualToString:@"未选择"]) {
        [_button setEnabled:NO];
        [_button setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.4] forState:(UIControlStateNormal)];
    } else {
        [_button setEnabled:YES];
        [_button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }
}

// 借用一个开源的extension，点击系统的back按钮触发的方法
- (BOOL)navigationShouldPopOnBackButton {
    // 页面通信
    
    return YES;
}
// 移除观察者
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:UITextFieldTextDidChangeNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"sureIsNull"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
