//
//  AddFriendCell.h
//  YouShopping
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const AddFriendViewCell_Identyfy = @"AddFriendViewCell_Identyfy";

@class AddFriendCell;
@protocol AddFriendsViewControllerDelegate <NSObject>

- (void)addFriendsViewControllerDidCellAddButtonAction:(AddFriendCell *)cell;

@end


@interface AddFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *friendIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *friendHeaderImgView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak,nonatomic)id<AddFriendsViewControllerDelegate> delegate;


@end
