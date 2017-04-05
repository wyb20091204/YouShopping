//
//  AllModel.h
//  YouShopping
//
//  Created by 李帅 on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColumnModel.h"
@interface AllModel : NSObject

//头像
@property (nonatomic, copy) NSString *avatar_url;

//图片
@property (nonatomic, copy) NSString *cover_image_url;

//@property (nonatomic, strong) NSDictionary *column;

//大标题
@property (nonatomic, copy) NSString *title;
//喜欢
@property (nonatomic, assign) NSInteger likes_count;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) ColumnModel *user;

@property (nonatomic, copy) NSString *ID;

+(NSMutableArray *)parseShufflingWithDic:(NSDictionary *)dic;

@end
