//
//  CommentModel.h
//  YouShopping
//
//  Created by 李帅 on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
//内容
@property (nonatomic, copy) NSString *content;
//点赞
@property (nonatomic, assign) NSInteger likes_count;
//头像
@property (nonatomic, copy) NSString *avatar_url;
//时间
@property (nonatomic, assign) NSInteger created_at;

@property (nonatomic, copy) NSString *nickname;
@end
