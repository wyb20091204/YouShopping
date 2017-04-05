//
//  Weather.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Weather : NSObject
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, copy) NSString *pm25;
@property (nonatomic, strong) NSArray *indexs;
@property (nonatomic, strong) NSArray *weather_datas;

+ (instancetype) weatherWithDict:(NSDictionary *)dict;

+ (void) loadWeatherWithCity:(CLLocation *)loca WithSuccessBlock:(void(^)(Weather *))successBlock andErrorBlock:(void(^)(NSError *))errorBlock ;
@end
