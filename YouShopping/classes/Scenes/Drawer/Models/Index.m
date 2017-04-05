//
//  Index.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "Index.h"

@implementation Index
+ (instancetype) indexWithDictionary:(NSDictionary *)dict {
    
    Index *ind = [Index new];
    
    [ind setValuesForKeysWithDictionary:dict];
    
    return ind;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
