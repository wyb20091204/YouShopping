//
//  AddFriendViewController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendCell.h"
#import "FriendsManager.h"
@interface AddFriendViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UITextFieldDelegate,
    AddFriendsViewControllerDelegate
>

@property (strong,nonatomic)UITableView    *addFriendTableView;
@property (strong,nonatomic)UITextField    *searchTextFiel;
@property (strong,nonatomic)NSMutableArray *datasourceMuArr;
@property (strong,nonatomic)UIView         *headerView;


@end

@implementation AddFriendViewController

#pragma mark ====== getter ======




- (NSMutableArray *)datasourceMuArr{
    if (!_datasourceMuArr) {
        _datasourceMuArr = [NSMutableArray array];
    }
    return _datasourceMuArr;
}

- (UIView *)headerView{
  
    if ( !_headerView ) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        [_headerView addSubview:self.searchTextFiel];
    }
    return _headerView;
}

- (UITextField *)searchTextFiel{
    if (!_searchTextFiel) {
        _searchTextFiel = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 40)];
        _searchTextFiel.layer.borderColor = [[UIColor blackColor] CGColor];
        _searchTextFiel.layer.borderWidth = 0.5;
        _searchTextFiel.layer.cornerRadius = 10;
        _searchTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextFiel.font = [UIFont systemFontOfSize:15.0];
        _searchTextFiel.backgroundColor = [UIColor whiteColor];
        _searchTextFiel.placeholder = @"输入要查找的好友";
        _searchTextFiel.returnKeyType = UIReturnKeyDone;
        _searchTextFiel.delegate = self;
        
    }
    return _searchTextFiel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.addFriendTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // 注册cell
    [self.addFriendTableView registerNib:[UINib nibWithNibName:@"AddFriendCell" bundle:nil] forCellReuseIdentifier:AddFriendViewCell_Identyfy];
    
    [self setMyNavgationBarItemButtons];
    
    self.addFriendTableView.dataSource = self;
    self.addFriendTableView.delegate = self;
    self.addFriendTableView.tableHeaderView = self.headerView;
    
    
    [self.view addSubview:self.addFriendTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma  mark ===== 设置NavgationBar =====

- (void)setMyNavgationBarItemButtons{
    UIImage *imge = [UIImage imageNamed:@"backHot"];
    imge = [imge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imge style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.title = @"添加好友";
}

#pragma mark ====== 返回 ======

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ===== 搜索好友 ======
- (void)searchAction{
    [self.datasourceMuArr removeAllObjects];
    [self.datasourceMuArr addObject:self.searchTextFiel.text];
    [self.addFriendTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ====== tabBleView =====

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddFriendCell *cell = [self.addFriendTableView dequeueReusableCellWithIdentifier:AddFriendViewCell_Identyfy forIndexPath:indexPath];
    
    cell.friendIDLabel.text = self.searchTextFiel.text;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


#pragma mark ===== textFielDelegate ===== 

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

#pragma mark ===== cell的添加好友代理方法  在这里发送添加好友请求=====

- (void)addFriendsViewControllerDidCellAddButtonAction:(AddFriendCell *)cell{
    NSLog(@"添加好友");
    
    // 从本地获取好友列表
    NSArray *tempArr = [[FriendsManager shareFriendsManager] requestFriendsListWithManager];
    // 如果好友已存在则返回
    if ([tempArr containsObject:cell.friendIDLabel.text]) {
        UIAlertController *friendsAlert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"已添加%@",cell.friendIDLabel.text] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [friendsAlert addAction:sureAction];
        [self presentViewController:friendsAlert animated:YES completion:nil];
    }
    // 如果好友不存在就发送请求消息
    else {
        UIAlertController *messageAlert = [UIAlertController alertControllerWithTitle:@"备注信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [messageAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"说点什么";
        }];
        UIAlertAction *sendAction = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 获取备注信息
            NSString *message = messageAlert.textFields.lastObject.text;
            
            EMError *error = [[EMClient sharedClient].contactManager addContact:cell.friendIDLabel.text message:message];
            if (!error) {
                // TODO:添加成功后的操作
                UIAlertController *sendAlert = [UIAlertController alertControllerWithTitle:nil message:@"发送请求成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的,等待结果"style:UIAlertActionStyleCancel handler:nil];
                [sendAlert addAction:OKAction];
                [self presentViewController:sendAlert animated:YES completion:nil];
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [messageAlert addAction:sendAction];
        [messageAlert addAction:cancelAction];
        [self presentViewController:messageAlert animated:YES completion:nil];
    }
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
