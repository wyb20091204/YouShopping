//
//  FirstDateilModel.m
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FirstDateilModel.h"

@implementation FirstDateilModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    
}


+ (NSMutableArray *)parseFirstDateilAllWithDic:(NSDictionary *)dic
{
    NSMutableArray *returnArray = [NSMutableArray array];
    NSDictionary *dict = [dic valueForKey:@"data"];
    NSMutableArray *tempArr = [dict valueForKey:@"posts"];
    for (NSDictionary *tempDic in tempArr) {
        FirstDateilModel *model = [FirstDateilModel new];
        model.nickname = tempDic[@"author"][@"nickname"];
        [model setValuesForKeysWithDictionary:tempDic];
        [returnArray addObject:model];
    }
    return returnArray;
}
@end

