//
//  FristWebCommentModel.h
//  YouShopping
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FristWebCommentModel : NSObject

//评论内容
@property (nonatomic,copy) NSString *content;

//评论时间
@property (nonatomic,assign) NSInteger created_at;


@property (nonatomic,copy) NSString *ID;

@property (nonatomic, assign) NSInteger like_count;

// 字典里面有  头像avatar_url 和  用户名nickname
@property (nonatomic,copy) NSDictionary *user;




//热门跳转webView后,进入详情,点击评论
+ (NSMutableArray *)parseFristWebCommentWithDic:(NSDictionary *)dic;




@end
