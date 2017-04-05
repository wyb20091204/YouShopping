//
//  WebViewHotController.h
//  YouShopping
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewHotController : BaseViewController

//接收传值的ID
@property (nonatomic,copy) NSString *ID;

//评论界面ID
@property (nonatomic,copy) NSString *commentID;



//接收传值分享用
@property (nonatomic,copy) NSString *nameString;

//图片地址分享
@property (nonatomic,copy) NSString *imageUrl;


@end
