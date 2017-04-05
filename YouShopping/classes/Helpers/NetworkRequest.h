//
//  NetworkRequest.h
//  LessionDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 liman. All rights reserved.
//

#import "BaseRequest.h"

// 成功回调
typedef void(^SuccessResponse)(NSDictionary *dic);
// 失败回调
typedef void(^FailureResponse)(NSError *error);

@interface NetworkRequest : BaseRequest

/*请求数据
 @url ：请求数据的url
 @parameterDic ：成功回调的block
 @success ：成功的回调
 @failure ：失败的回调
 */
- (void)requestWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameterDic
       successResponse:(SuccessResponse)success
       failureResponse:(FailureResponse)failure;







@end
