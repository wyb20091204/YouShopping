//
//  SelectPresentWebView.m
//  YouShopping
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SelectPresentWebView.h"
#import <UMSocial.h>
#import "HotRequest.h"

@interface SelectPresentWebView ()<UMSocialUIDelegate>


@property (nonatomic,strong) UIWebView *webView;

//拿到跳转淘宝的网址
@property (nonatomic,strong) NSString *presentURL;


@end

@implementation SelectPresentWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"单品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
//    礼物单品请求数据  然后拿到网址跳转淘宝
    [self requestPresent];
    
    //    分享按钮
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareBtn;
}




//    返回点击事件
- (void)returnAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


//    礼物单品请求数据  然后拿到网址跳转淘宝
- (void)requestPresent
{
    __weak typeof(self)weakSelf = self;
    [[HotRequest shareHotRequest] requestAllHotWithUrl:[NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@",_ID] success:^(NSDictionary *dic) {
//    通过解析网址 拿到 跳转淘宝的网址
        weakSelf.presentURL = dic[@"data"][@"purchase_url"];

#warning load WebView dispatch_get_main_queue()------------- 回主线程加载-----
//        回到主线程 加载webView!
        dispatch_async(dispatch_get_main_queue(), ^{
            self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            //    把拿到的网址跳转淘宝
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_presentURL]];
            
                [self.view addSubview:_webView];
                [_webView loadRequest:request];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
