//
//  searchIntoWebViewController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "searchIntoWebViewController.h"
#import <UMSocial.h>
#import "FristWebViewCommentController.h"

@interface searchIntoWebViewController ()<UMSocialUIDelegate>

@property (nonatomic,strong) UIWebView *webView;



@end

@implementation searchIntoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
//    block接收上面页面传过来的ID
    __weak typeof(self) weakSelf = self;
    self.block = ^(NSString *idStr){
        
//    创建WebView 传入ID  拼接网址
        [weakSelf createWebView:idStr];
    };
    
#warning hidden tabBar ---------这里是普通隐藏tabBar!!!  应该在push的时候隐藏 写法在热门主页面push中写的很明白
//    隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
    
//    返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
//    分享按钮
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction:)];
//    评论按钮
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"comment.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(commentAction:)];
//    添加多个按钮到导航栏
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:shareBtn,commentBtn,nil]];
    
}


//返回按钮
- (void)returnAction:(UIBarButtonItem *)sender
{

    [self.navigationController popViewControllerAnimated:YES];
//显示TabBar
    self.tabBarController.tabBar.hidden = NO;
}




//用户评论  点击跳转
- (void)commentAction:(UIBarButtonItem *)sender
{
    FristWebViewCommentController *commentVC = [FristWebViewCommentController new];
    [self.navigationController pushViewController:commentVC animated:YES];
    
//评论用
    commentVC.ID = _commentID;
    
}






//友盟分享
- (void)shareAction:(UIBarButtonItem *)sender
{
    //  把传过来的网址  转换成图片!!
    NSURL *url = [NSURL URLWithString:_imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image1 = [UIImage imageWithData:data];
    
    // 可不可以分享url
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"578e10c767e58e570f0035f9"
                                      shareText:_nameString
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






//创建WebView
- (void)createWebView:(NSString *)str
{
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//把接受到的ID和网址合成新的连接.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://h5.m.taobao.com/awp/core/detail.htm?u_channel=1-23091647&umpChannel=1-23091647&exParams=%%7B%%22umpChannel%%22:%%221-23091647%%22,%%22u_channel%%22:%%221-23091647%%22,%%22referer%%22:%%22ALBBItemDetailPage.taobaoH5%%22%%7D&ttid=2014_0_23091647@baichuan_ios_2.1&id=%@&_viewType=taobaoH5",str]]];
    
    [self.view addSubview:_webView];
//加载连接
    [_webView loadRequest:request];
    
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
