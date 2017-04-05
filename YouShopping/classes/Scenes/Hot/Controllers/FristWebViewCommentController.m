//
//  FristWebViewCommentController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FristWebViewCommentController.h"

#import "HotRequest.h"
#import "FristWebCommentModel.h"
#import "CalculateTool.h"
#import "CommentTableViewCell.h"
@interface FristWebViewCommentController ()<UITableViewDataSource,UITableViewDelegate>

//评论界面
@property (nonatomic,strong) UITableView *tableView;

//评论界面数据
@property (nonatomic,strong) NSMutableArray *commentArray;


@end

@implementation FristWebViewCommentController


- (NSMutableArray *)commentArray
{
    if (_commentArray == nil) {
        
        _commentArray = [NSMutableArray array];
    }
    
    return _commentArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    设置线的颜色
//    self.tableView.separatorColor = [UIColor grayColor];
//    设置端距，这里表示separator离左边80像素
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 100, 0, 0);
//    设置样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommentTableViewCell_ID];
    
//    返回键
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot.png"]style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
//    解析数据
    [self fristWebCommentRequest];
    
}



//    返回按钮点击
- (void)returnAction:(UIBarButtonItem *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = YES;
    
}




//    解析数据 评论界面
- (void)fristWebCommentRequest
{
    __weak typeof(self)weakSelf = self;
    
    [[HotRequest shareHotRequest] requestFristWebCommentWithID:_ID Success:^(NSDictionary *dic) {
        
         weakSelf.commentArray = [FristWebCommentModel parseFristWebCommentWithDic:dic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    FristWebCommentModel *model = self.commentArray[indexPath.row];
    CGFloat height = [CalculateTool getHeight:model.content];
    
    return height + 90;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTableViewCell_ID];
    FristWebCommentModel *model = [FristWebCommentModel new];
   model = self.commentArray[indexPath.row];
    
    [cell.headerView setImageWithURL:[NSURL URLWithString:model.user[@"avatar_url"]] placeholderImage:nil];
    
    //    评论内容
    cell.contectLabel.text = model.content;
    
    cell.praiseLabel.text = [NSString stringWithFormat:@"%ld",model.like_count];
    //    用户名
    cell.nameLabel.text = model.user[@"nickname"];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    CGFloat totalTime = ((NSInteger)nowTime - model.created_at)/1000.0;
    NSInteger day = totalTime/86400;
    NSInteger hour = totalTime/3600;
    NSInteger min = totalTime/60;
    if (day > 0) {
        cell.timeLabel.text = [NSString stringWithFormat:@"%ld天前",day];
    } else if (hour > 0) {
        cell.timeLabel.text = [NSString stringWithFormat:@"%ld小时前",hour];
    } else if (min > 0){
        cell.timeLabel.text = [NSString stringWithFormat:@"%ld分钟前",min];
    } else {
        cell.timeLabel.text = [NSString stringWithFormat:@"小于1分钟"];
    }

    return cell;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
