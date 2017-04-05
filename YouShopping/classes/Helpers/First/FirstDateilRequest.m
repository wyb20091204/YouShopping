//
//  FirstDateilRequest.m
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FirstDateilRequest.h"

static FirstDateilRequest *request = nil;

@implementation FirstDateilRequest

+ (instancetype)shareFirstDateil
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[FirstDateilRequest alloc]init];
    });
    return request;
}

- (void)requestFirstDateilAllUrl:(NSString *)url success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetworkRequest *request = [NetworkRequest new];
    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

//标题的详情解析
- (void)requestFirstDateilWithID:(NSString *)ID Success:(SuccessResponse)success failure:(FailureResponse)failure
{
[self requestFirstDateilAllUrl:CellOntitleRequest(ID) success:^(NSDictionary *dic) {
    success(dic);
} failure:^(NSError *error) {
    failure(error);
}];
}
//轮播图的详情解析
- (void)requestFirstHeaderDatrilWithID:(NSString *)ID
                               success:(SuccessResponse)success
                               failure:(FailureResponse)failure
{
    [self requestFirstDateilAllUrl:FirstHeaderDatil(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//标题页面里的cell详情解析
- (void)requestFirstTitleDateilCellWithID:(NSString *)ID
                               success:(SuccessResponse)success
                               failure:(FailureResponse)failure
{
    [self requestFirstDateilAllUrl:TitleOnCellRequest(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//cell里的详情解析
- (void)requestFirstCellDateilCellWithID:(NSString *)ID
                                   success:(SuccessResponse)success
                                   failure:(FailureResponse)failure
{
    [self requestFirstDateilAllUrl:EnterCellRequest(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//评论的解析
- (void)requestFirstdateilCommentWithID:(NSString *)ID
                                success:(SuccessResponse)success
                                failure:(FailureResponse)failure
{
    [self requestFirstDateilAllUrl:commentRequest(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



@end
