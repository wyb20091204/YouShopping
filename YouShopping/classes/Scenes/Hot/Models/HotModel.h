//
//  HotModel.h
//  YouShoping
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject

@property (nonatomic,copy) NSString *cover_image_url;  //图片url
@property (nonatomic,copy) NSString *name;             //名字 cell个数
@property (nonatomic,assign) NSInteger favorites_count;//喜欢人数
@property (nonatomic,copy) NSString *price;            //价格
@property (nonatomic,copy) NSString *purchase_id;      //购买ID
@property (nonatomic,copy) NSString *next_url;         //加载更多URL
@property (nonatomic,copy) NSString *ID;


//热门数据解析
+ (NSMutableArray *)parseHotWithDic:(NSDictionary *)dic;


//快速选择礼物排序 解析
+ (NSMutableArray *)parseSelectPresentWithDic:(NSDictionary *)dic;




@end
