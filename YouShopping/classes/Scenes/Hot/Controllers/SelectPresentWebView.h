//
//  SelectPresentWebView.h
//  YouShopping
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectPresentWebView : BaseViewController

//接收传值ID
@property (nonatomic,strong) NSString *ID;



//接收传值分享用
@property (nonatomic,copy) NSString *nameString;

//图片地址分享
@property (nonatomic,copy) NSString *imageUrl;

@end
