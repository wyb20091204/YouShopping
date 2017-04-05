//
//  CalculateTool.m
//  趣味
//
//  Created by 李帅 on 16/6/17.
//  Copyright © 2016年 lindanda. All rights reserved.
//

#import "CalculateTool.h"

@implementation CalculateTool

//计算文本高度的方式
+ (CGFloat )getHeight:(NSString *)text{
    //计算文本的高度，返回文本所占的一个矩形的大小
    CGRect height = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 103, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return height.size.height;
    
}

@end
