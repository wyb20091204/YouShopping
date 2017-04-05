//
//  ZCell.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ZCell.h"

@interface ZCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipt;
@property (weak, nonatomic) IBOutlet UILabel *zs;

@property (weak, nonatomic) IBOutlet UILabel *des;

@end

@implementation ZCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setIdx:(Index *)idx {
    
    _idx = idx;
    self.tipt.text = idx.tipt;
    self.zs.text = idx.zs;
    self.des.text = idx.des;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
