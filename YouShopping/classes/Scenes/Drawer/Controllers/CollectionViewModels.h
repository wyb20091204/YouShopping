//
//  CollectionViewModels.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionViewModels : NSObject
@property(nonatomic, strong)NSString *icon_url;

@property(nonatomic, assign)NSInteger ID;

@property(nonatomic, assign)NSInteger items_count;

@property(nonatomic, strong)NSString *name;

@property(nonatomic, assign)NSInteger order;

@property(nonatomic, assign)NSInteger parent_id;

@property(nonatomic, assign)NSInteger status;
@end
