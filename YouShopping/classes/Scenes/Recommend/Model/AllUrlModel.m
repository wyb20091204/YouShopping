
//
//  AllUrlModel.m
//  YouShopping
//
//  Created by 李帅 on 16/7/18.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "AllUrlModel.h"

@implementation AllUrlModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_cover_image_url forKey:@"cover_image_url"];
    [aCoder encodeObject:_title  forKey:@"title"];
    [aCoder encodeObject:_content_url forKey:@"content_url"];
    [aCoder encodeInteger:_likes_count forKey:@"likes_count"];
    [aCoder encodeInteger:_comments_count forKey:@"comments_count"];
    [aCoder encodeInteger:_shares_count forKey:@"shares_count"];
    [aCoder encodeObject:_ID forKey:@"ID"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _cover_image_url = [aDecoder decodeObjectForKey:@"cover_image_url"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _content_url = [aDecoder decodeObjectForKey:@"content_url"];
        _likes_count = [aDecoder decodeIntegerForKey:@"likes_count"];
        _comments_count = [aDecoder decodeIntegerForKey:@"comments_count"];
        _shares_count = [aDecoder decodeIntegerForKey:@"shares_count"];
        _ID = [aDecoder decodeObjectForKey:@"ID"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n   title:%@\n  cover_image_url:%@\n  content_url :%@\n  likes_count:%ld\n  comments_count:%ld\n  shares_count:%ld\n  ID:%@", _title,_cover_image_url,_content_url,_likes_count,_comments_count,_shares_count,_ID];
}

@end
