//
//  HotCollectionViewCell.h
//  YouShoping
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
#import "SearchIntoModel.h"

#define HotCollectionViewCell_Identifier @"HotCollectionViewCell_Identifier"

@interface HotCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *hotImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *favoritesLabel;


//model 属性
@property (nonatomic,strong) HotModel *hotModel;



// 搜索进入的界面model
@property (nonatomic,strong) SearchIntoModel *searchIntoModel;





@end
