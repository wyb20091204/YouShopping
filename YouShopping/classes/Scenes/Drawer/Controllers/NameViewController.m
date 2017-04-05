//
//  NameViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/20.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)overAction:(UIButton *)sender {
    self.block(self.nameTextField.text);
    
    [self.navigationController popViewControllerAnimated:YES];
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
