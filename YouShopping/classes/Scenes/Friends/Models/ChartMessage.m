//
//  ChartMessage.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/27.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ChartMessage.h"

@implementation ChartMessage


- (void)setContent:(NSString *)content{
    if (_content != content) {
        _content = nil;
        _content = content;
    }
    // 根据聊天消息内容对字体的frame进行设置
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 160, 1000) options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]}
                                        context:nil];
    _frame = rect;
}



@end
