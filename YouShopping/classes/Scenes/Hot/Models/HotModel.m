//
//  HotModel.m
//  YouShoping
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

//容错处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
    
}



//热门数据解析
+ (NSMutableArray *)parseHotWithDic:(NSDictionary *)dic
{
    NSArray *array = dic[@"data"][@"items"];
    NSMutableArray *returnHot = [NSMutableArray array];
    for (NSDictionary *temDic in array) {
        HotModel *model = [HotModel new];
        [model setValuesForKeysWithDictionary:temDic[@"data"]];
        [returnHot addObject:model];
    }
   
    return returnHot;
}





//快速选择礼物排序 解析
+ (NSMutableArray *)parseSelectPresentWithDic:(NSDictionary *)dic
{
    NSArray *array = dic[@"data"][@"items"];
    NSMutableArray *returnHot = [NSMutableArray array];
    for (NSDictionary *temDic in array) {
        HotModel *model = [HotModel new];
        [model setValuesForKeysWithDictionary:temDic];
        [returnHot addObject:model];
    }
    
    return returnHot;
}








@end
