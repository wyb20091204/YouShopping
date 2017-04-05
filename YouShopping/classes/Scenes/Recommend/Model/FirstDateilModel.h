//
//  FirstDateilModel.h
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FirstDateilModel : NSObject



//cell的标题
@property (nonatomic, copy) NSString *title;

//时间
@property (nonatomic, assign) NSInteger updated_at;

//名字
@property (nonatomic, copy) NSString *nickname;

//喜欢
@property (nonatomic, assign) NSInteger likes_count;

//图片
@property (nonatomic, copy) NSString *cover_image_url;

//url
@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *ID;


+(NSMutableArray *)parseFirstDateilAllWithDic:(NSDictionary *)dic;

@end
