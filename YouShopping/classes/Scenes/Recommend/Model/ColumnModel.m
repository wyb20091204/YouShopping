//
//  ColumnModel.m
//  YouShopping
//
//  Created by 李帅 on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ColumnModel.h"

@implementation ColumnModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

@end
