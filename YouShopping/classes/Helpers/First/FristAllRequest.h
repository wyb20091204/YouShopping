//
//  FristAllRequest.h
//  YouShopping
//
//  Created by 李帅 on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseRequest.h"

@interface FristAllRequest : BaseRequest

+ (instancetype)shareAllRequest;

//全部解析
- (void)requestAllpageWithUrl:(NSString *)url success:(SuccessResponse)success failure:(FailureResponse)failure;

- (void)requestShufflingSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//1
- (void)requestDataSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//2
- (void)requestSecondSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//3
- (void)requestThirdSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//4
- (void)requestFourthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//5
- (void)requestFifthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//6
- (void)requestSixthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//7
- (void)requestSeventhSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//8
- (void)requestEighthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//9
- (void)requestNinethSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//10
- (void)requestTenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//11
- (void)requestEleventhSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//12
- (void)requestTwelfthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//13
- (void)requestThirteenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//14
- (void)requestFourteenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//15
- (void)requestFifteenSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//16
- (void)requestSixteenthSuccess:(SuccessResponse)success failure:(FailureResponse)failure;

@end
