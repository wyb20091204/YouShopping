//
//  ApplyViewController.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/21.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ApplyViewController.h"
#import "ApplyCell.h"
#import "FriendsManager.h"

@interface ApplyViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    ApplyCellDelegate
>
@property (strong,nonatomic)UITableView *applyTableView;
@property (strong,nonatomic)NSMutableArray *aftrAgreeMuArr;
@property (strong,nonatomic)NSMutableArray *nFriendMuArr;

@end



@implementation ApplyViewController

- (NSMutableArray *)nFriendMuArr{
    if (!_nFriendMuArr) {
        _nFriendMuArr = [NSMutableArray new];
    }
    return _nFriendMuArr;
}

- (NSMutableArray *)aftrAgreeMuArr{
    if (!_aftrAgreeMuArr) {
        _aftrAgreeMuArr = [NSMutableArray new];
    }
    return _aftrAgreeMuArr;
}

- (UITableView *)applyTableView{
    if (!_applyTableView) {
        _applyTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _applyTableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请与通知";
    
    self.nFriendMuArr = self.tempMuArr;
    
    // 注册cell
    [self.applyTableView registerNib:[UINib nibWithNibName:@"ApplyCell" bundle:nil] forCellReuseIdentifier:ApplyCell_Identify];
    self.applyTableView.delegate = self;
    self.applyTableView.dataSource = self;
    [self.view addSubview:self.applyTableView];
    self.view.backgroundColor = [UIColor cyanColor];

    
    UIImage *image = [UIImage imageNamed:@"backHot"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backToFriendsViewController:)];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)backToFriendsViewController:(UIBarButtonItem *)barButton{
    
    // 通过Block传出去添加的新好友数组
    self.newFriendBlock(self.aftrAgreeMuArr);
    
    // 给接收好友请求回调的第一页发送清空临时数组消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nillTempArr" object:nil userInfo:nil];

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nFriendMuArr.count;
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ApplyCell_Identify forIndexPath:indexPath];
    
    cell.nModel = self.nFriendMuArr[indexPath.row];
    cell.applyCelldelegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)applyCellDidAgreeButttonAction:(ApplyCell *)cell{
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:cell.IDLabel.text];
    if (!error) {
//        NSLog(@"发送同意成功");
        NSIndexPath *indxPath = [self.applyTableView indexPathForCell:cell];
        [self.aftrAgreeMuArr addObject:self.nFriendMuArr[indxPath.row]];
        cell.agreeButton.hidden = YES;
        cell.refuseButton.hidden = YES;
        cell.agreeLabel.hidden = NO;
        [self.applyTableView reloadData];

        
    }

}

- (void)applyCellDidRefuseButttonAction:(ApplyCell *)cell{
    EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:cell.IDLabel.text];
    if (!error) {
//        NSLog(@"发送拒绝成功");
        cell.agreeButton.hidden = YES;
        cell.refuseButton.hidden = YES;
        cell.refuseLabel.hidden = NO;
        [self.applyTableView reloadData];

    }
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
