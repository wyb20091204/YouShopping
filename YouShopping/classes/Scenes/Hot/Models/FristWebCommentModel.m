//
//  FristWebCommentModel.m
//  YouShopping
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FristWebCommentModel.h"

@implementation FristWebCommentModel

//容错处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if([key isEqualToString:@"id"])
    {
        _ID = value;
    }
    

}



//热门跳转webView后,进入详情,点击评论
+ (NSMutableArray *)parseFristWebCommentWithDic:(NSDictionary *)dic
{
    
    NSArray *array = dic[@"data"][@"comments"];
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSDictionary *tmpDic in array) {
    
        FristWebCommentModel *model = [FristWebCommentModel new];
        
        [model setValuesForKeysWithDictionary:tmpDic];
        
        [mArr addObject:model];
    }
    
    return mArr;
}








@end
