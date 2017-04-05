//
//  ShufflingModel.h
//  YouShoping
//
//  Created by 李帅 on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShufflingModel : NSObject

//轮播图图片
@property (nonatomic, copy) NSString *image_url;

@property (nonatomic, copy) NSString *target_id;

+ (NSMutableArray *)parseShufflingWithDic:(NSDictionary *)dic;

@end
