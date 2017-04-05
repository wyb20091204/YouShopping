//
//  SearchHotModel.h
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHotModel : NSObject

//热搜  名词:(手链 提包等等)
@property (nonatomic,strong) NSArray *hot_words;

//搜索  占位语
@property (nonatomic,copy) NSString *placeholder;



//热门数据解析
+ (NSMutableArray *)parseSearchBtnWithDic:(NSDictionary *)dic;



@end
