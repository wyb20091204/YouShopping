//
//  WebViewHotController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "WebViewHotController.h"
#import <UMSocial.h>
#import "FristWebViewCommentController.h"


//友盟分享遵循代理
@interface WebViewHotController ()<UMSocialUIDelegate>

@property (nonatomic,strong) UIWebView *webView;



@end

@implementation WebViewHotController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
//    创建WebView
    [self createWebView];
    
    
//    分享按钮
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction:)];
//    评论按钮
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"comment.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(commentAction:)];
//    添加多个按钮到导航栏
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:shareBtn,commentBtn,nil]];
    
    
}



//用户评论  点击跳转
- (void)commentAction:(UIBarButtonItem *)sender
{
    FristWebViewCommentController *FristWebCommentVC = [FristWebViewCommentController new];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:FristWebCommentVC animated:YES];
    
//    把评论ID 传到 评论界面
    FristWebCommentVC.ID = self.commentID;
    
}






//友盟分享
- (void)shareAction:(UIBarButtonItem *)sender
{
    //  把传过来的网址  转换成图片!!
    NSURL *url = [NSURL URLWithString:_imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image1 = [UIImage imageWithData:data];
    
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
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}





//    返回点击事件
- (void)returnAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}






//    创建WebView
- (void)createWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    把接受到的ID和网址合成新的连接.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://h5.m.taobao.com/awp/core/detail.htm?u_channel=1-23091647&umpChannel=1-23091647&exParams=%%7B%%22umpChannel%%22:%%221-23091647%%22,%%22u_channel%%22:%%221-23091647%%22,%%22referer%%22:%%22ALBBItemDetailPage.taobaoH5%%22%%7D&ttid=2014_0_23091647@baichuan_ios_2.1&id=%@&_viewType=taobaoH5",_ID]]];
    
    [self.view addSubview:_webView];
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
