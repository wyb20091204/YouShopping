//
//  TableViewModel.h
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewModel : NSObject

@property(nonatomic, strong)NSString *icon_url;

@property(nonatomic, assign)NSInteger ID;

@property(nonatomic, strong)NSString *name;

@property(nonatomic, assign)NSInteger order;

@property(nonatomic, assign)NSInteger *status;

@property(nonatomic, strong)NSArray *subcategories;
@end
