//
//  searchIntoWebViewController.h
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^searchID)(NSString *);

@interface searchIntoWebViewController : BaseViewController

//block接收传值的ID
@property (nonatomic,copy) searchID block;


//接收传值分享用 商品名
@property (nonatomic,copy) NSString *nameString;

//图片地址分享
@property (nonatomic,copy) NSString *imageUrl;

//传值ID 评论用
@property (nonatomic,copy) NSString *commentID;



@end
