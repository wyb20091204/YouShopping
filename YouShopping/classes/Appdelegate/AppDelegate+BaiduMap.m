//
//  AppDelegate+BaiduMap.m
//  YouShopping
//
//  Created by lanou3g on 16/7/29.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AppDelegate+BaiduMap.h"

@implementation AppDelegate (BaiduMap)

- (void)setBaiduManegerWithKey:(NSString *)aKey{
    
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数     自己申请的 百度 Key
    BOOL ret = [mapManager start:aKey  generalDelegate:nil];
    if (!ret) {
//        NSLog(@"manager start failed!");
    }

    
}


@end
