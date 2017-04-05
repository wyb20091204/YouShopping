//
//  Weather.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "Weather.h"
#import "Weather_data.h"
#import "Index.h"
#import <CoreLocation/CoreLocation.h>

@implementation Weather
+ (instancetype) weatherWithDict:(NSDictionary *)dict {
    
    Weather *w = [Weather new];
    [w setValuesForKeysWithDictionary:dict];
    
    NSArray *arr = dict[@"index"];
    NSMutableArray *indexs = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *d in arr) {
        
        Index *wd = [Index indexWithDictionary:d];
        [indexs addObject:wd];
        
    }
    w.indexs = indexs.copy;
    
    
    NSArray *weather_datas = dict[@"weather_data"];
    NSMutableArray *weathers = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *d in weather_datas) {
        
        Weather_data *wd = [Weather_data weather_dataWithDictionary:d];
        [weathers addObject:wd];
    }
    w.weather_datas = weathers.copy;
    return w;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

+ (void) loadWeatherWithCity:(CLLocation *)loca WithSuccessBlock:(void(^)(Weather *))successBlock andErrorBlock:(void(^)(NSError *))errorBlock {
    
    NSURL *url = [NSURL URLWithString:@"http://api.map.baidu.com/telematics/v3/weather?"];
    NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:url];
    requset.HTTPMethod = @"post";
    NSString *body = [NSString stringWithFormat:@"location=%f,%f&output=%@&ak=%@&mcode=%@", loca.coordinate.longitude, loca.coordinate.latitude, @"json", @"dOGHjxtz2yZHYbwVveBW4HXNbf3mENjc", @"cn.itgcq.weather"];
    requset.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", body);
    [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            NSLog(@"%@", connectionError);
            return;
        }
        
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *dict = responseObject[@"results"][0];
        NSLog(@"%@", responseObject);
        Weather *w = [Weather weatherWithDict:dict];
        
        if (successBlock) {
            successBlock(w);
        }
        
    }];
    
}

@end
