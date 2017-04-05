//
//  Weather_data.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "Weather_data.h"

@implementation Weather_data
+ (instancetype) weather_dataWithDictionary:(NSDictionary *)dict {
    
    Weather_data *wd = [Weather_data new];
    
    [wd setValuesForKeysWithDictionary:dict];
    
    return wd;
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
