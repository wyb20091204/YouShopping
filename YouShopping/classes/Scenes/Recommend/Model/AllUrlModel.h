//
//  AllUrlModel.h
//  YouShopping
//
//  Created by 李帅 on 16/7/18.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllUrlModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cover_image_url;

@property (nonatomic, copy) NSString *content_url;

@property (nonatomic, assign) NSInteger likes_count;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, assign) NSInteger shares_count;

@property (nonatomic, assign) NSString *ID;
@end
