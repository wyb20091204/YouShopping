//
//  FirstDateilRequest.h
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseRequest.h"

@interface FirstDateilRequest : BaseRequest

+(instancetype)shareFirstDateil;

- (void)requestFirstDateilWithID:(NSString *)ID
                         Success:(SuccessResponse)success
                         failure:(FailureResponse)failure;

- (void)requestFirstTitleDateilCellWithID:(NSString *)ID
                                    success:(SuccessResponse)success
                                    failure:(FailureResponse)failure;

- (void)requestFirstCellDateilCellWithID:(NSString *)ID
                                   success:(SuccessResponse)success
                                   failure:(FailureResponse)failure;

//评论的解析
- (void)requestFirstdateilCommentWithID:(NSString *)ID
                                success:(SuccessResponse)success
                                failure:(FailureResponse)failure;


//轮播图详情

- (void)requestFirstHeaderDatrilWithID:(NSString *)ID
                               success:(SuccessResponse)success
                               failure:(FailureResponse)failure;

@end
