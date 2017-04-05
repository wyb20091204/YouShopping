//
//  Index.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Index : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *zs;
@property (nonatomic, copy) NSString *tipt;
@property (nonatomic, copy) NSString *des;

+ (instancetype) indexWithDictionary:(NSDictionary *)dict;
@end
