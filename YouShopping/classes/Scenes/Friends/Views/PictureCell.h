//
//  PictureCell.h
//  YouShopping
//
//  Created by Yibo呀 on 16/7/28.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const PictrueCell_Identify = @"PictrueCell_Identify";


@interface PictureCell : UITableViewCell

@property (strong,nonatomic)UIImage *image;

@property (strong,nonatomic)NSString *resaveUrl;

@end
