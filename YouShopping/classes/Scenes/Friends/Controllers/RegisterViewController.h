//
//  RegisterViewController.h
//  优GO
//
//  Created by 李帅 on 16/7/12.
//  Copyright © 2016年 linda. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^regist)(NSString *userName);


@interface RegisterViewController : BaseViewController


@property (copy,nonatomic)regist registBlock;

@end
