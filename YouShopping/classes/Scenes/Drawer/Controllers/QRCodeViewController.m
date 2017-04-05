//
//  QRCodeViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/16.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "QRCodeViewController.h"
#import <CoreImage/CoreImage.h>
#import "MBProgressHUD.h"

@interface QRCodeViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic, strong)UITapGestureRecognizer *tap;
@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = NO;
    
    self.imageView.userInteractionEnabled = YES;
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction)];
    
    self.tap.delegate = self;
    
    [self.imageView addGestureRecognizer:self.tap];
    
    [self createQRCode];
}

- (void)createQRCode{
    // 1. 实例化二维码滤镜:
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //2. 恢复滤镜的默认属性: (可能保留着之前的设计)
    [filter setDefaults];
    
    //3. 设置二维码内容
    NSString *string = @"https://github.com/wyb20091204/YouShopping";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //4.通过KVC设置滤镜,传入data
    [filter setValue:data forKey:@"inputMessage"];
    
    //5. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    //6. 展示
    self.imageView.image = [[UIImage alloc]initWithCIImage:outputImage];
}


- (void)handleTapAction{
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享给朋友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存到本地" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
#warning failure
        UIImageWriteToSavedPhotosAlbum(weakSelf.imageView.image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    [alertC addAction:shareAction];
    [alertC addAction:saveAction];
    [alertC addAction:cancelAction];
    [self presentViewController:alertC animated:YES completion:nil];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    if (error == nil) {
        hud.labelText = @"保存成功";
    }else{
        hud.labelText = @"保存失败";
        NSLog(@"QRCode -- %@", error);
    }
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
