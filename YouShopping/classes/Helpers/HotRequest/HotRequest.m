//
//  HotRequest.m
//  YouShoping
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "HotRequest.h"

static HotRequest *request = nil;
@implementation HotRequest

//单例
+ (instancetype)shareHotRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        request = [[HotRequest alloc] init];
    });

    return request;
}


//热门主页请求
- (void)requestAllHotWithUrl:(NSString *)url
                     success:(SuccessResponse)success
                     failure:(FailureResponse)failure
{
    NetworkRequest *request =[[NetworkRequest alloc] init];
[request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
    success(dic);
} failureResponse:^(NSError *error) {
    failure(error);
}];
    
}




//热门评论界面数据请求   拼接ID
- (void)requestFristWebCommentWithID:(NSString *)ID
                                      Success:(SuccessResponse)success
                                      failure:(FailureResponse)failure
{
//    调用上面所有请求 的方法
    [self requestAllHotWithUrl:fristWebViewCommentRequest_URL(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}










@end
