//
//  FriendsViewController.m
//  YouShop
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FriendsViewController.h"
#import "AppDelegate.h"
#import "AddFriendViewController.h"
#import "ApplyViewController.h"
#import "MessageCell.h"
#import "FriendsCell.h"
#import "ApplyAndNewCell.h"
#import "FriendsManager.h"
#import "NewFriendModel.h"
#import "ChartViewController.h"
#import "MessageModel.h"
#import "ChartManager.h"

#import "LoginViewController.h"

@interface FriendsViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *messageTabelView;
@property (weak, nonatomic) IBOutlet UITableView *friendsTabelView;


@property (strong,nonatomic)UISegmentedControl *seg;

@property (strong,nonatomic)UITableViewCell *myCell;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSIndexPath *myIndexPath;

@property (strong,nonatomic)NewFriendModel *nFriendModel;

@property (strong,nonatomic)NSMutableArray *lastMessageMuArr;
@property (strong,nonatomic)NSMutableArray *IDMuArr;
@property (strong,nonatomic)NSMutableArray *dataMuArr;



@end

@implementation FriendsViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        // 接受通知获取新好友请求数组
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNewFriendsRequest:) name:@"getFriendsRuquest" object:nil];
        // 接受通知得到消息列表的model
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didResaveMessageMoedl:) name:@"getMessageArr" object:nil];
    }
    return self;
}

- (void)didNewFriendsRequest:(NSNotification *)notification{
    
    self.nMessageArr = notification.userInfo[@"newRuest"];
    _messageCount = [NSString stringWithFormat:@"%ld",self.nMessageArr.count];
    self.navigationController.tabBarItem.badgeValue = _messageCount;
    [self getApplyCellWithHidenStatu:NO count:_messageCount];
}

- (void)didResaveMessageMoedl:(NSNotification *)notification{
    
    MessageModel *mModel = notification.userInfo[@"messageM"];
    // 最后一条消息不为空则添加到消息列表
    if (mModel.lastMessage.length > 0) {
        // 用来得到对应的消息数组下标
        int n = 0;
        // 如果消息数组是空的就直接添加
        if (self.messageMuArr.count == 0) {
            [self.messageMuArr addObject:mModel];
            [self.messageTabelView reloadData];
            [self.IDMuArr addObject:mModel.friendID];
            [self.lastMessageMuArr addObject:mModel.lastMessage];
            [self saveDefaults];
        } else {
            // 如果存在
            if ([self.IDMuArr containsObject:mModel.friendID]) {
                
                for (NSString *ID in self.IDMuArr) {
                    
                    if ([ID isEqualToString:mModel.friendID] ) {
                        // 此时对应的ID 和对应的最后消息是和返回过来的mModel是相同的,不用刷新
                        if ([mModel.lastMessage isEqualToString:self.lastMessageMuArr[n]]) {
                            return;
                        // ID相同,最后内容不同,给对应位置model重新复制,并且把最新的放到第一个
                        } else {
                            [self.messageMuArr replaceObjectAtIndex:n withObject:mModel];
                            [self.lastMessageMuArr replaceObjectAtIndex:n withObject:mModel.lastMessage];
                            
                            [self.messageMuArr exchangeObjectAtIndex:0 withObjectAtIndex:n];
                            [self.IDMuArr exchangeObjectAtIndex:0 withObjectAtIndex:n];
                            [self.lastMessageMuArr exchangeObjectAtIndex:0 withObjectAtIndex:n];

                            [self saveDefaults];
                            [self.messageTabelView reloadData];
                            return;
                        }
                    }
                    
                     ++n;
                }
            } else {
                [self.messageMuArr insertObject:mModel atIndex:0];
                [self.messageTabelView reloadData];
                [self.IDMuArr insertObject:mModel.friendID atIndex:0];
                [self.lastMessageMuArr insertObject:mModel.lastMessage atIndex:0];
                [self saveDefaults];
            }
        }
    }
    
}

- (void)saveDefaults{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"messageDtaMuArr"];
    [self.dataMuArr removeAllObjects];
    // 归档
    for (MessageModel *tempMoel in self.messageMuArr) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempMoel];
        [self.dataMuArr addObject:data];
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.dataMuArr forKey:@"messageDtaMuArr"];

    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)messageMuArr{
    if (!_messageMuArr) {
        _messageMuArr = @[].mutableCopy;
    }
    return _messageMuArr;
}

- (NSMutableArray *)friendsMuArr{
    if (!_friendsMuArr) {
        _friendsMuArr = @[].mutableCopy;
    }
    return _friendsMuArr;
}

- (NSArray *)nMessageArr{
    if (!_nMessageArr ) {
        _nMessageArr = [NSArray array];
    }
    return _nMessageArr;
}

- (NSMutableArray *)blackListMuArr{
    if (!_blackListMuArr) {
        _blackListMuArr = [NSMutableArray new];
    }
    return _blackListMuArr;
}

- (NSMutableArray *)lastMessageMuArr{
    if (!_lastMessageMuArr) {
        _lastMessageMuArr = @[].mutableCopy;
    }
    return _lastMessageMuArr;
}
- (NSMutableArray *)dataMuArr{
    if (!_dataMuArr) {
        _dataMuArr = @[].mutableCopy;
    }
    return _dataMuArr;
}

- (NSMutableArray *)IDMuArr{
    if (!_IDMuArr) {
        _IDMuArr = @[].mutableCopy;
    }
    return _IDMuArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置顶部segmengt
    [self drawSwgment];
    
    // 注册cell
    [self.messageTabelView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:messageCell_Identify];
    [self.friendsTabelView registerNib:[UINib nibWithNibName:@"FriendsCell" bundle:nil] forCellReuseIdentifier:friends_Identify];
    [self.friendsTabelView registerNib:[UINib nibWithNibName:@"ApplyAndNewCell" bundle:nil] forCellReuseIdentifier:applyAndNewCell_Identify];
    
    // navgetionBar
    [self drawNavgationBar];
    
    // 给两个tableView附tag值用来下面长按的时候判断哪个tableView
    self.messageTabelView.tag = 200;
    self.friendsTabelView.tag = 100;
    
}




#pragma mark ====== 添加segment ======

- (void)drawSwgment{
    NSArray *arr = @[@"消息",@"好友"];
    self.seg = [[UISegmentedControl alloc] initWithItems:arr];
    self.seg.apportionsSegmentWidthsByContent = YES;
    self.seg.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 20);
    // 设置边框颜色
    self.seg.tintColor = [UIColor blackColor];
    // 设置选中下标
    self.seg.selectedSegmentIndex = 0;
    [self.navigationController.navigationBar addSubview:self.seg];
    [self.seg addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark ====== 关联scrollerView和segment ======

- (void)changePage:(UISegmentedControl *)segement{
    if (segement.selectedSegmentIndex == 1) {
        self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.seg.selectedSegmentIndex = self.scrollView.contentOffset.x /  kScreenWidth;
}

#pragma mark ====== 自定义NavgationBar ======

- (void)drawNavgationBar{
    // navigationBar 左侧头像按钮
    UIButton *drawerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    drawerButton.frame = CGRectMake(0, 0, 40, 40);
    [drawerButton setBackgroundImage:[UIImage imageNamed:@"avatorImage"] forState:(UIControlStateNormal)];
    [drawerButton addTarget:self action:@selector(openOrCloseLeftDrawerClicked) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:drawerButton];
    // 右侧添加
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriends:)];
}

#pragma mark ====== 跳转添加好友页面 ======

- (void)addFriends:(UIBarButtonItem *)barButton{
    AddFriendViewController *addFriendVC = [AddFriendViewController new];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}

#pragma mark ====== tabelView =====


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.friendsTabelView) {
        return 3;
    } else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.friendsTabelView && section == 0)  {
        return 1;
    } else if (tableView == self.friendsTabelView && section == 1){
        return self.friendsMuArr.count;
    } else if (tableView == self.friendsTabelView && section == 2)
        return self.blackListMuArr.count;
    else {
        return self.messageMuArr.count;
    }
}

#pragma mark ===== 分区标题 =====
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.friendsTabelView) {
        if (section == 0) {
            return 1;
        }
        return 10;
    }
    else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.friendsTabelView) {
        if (section == 1) {
            return @"我的好友";
        } else if (section == 2){
            return @"黑名单";
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.messageTabelView) {
        MessageCell *cell = [self.messageTabelView dequeueReusableCellWithIdentifier:messageCell_Identify forIndexPath:indexPath];
        
        
        MessageModel *mModel = self.messageMuArr[indexPath.row];
        cell.messageModel = mModel;
        
        // 添加长按手势用来删除操作
        [self addLongPressWithTableView:self.messageTabelView longPressViewTag:200];
        return  cell;
    } else if (tableView == self.friendsTabelView && indexPath.section == 0){
        ApplyAndNewCell *cell = [tableView dequeueReusableCellWithIdentifier:applyAndNewCell_Identify forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }  else {
        FriendsCell *cell = [self.friendsTabelView dequeueReusableCellWithIdentifier:friends_Identify forIndexPath:indexPath];
        if (indexPath.section == 1) {
            cell.friendNmaeLabel.text = self.friendsMuArr[indexPath.row];
        } else {
            cell.friendNmaeLabel.text = self.blackListMuArr[indexPath.row];
        }
        // 添加长按手势用来删除操作
        [self addLongPressWithTableView:self.friendsTabelView longPressViewTag:100];
        return  cell;
    }
}

#pragma mark ====== 添加长按手势 ======

- (void)addLongPressWithTableView:(UITableView *)aTableView longPressViewTag:(NSInteger)aTagNumber{
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [aTableView addGestureRecognizer:longPress];
    // 给手势附tag值在下面可以方便通过tag值来获得对应的tableView
    longPress.view.tag = aTagNumber;
    longPress.minimumPressDuration = 1.0;
}

#pragma mark ===== 长按cell删除 =====

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        // 通过手势传过来的tag值得到tableView
        // 别忘记给添加第一响应者
        [self becomeFirstResponder];
        self.myTableView  = (UITableView *)[self.view viewWithTag:longPress.view.tag];
        if (self.myTableView == self.messageTabelView) {
            [self getLongPressCellWithPress:longPress TableView:self.messageTabelView];
        } else {
            [self getLongPressCellWithPress:longPress TableView:self.friendsTabelView];
        }
    }
    else if (longPress.state == UIGestureRecognizerStateEnded){
        NSLog(@"长按结束");
    }
}

- (void)getLongPressCellWithPress:(UILongPressGestureRecognizer *)aLongPress TableView:(UITableView *)aTableView{
    // 通过点得到indexpath
    CGPoint point = [aLongPress locationInView:aTableView];
    self.myIndexPath = [aTableView indexPathForRowAtPoint:point];
    if (!self.myIndexPath) {
        NSLog(@"nil");
    } else {
        // 如果是好友列表的第一个分区
        if (aTableView == self.friendsTabelView && self.myIndexPath.section == 0) {
            NSLog(@"这是friendsTavleView的第0个分区,不让编辑");
            return;
        }
        // 如果是好友的第二个分区添加删除和加入黑名单menu
        else if (aTableView == self.friendsTabelView && self.myIndexPath.section == 1){
            UIMenuController *menu = [UIMenuController sharedMenuController];
            UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除好友" action:@selector(deleteAction:)];
            UIMenuItem *blackListItem = [[UIMenuItem alloc] initWithTitle:@"加入黑名单" action:@selector(addFriendToBlackList:)];
            [menu setMenuItems:@[deleteItem,blackListItem]];
            // 得到当前cell
            self.myCell = [aTableView cellForRowAtIndexPath:self.myIndexPath];
            [menu setTargetRect:self.myCell.bounds inView:self.myCell];
            [menu setMenuVisible:YES animated:YES];
        }
        // 如果是好友的第三个分区添加移除黑名单的menu
        else if (aTableView == self.friendsTabelView && self.myIndexPath.section == 2){
             UIMenuController *menu = [UIMenuController sharedMenuController];
            UIMenuItem *removeFromeBlackListItem = [[UIMenuItem alloc] initWithTitle:@"从黑名单里移除" action:@selector(removeFromeBlackListAction:)];
            [menu setMenuItems:@[removeFromeBlackListItem]];
            self.myCell = [aTableView cellForRowAtIndexPath:self.myIndexPath];
            [menu setTargetRect:self.myCell.bounds inView:self.myCell];
            [menu setMenuVisible:YES animated:YES];
        } else if (aTableView == self.messageTabelView){
            UIMenuController *menu = [UIMenuController sharedMenuController];
            UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除聊天" action:@selector(deleteAction:)];
            [menu setMenuItems:@[deleteItem]];
            // 得到当前cell
            self.myCell = [aTableView cellForRowAtIndexPath:self.myIndexPath];
            [menu setTargetRect:self.myCell.bounds inView:self.myCell];
            [menu setMenuVisible:YES animated:YES];
        }
    }
}

// menue必须实现的两个方法
- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(deleteAction:)||
        action == @selector(addFriendToBlackList:)||
        action == @selector(removeFromeBlackListAction:)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

// 删除操作
- (void)deleteAction:(id)sender{
       
    if (self.myTableView == self.messageTabelView) {
        [self deletecellForTableView:self.messageTabelView];
    } else {
        [self deletecellForTableView:self.friendsTabelView];
    }
}
// 加入黑名单
- (void)addFriendToBlackList:(id)sender{
    [self showAlertControllerWithMessage:@"确定加入黑名单?"];
}
// 移除黑名单
- (void)removeFromeBlackListAction:(id)sender{
    [self showAlertControllerWithMessage:@"确定移除黑名单?"];
}

- (void)deletecellForTableView:(UITableView *)tableView{
    if (tableView == self.friendsTabelView) {
        [self showAlertControllerWithMessage:@"确定删除好友?"];
    } else {
        [self showAlertControllerWithMessage:@"确定删除消息?"];
    }

}

- (void)showAlertControllerWithMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([message isEqualToString:@"确定删除好友?"]) {
            
            [[FriendsManager shareFriendsManager] deleteFriendWithName:self.friendsMuArr[self.myIndexPath.row]];
            [self.friendsMuArr removeObjectAtIndex:self.myIndexPath.row];
            [self.friendsTabelView deleteRowsAtIndexPaths:@[self.myIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            
        } else if ([message isEqualToString:@"确定加入黑名单?"]){
            
            NSString *blackName = self.friendsMuArr[self.myIndexPath.row];
            [[FriendsManager shareFriendsManager] moveFriendToBlackListWithUserName:blackName];
            [self.friendsMuArr removeObjectAtIndex:self.myIndexPath.row];
            [self.friendsTabelView deleteRowsAtIndexPaths:@[self.myIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
            [self.blackListMuArr addObject:blackName];
            [self.friendsTabelView reloadData];
        } else if ([message isEqualToString:@"确定移除黑名单?"]){
            
            NSString *blackName = self.blackListMuArr[self.myIndexPath.row];
            [[FriendsManager shareFriendsManager] removeBlackListWithUserName:blackName];
            [self.blackListMuArr removeObjectAtIndex:self.myIndexPath.row];
            [self.friendsTabelView deleteRowsAtIndexPaths:@[self.myIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self.friendsMuArr addObject:blackName];
            [self.friendsTabelView reloadData];
        } else if ([message isEqualToString:@"确定删除消息?"]){
            NSLog(@"删除消息");
            [[ChartManager shareChartManger] deleteConversationWithFriendID:self.IDMuArr[self.myIndexPath.row]];
            
            [self.messageMuArr removeObjectAtIndex:self.myIndexPath.row];
            [self.IDMuArr removeObjectAtIndex:self.myIndexPath.row];
            [self.lastMessageMuArr removeObjectAtIndex:self.myIndexPath.row];
            [self.messageTabelView deleteRowsAtIndexPaths:@[self.myIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            
            [self saveDefaults];
        }
        
    }];
    UIAlertAction *undoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:undoAction];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark ===== 点击cell ======

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.friendsTabelView) {
        if (indexPath.section == 0 && indexPath.row == 0 ) {
            ApplyViewController *applyVC = [ApplyViewController new];
            // 传新好友请求数组
            applyVC.tempMuArr = self.nMessageArr.mutableCopy;
//            applyVC.applyVCdelegate = self;
            // 接收Block传过来的新好友的附加数组
            applyVC.newFriendBlock = ^(NSMutableArray *newFriendArr){
                for (NewFriendModel *nModel in newFriendArr) {
                    [self.friendsMuArr addObject:nModel.nUserName];
                }
                [self.friendsTabelView reloadData];
                NSLog(@"friendsMuArr = %@",self.friendsMuArr);
            };
            [self.navigationController pushViewController:applyVC animated:YES];
            self.navigationController.tabBarItem.badgeValue = nil;
            self.nMessageArr = nil;
            [self getApplyCellWithHidenStatu:YES count:nil];
        } else if (indexPath.section == 1){
            ChartViewController *chartVC = [ChartViewController new];
            
            chartVC.friendID = self.friendsMuArr[indexPath.row];
            [self.navigationController pushViewController:chartVC animated:YES];
        }
        NSLog(@"点击了friendsTableView第%ld个分区第%ld行",indexPath.section + 1 ,indexPath.row + 1);
    }
    else {
        
        ChartViewController *chartVC = [ChartViewController new];
        
        MessageModel *mModel = self.messageMuArr[indexPath.row];
        chartVC.friendID = mModel.friendID;
        [self.navigationController pushViewController:chartVC animated:YES];
        NSLog(@"这个是messageTableView的第%ld行",indexPath.row + 1);
    }
}

#pragma mark ====== 返回cell高度 ====== 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



- (void)getApplyCellWithHidenStatu:(BOOL)statu count:(NSString *)count{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ApplyAndNewCell *cell = [self.friendsTabelView cellForRowAtIndexPath:indexPath];
    cell.badgeValueLabel.text = count;
    cell.badgeValueLabel.hidden = statu;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---------- Drawer ----------
// 头像按钮 点击方法
- (void)openOrCloseLeftDrawerClicked{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // 根据isClosed (BOOL)判断 抽屉的状态, 展开<->隐藏
    if (app.leftDrawerVC.isClosed) {
        [app.leftDrawerVC openLeftView];
    } else {
        [app.leftDrawerVC closeLeftView];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC setPanEnabled:NO];
    self.seg.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC setPanEnabled:YES];
    self.seg.hidden = NO;
    
    self.user =  [userDefaults getUserInfo];
    
    // 如果是登录状态从本地拿数组
    if (self.user.loginState ) {
        // 获取+好友黑名单列表和好友列表
        self.blackListMuArr = [[FriendsManager shareFriendsManager] requestBlackListWithNet].mutableCopy;
        self.friendsMuArr = [[FriendsManager shareFriendsManager] requestFriendsListWithNet].mutableCopy;
        // 如果好友里面有黑名单列表的,那么数组移除
        NSMutableArray *tempBlackMuArr = [NSMutableArray new];
        for (NSString *name in self.friendsMuArr) {
            if ([self.blackListMuArr containsObject:name]) {
                [tempBlackMuArr addObject:name];
            }
        }
        for (NSString *name in tempBlackMuArr) {
            [self.friendsMuArr removeObject:name];
        }
        [self.friendsTabelView reloadData];
        
        // 反归档 获取消息列表
        // 反归档
        
        if (self.messageMuArr.count == 0) {
            NSArray *fArr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"messageDtaMuArr"];
            for (NSData *fData in fArr) {
                MessageModel *fModel = [NSKeyedUnarchiver unarchiveObjectWithData:fData];
                NSLog(@"\n%@",fModel);
                [self.messageMuArr addObject:fModel];
                [self.lastMessageMuArr addObject:fModel.lastMessage];
                [self.IDMuArr addObject:fModel.friendID];
            }
            [self.messageTabelView reloadData];
        }
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
