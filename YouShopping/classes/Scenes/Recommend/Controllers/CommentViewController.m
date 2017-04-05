//
//  CommentViewController.m
//  YouShopping
//
//  Created by 李帅 on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "CommentViewController.h"
#import "FirstDateilRequest.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import "CalculateTool.h"
@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) CommentModel *model;
@property (strong, nonatomic)UITextView *msgTextView;

@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation CommentViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"评论";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backHot"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommentTableViewCell_ID];
    [self requestData];
    [self footView];
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)backAction:(UIBarButtonItem *)barButtonItem
{
    //self.rootVC.tabBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestData
{
    [[FirstDateilRequest shareFirstDateil]requestFirstdateilCommentWithID:self.ID success:^(NSDictionary *dic) {

        NSDictionary *dict = [dic valueForKey:@"data"];
        for (NSDictionary *temDic in dict[@"comments"]) {
            CommentModel *model = [CommentModel new];
            model.avatar_url = [temDic[@"user"] valueForKey:@"avatar_url"];
            model.nickname = [temDic[@"user"] valueForKey:@"nickname"];
            [model setValuesForKeysWithDictionary:temDic];
            self.model = model;
            [self .dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTableViewCell_ID];
    CommentModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel *model = self.dataArray[indexPath.row];
    CGFloat contectHeight = [CalculateTool getHeight:model.content];
    return contectHeight + 90;
}




- (void)footView
{
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight-45, kScreenWidth, 45)];
    //    imageView.backgroundColor = [UIColor blackColor];
    imgView.image = [UIImage imageNamed:@"toolbar_bottom_bar"];
    imgView.userInteractionEnabled = YES;
    self.imgView = imgView;
    [self.view addSubview:imgView];
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn1 setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateNormal];
//    [btn1 setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateHighlighted];
//    btn1.frame = CGRectMake(5, 5, 37, 40);
//    [btn1 addTarget:self action:@selector(btn1Aciton) forControlEvents:UIControlEventTouchUpInside];
//    [imgView addSubview:btn1];
//    
    _msgTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 6, kScreenWidth - 80, 32)];
    _msgTextView.layer.cornerRadius = 6;
    _msgTextView.backgroundColor = [UIColor whiteColor];
    [imgView addSubview:_msgTextView];
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn2 setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
//    
//    [btn2 setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
//    btn2.frame = CGRectMake(37, -2, 50, 50);
//    [imgView addSubview:btn2];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setImage:[UIImage imageNamed:@"fasong"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"fasong1"] forState:UIControlStateHighlighted];
    [btn3 addTarget:self action:@selector(sendMsg:) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(kScreenWidth-50, -2, 50, 50);
    [imgView addSubview:btn3];
    
}

//- (void)btn1Aciton
//{
////    NSLog(@"-------费噢诶而-----");
//    
//}
- (void)sendMsg:(UIButton *)btn
{
//    NSLog(@"------------");
    //    [_tableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    NSDictionary *dic = @{@"avatar_url":@"http://ww2.sinaimg.cn/crop.0.0.1080.1080.1024/d773ebfajw8eum57eobkwj20u00u075w.jpg",
                          @"content":_msgTextView.text,
                          @"created_at":@"0",
                          @"nickname":@"小明"};
    //    NSMutableArray *array = [NSMutableArray array];9
    //    [array addObject:dic];
    //    [self.dataArray arrayByAddingObjectsFromArray:array];
    
    CommentModel*model=[CommentModel new];
    [model setValuesForKeysWithDictionary:dic];
    
    NSMutableArray *commentArray = [NSMutableArray array];
    [commentArray addObject:model];
    [self.dataArray addObjectsFromArray:commentArray];
//    NSLog(@"%@",self.dataArray);
    [_tableView reloadData];
    _msgTextView.text = @"";
    [self.msgTextView resignFirstResponder];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //直接调用隐藏键盘的方法即可
    [_msgTextView resignFirstResponder];
 
}

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    [_tableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    //表视图滚动至底部。
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.frame = CGRectMake(0, -keyBoardFrame.size.height, kScreenWidth, kScreenHeight-45);
        self.imgView.frame = CGRectMake(0,  kScreenHeight-45-keyBoardFrame.size.height, kScreenWidth, 45);
    }];
    
    
    //重新加载表视图
    //    [_tableView reloadData];
    
    
}



-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    self.imgView.frame = CGRectMake(0, kScreenHeight-45, kScreenWidth, 45);
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-45);
    [_tableView reloadData];
    
}

#pragma mark - 滑动窗口时，键盘隐藏
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //直接调用隐藏键盘的方法即可
    [self.msgTextView resignFirstResponder];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
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
