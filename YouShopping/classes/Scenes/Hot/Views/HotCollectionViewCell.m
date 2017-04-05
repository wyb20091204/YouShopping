//
//  HotCollectionViewCell.m
//  YouShoping
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "HotCollectionViewCell.h"

@implementation HotCollectionViewCell

- (void)awakeFromNib {
    
}


//set 方法
- (void)setHotModel:(HotModel *)hotModel
{
    
    if (_hotModel != hotModel) {
        _hotModel = nil;
        _hotModel = hotModel;
    }
    
    [_hotImageView setImageWithURL:[NSURL URLWithString:hotModel.cover_image_url] placeholderImage:nil];
    _nameLabel.text = hotModel.name;      // 名字
    _priceLabel.text = hotModel.price;    // 价格
    _favoritesLabel.text = [NSString stringWithFormat:@"%ld",hotModel.favorites_count];//收藏数
}








//搜索进入界面的Model; set 方法
- (void)setSearchIntoModel:(SearchIntoModel *)searchIntoModel{
    if (_searchIntoModel != searchIntoModel) {
        _searchIntoModel = nil;
        _searchIntoModel = searchIntoModel;
    }
    [_hotImageView setImageWithURL:[NSURL URLWithString:_searchIntoModel.cover_image_url]];
    _nameLabel.text = _searchIntoModel.name;
    _priceLabel.text = _searchIntoModel.price;
    _favoritesLabel.text = [NSString stringWithFormat:@"%ld",_searchIntoModel.favorites_count];
    
}


@end
