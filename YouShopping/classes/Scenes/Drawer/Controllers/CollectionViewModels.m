//
//  CollectionViewModels.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "CollectionViewModels.h"

@implementation CollectionViewModels
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = (NSInteger) value;
    }
}
@end
