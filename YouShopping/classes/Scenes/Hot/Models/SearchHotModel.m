//
//  SearchHotModel.m
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SearchHotModel.h"

@implementation SearchHotModel

//容错处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}


//热门数据解析
+ (NSMutableArray *)parseSearchBtnWithDic:(NSDictionary *)dic
{
    NSMutableArray *mArr= [NSMutableArray array];
  
        SearchHotModel *model = [SearchHotModel new];
        model = dic[@"data"];
        [mArr addObject:model];
    return mArr;
}






@end
