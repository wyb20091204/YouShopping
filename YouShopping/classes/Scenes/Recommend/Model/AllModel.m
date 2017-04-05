//
//  AllModel.m
//  YouShopping
//
//  Created by 李帅 on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AllModel.h"

@implementation AllModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else if ([key isEqualToString:@"column"]) {
        ColumnModel *model = [ColumnModel new];
        [model setValuesForKeysWithDictionary:value];
        _user = model;
    }

}


+ (NSMutableArray *)parseShufflingWithDic:(NSDictionary *)dic
{
    NSMutableArray *returnArray = [NSMutableArray array];
    NSDictionary *secondDic = [dic valueForKey:@"data"];
    for (NSDictionary *thirdDic in secondDic[@"items"]) {
        AllModel *model = [AllModel new];
        [model setValuesForKeysWithDictionary:thirdDic];
        [returnArray addObject:model];
    }
    return returnArray;
}

@end
