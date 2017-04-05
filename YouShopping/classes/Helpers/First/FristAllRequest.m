//
//  FristAllRequest.m
//  YouShopping
//
//  Created by 李帅 on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "FristAllRequest.h"


static FristAllRequest *request = nil;
@implementation FristAllRequest


+ (instancetype)shareAllRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[FristAllRequest alloc]init];
    });
    return request;
}

//全部解析
- (void)requestAllpageWithUrl:(NSString *)url success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetworkRequest *request = [NetworkRequest new];
    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

//轮播图解析
- (void)requestShufflingSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:ShufflingFigure_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第一页的解析
- (void)requestDataSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:selection_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第二页的解析
- (void)requestSecondSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:second_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第三页的解析
- (void)requestThirdSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
{
    [self requestAllpageWithUrl:Third_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第四页的解析
- (void)requestFourthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Fourth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第五页的解析
- (void)requestFifthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Fifth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第六页的解析
- (void)requestSixthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Sixth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第七页的解析
- (void)requestSeventhSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Seventh_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第八页的解析
- (void)requestEighthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Eighth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第九页的解析
- (void)requestNinethSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Nineth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第十页的解析
- (void)requestTenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Tenth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第十一页的解析
- (void)requestEleventhSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Eleventh_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第十二页的解析
- (void)requestTwelfthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Twelfth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第十三页的解析
- (void)requestThirteenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Thirteenth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第十四页的解析
- (void)requestFourteenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Fourteenth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第十五页的解析
- (void)requestFifteenSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Fifteenth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//第十六页的解析
- (void)requestSixteenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllpageWithUrl:Sixteenth_url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



@end
