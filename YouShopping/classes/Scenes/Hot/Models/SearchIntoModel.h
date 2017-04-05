//
//  SearchIntoModel.h
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchIntoModel : NSObject

//上拉加载
@property (nonatomic,copy) NSString *next_url;

//图片
@property (nonatomic,copy) NSString *cover_image_url;

//标题
@property (nonatomic,copy) NSString *name;

//价格
@property (nonatomic,copy) NSString *price;

//喜欢人数
@property (nonatomic,assign) NSInteger favorites_count;

//商品ID
@property (nonatomic,copy) NSString *ID;


//热门数据解析
+ (NSMutableArray *)parseSearchIntoInterfaceWithDic:(NSDictionary *)dic;




@end
