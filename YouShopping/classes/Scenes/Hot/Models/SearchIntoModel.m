//
//  SearchIntoModel.m
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SearchIntoModel.h"

@implementation SearchIntoModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }

}





//热门数据解析
+ (NSMutableArray *)parseSearchIntoInterfaceWithDic:(NSDictionary *)dic
{
    NSMutableArray *mArr = [NSMutableArray array];
    
    mArr = dic[@"data"][@"items"];
    
    return mArr;
}






@end
