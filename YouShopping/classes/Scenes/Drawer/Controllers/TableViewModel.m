//
//  TableViewModel.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "TableViewModel.h"

@implementation TableViewModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = (NSInteger) value;
    }
}
@end
