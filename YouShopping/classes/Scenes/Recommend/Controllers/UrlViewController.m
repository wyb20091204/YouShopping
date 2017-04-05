//
//  UrlViewController.m
//  YouShopping
//
//  Created by 李帅 on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "UrlViewController.h"
#import "FirstDateilRequest.h"
#import "AllUrlModel.h"
#import "CommentViewController.h"
#import <UMSocial.h>
#import "LoginViewController.h"
#import "Savemodel.h"

@interface UrlViewController ()<UIWebViewDelegate,UMSocialUIDelegate>

@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, strong) UILabel *likeLabel;

@property (nonatomic, strong) AllUrlModel *model;

@property (nonatomic, strong) NSMutableArray *saveArray;

/** 反归档数组 */
@property (strong,nonatomic)NSMutableArray *fgdMuarr;

@end

@implementation UrlViewController

- (NSMutableArray *)saveArray
{
    if (!_saveArray) {
        _saveArray = @[].mutableCopy;
    }
    return _saveArray;
}

- (NSMutableArray *)fgdMuarr{
    if (!_fgdMuarr) {
        _fgdMuarr = @[].mutableCopy;
    }
    return _fgdMuarr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"攻略详情";
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backHot"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
    [self requestData];
    
}

- (void)backAction:(UIBarButtonItem *)barButtonItem
{
//    self.rootVC.tabBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}



//解析
- (void)requestData
{
     __weak typeof(self)weakSelf = self;
    [[FirstDateilRequest shareFirstDateil]requestFirstCellDateilCellWithID:self.ID success:^(NSDictionary *dic) {
        NSDictionary *dict = [dic valueForKey:@"data"];
        AllUrlModel *model = [AllUrlModel new];
        [model setValuesForKeysWithDictionary:dict];
        self.model = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf updateSubView:_model];
            [weakSelf webviewSubView:_model.content_url];
            [weakSelf footView:_model];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//顶部的图片和标题
- (void)updateSubView:(AllUrlModel *)model
{
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight /4)];
    [titleView setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    [self.view addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleView.frame) + 10, kScreenWidth - 20, 60)];
    titleLabel.numberOfLines = 0;
    titleLabel.text = model.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
}
//加载的webView
- (void)webviewSubView:(NSString *)string
{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kScreenHeight/4 + 126, kScreenWidth, kScreenHeight - 100)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

- (void)footView:(AllUrlModel *)model
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    view.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1];
    [self.view addSubview:view];
    
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    likeBtn.frame = CGRectMake(kScreenWidth*0.1, 10, 32, 32);
    // 判断是否已收藏,如果收藏了红心,没收藏白心
    NSArray *arr =  [[NSUserDefaults standardUserDefaults] arrayForKey:@"Key"];
    NSMutableArray *urlArr = @[].mutableCopy;
    for (NSData *data in arr) {
        AllUrlModel * mo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [urlArr addObject:mo.cover_image_url];
    };
    
    if ([urlArr containsObject:self.model.cover_image_url]) {
        [likeBtn setImage:[UIImage imageNamed:@"starY"] forState:UIControlStateNormal];
        self.likeLabel.text = [NSString stringWithFormat:@"%ld",_model.likes_count + 1];
    } else {
        [likeBtn setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    [likeBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:likeBtn];
    self.likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.2, 15, kScreenWidth *0.17, 20)];
    _likeLabel.text = [NSString stringWithFormat:@"%ld",model.likes_count];
    self.likeLabel.textColor = [UIColor redColor];
    [view addSubview:_likeLabel];
    
   
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(kScreenWidth*0.45, 10, 32, 32);
    [shareBtn setImage:[UIImage imageNamed:@"shareH"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:shareBtn];
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.55, 15, kScreenWidth * 0.17, 20)];
    shareLabel.text = [NSString stringWithFormat:@"%ld",model.shares_count];
    shareLabel.textColor = [UIColor redColor];
    [view addSubview:shareLabel];

    
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(kScreenWidth*0.75, 10, 32, 32);
    [commentBtn setImage:[UIImage imageNamed:@"comment123"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(skipCommentPage:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:commentBtn];
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.85, 15, kScreenWidth *0.17, 20)];
    commentLabel.text = [NSString stringWithFormat:@"%ld",model.comments_count];
    commentLabel.textColor = [UIColor redColor];
    [view addSubview:commentLabel];
    
}
//跳转到评论页面
- (void)skipCommentPage:(UIButton *)btn
{
    
    CommentViewController *commentVC = [CommentViewController new];
    commentVC.ID = _model.ID;
    NSLog(@"%@",commentVC.ID);
    [self.navigationController pushViewController:commentVC animated:YES];
}

//分享事件
- (void)shareAction:(UIButton *)btn{
 
        //  把传过来的网址  转换成图片!!
        NSURL *url = [NSURL URLWithString:_model.cover_image_url];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image1 = [UIImage imageWithData:data];
        
        // 可不可以分享url
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"578e10c767e58e570f0035f9"
                                          shareText:_model.title
                                         shareImage:image1
                                    shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline]
                                        delegate:self];
    
   
}

//实现回调方法：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
//        NSLog(@"分享的排平台是 %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


//旁边数字加一
- (void)addBtnAction:(UIButton *)sender
{
    User *user = [userDefaults getUserInfo];
    // 如果登陆了就收藏
    if (user.loginState) {
        //判断是否选中,是改成否改变图片label计数加一
        // 判断红心的图片
        
     //   sender.tag = !sender.tag;
        if ([sender.imageView.image isEqual:[UIImage imageNamed:@"star"]]) {
            [sender setImage:[UIImage imageNamed:@"starY"] forState:UIControlStateNormal];
            self.likeLabel.text = [NSString stringWithFormat:@"%ld",_model.likes_count + 1];
             NSLog(@"\n%@",NSHomeDirectory());
            [self saveUserDefaultData];
            
        }else
        {
            [sender setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            self.likeLabel.text = [NSString stringWithFormat:@"%ld",_model.likes_count];
            
            [self deleteSaveCurrent];
        }

    }
    // 没登陆跳转到登录界面
    else {
        LoginViewController *loginVC = [LoginViewController new];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}

- (void)saveUserDefaultData{
    // 先取出数组
    self.saveArray = [[NSUserDefaults standardUserDefaults]arrayForKey:@"Key"].mutableCopy;
    // 把数组data转换成model
    for (NSData *dt in self.saveArray) {
        AllUrlModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithData:dt];
        // 得到之前收藏的model数组(data转换之后的)
        [self.fgdMuarr addObject:dataModel];
    }
    // 把本页变红之后的model放到所有收藏的Arr里
    [self.fgdMuarr addObject:self.model];
    // 移除data数组所有元素,方便存储新值
    [self.saveArray removeAllObjects];
    // 把更新收藏之后的model数组转换成data数组
    for (AllUrlModel *mm in self.fgdMuarr) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mm];
        // 把清空的data数组附上更新之后的收藏data值
        [self.saveArray addObject:data];
    }
    // 把更新的data数组存本地
    [[NSUserDefaults standardUserDefaults] setObject:self.saveArray forKey:@"Key"];
    // 移除model数组,防止下次进入重复添加
    [self.fgdMuarr removeAllObjects];
}

- (void)deleteSaveCurrent{
    // 先取出数组
    self.saveArray = [[NSUserDefaults standardUserDefaults]arrayForKey:@"Key"].mutableCopy;
    // 把数组data转换成model
    for (NSData *dt in self.saveArray) {
        AllUrlModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithData:dt];
        // 得到之前收藏的model数组(data转换之后的)
        [self.fgdMuarr addObject:dataModel];
    }
    // 根据当前图片,得到本地对应收藏图片的model
    for (AllUrlModel *mo in self.fgdMuarr) {
        if ([mo.cover_image_url isEqualToString:self.model.cover_image_url]) {
            [self.fgdMuarr removeObject:mo];
            // 删除之后 重新存储更新后arr
            // 移除data数组所有元素,方便存储新值
            [self.saveArray removeAllObjects];
            // 把更新收藏之后的model数组转换成data数组
            for (AllUrlModel *mm in self.fgdMuarr) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mm];
                // 把清空的data数组附上更新之后的收藏data值
                [self.saveArray addObject:data];
            }
            // 把更新的data数组存本地
            [[NSUserDefaults standardUserDefaults] setObject:self.saveArray forKey:@"Key"];
            // 移除model数组,防止下次进入重复添加
            [self.fgdMuarr removeAllObjects];
            
            
            return;
        }
    }
    
    
    [self.fgdMuarr removeObject:self.model];

    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // self.rootVC.tabBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
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
