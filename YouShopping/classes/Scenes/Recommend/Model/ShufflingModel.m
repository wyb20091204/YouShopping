//
//  ShufflingModel.m
//  YouShoping
//
//  Created by 李帅 on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ShufflingModel.h"

@implementation ShufflingModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

+(NSMutableArray *)parseShufflingWithDic:(NSDictionary *)dic
{
    NSMutableArray *returenArr = [NSMutableArray array];
    NSDictionary *dict = [dic valueForKey:@"data"];
    for (NSDictionary *tmpDic in dict[@"banners"]) {
        ShufflingModel *model = [ShufflingModel new];
        [model setValuesForKeysWithDictionary:tmpDic];
        [returenArr addObject:model];
    }
    return returenArr;

}

@end
