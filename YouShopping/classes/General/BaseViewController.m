//
//  BaseViewController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@property(nonatomic, strong)NSString *status;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *string = [ud objectForKey:@"state"];
    
    if (string.length == 0) {
        self.status = @"white";
    } else {
        self.status = string;
    }
    
    if ([self.status isEqualToString:@"night"]) {
//        NSLog(@"1");
        self.view.backgroundColor = [UIColor colorWithRed:10 / 255.0 green:29 /255.0 blue:64 / 255.0 alpha:1];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
//        NSLog(@"2");
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBackGroudColor) name:@"night" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeBackGroudColor{
//    NSLog(@"night");
    if ([self.status isEqualToString:@"night"]) {
//        NSLog(@"111");
        self.view.backgroundColor = [UIColor whiteColor];
        self.status = @"white";
        
    } else {
        self.view.backgroundColor = [UIColor colorWithRed:10 / 255.0 green:29 /255.0 blue:64 / 255.0 alpha:1];
        self.status = @"night";
//        NSLog(@"222");
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.status forKey:@"state"];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"night"];
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
