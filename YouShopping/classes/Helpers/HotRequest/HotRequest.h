//
//  HotRequest.h
//  YouShoping
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequest.h"

@interface HotRequest : NSObject

+ (instancetype)shareHotRequest;


//热门主页请求
- (void)requestAllHotWithUrl:(NSString *)url
                     success:(SuccessResponse)success
                     failure:(FailureResponse)failure;




//热门评论界面数据请求   拼接ID
- (void)requestFristWebCommentWithID:(NSString *)ID
                             Success:(SuccessResponse)success
                             failure:(FailureResponse)failure;



@end
