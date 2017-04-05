//
//  CXCarouselView.h
//  pregnant-information
//
//  Created by 王长旭 on 16/2/25.
//  Copyright © 2016年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXCarouseViewDelegate;
@interface CXCarouselView : UIView

@property (weak, nonatomic) id<CXCarouseViewDelegate> delegate;

+(instancetype)initWithFrame:(CGRect)frame hasTimer:(BOOL) hastimer interval:(NSUInteger) inter placeHolder:(UIImage*) image;

-(void) setupWithArray:(NSArray *)array;
-(void) destroy;
-(void) restart;

@end

@protocol CXCarouseViewDelegate <NSObject>

- (void) carouselTouch:(CXCarouselView*)carousel atIndex:(NSUInteger)index;

@end
