//
//  CouponsViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/25.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "CouponsViewController.h"

@interface CouponsViewController ()

@property(nonatomic, strong)UIView *backView;

@end

@implementation CouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"我的礼券";
    
    [self createViews];
}


- (void)createViews{
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.backView.center = self.view.center;
    [self.view addSubview:self.backView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    label.text = @"没有可用的点券";
    label.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:label];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"礼券码" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonAction)];
    
    
}


- (void)rightBarButtonAction{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
