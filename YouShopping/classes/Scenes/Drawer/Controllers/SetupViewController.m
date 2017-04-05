//
//  SetupViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/25.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SetupViewController.h"
#import "SetupTableViewCell.h"
#import "LoginViewController.h"
#import "FriendsManager.h"

@interface SetupViewController ()<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *titleArr;

@property(nonatomic, strong)NSArray *imageArr;

@property(nonatomic, strong)NSMutableArray *detailArr;

@property(nonatomic, strong)NSString *state;
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.titleArr = @[@"给我们评分吧", @"意见反馈", @"客服电话", @"清除缓存", @"夜间模式", @"邀请好友使用优购", @"关于优购"];
    self.imageArr = @[@"star123", @"suggestion", @"phone", @"clear", @"night", @"share123", @"about"];
    self.detailArr = [@[@"", @"", @"9823423", @"99.99M", @"", @"", @""] mutableCopy];
    
    self.title = @"设置";
    
    
    [self createViews];
}
- (void)createViews{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"SetupTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SetupTableViewCell"];
    
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 7;
    } else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupTableViewCell"];

    if (indexPath.row == 3) {
        self.detailArr[3] = [NSString stringWithFormat:@"%.1fM", [self getFilePath]];
    }
    if (indexPath.row != 4) {
        cell.mySwitch.hidden = YES;
    } else {
        cell.detailLabel.hidden = YES;
        self.state = [[NSUserDefaults standardUserDefaults] objectForKey:@"isOn"];

        if ((self.state.length == 0)) {
            [cell.mySwitch setOn:NO];
            self.state = [NSString stringWithFormat:@"%i", cell.mySwitch.isOn] ;
            [[NSUserDefaults standardUserDefaults] setObject:self.state forKey:@"isOn"];
        } else {
//            NSLog(@"取值");
            [cell.mySwitch setOn:[self.state boolValue]];
        }

        [cell.mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    if (indexPath.section == 1) {
        cell.logonLabel.hidden = NO;
        
        User *user = [userDefaults getUserInfo];
        if (user.loginState) {
            cell.logonLabel.text = @"注销登录";
        } else {
            cell.logonLabel.text = @"登录";
        }
        
        cell.myImageView.hidden = YES;
        cell.titleLabel.hidden = YES;
        cell.detailLabel.hidden = YES;
    } else {
        cell.logonLabel.hidden = YES;
        cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
        cell.detailLabel.text = self.detailArr[indexPath.row];
    }
    cell.titleLabel.text = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                __weak typeof(self) weakSelf = self;
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"清除缓存" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf removeCaches];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }];
                [alertC addAction:cancel];
                [alertC addAction:sure];
                [weakSelf presentViewController:alertC animated:YES completion:nil];
                
            }
                break;
            case 4:
            {
                
            }
                break;
            case 5:
            {
                
            }
                break;
            case 6:
            {
                
            }
                break;
            default:
                break;
        }
    } else {
        
        
        SetupTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ( [cell.logonLabel.text isEqualToString:@"登录"]) {
            LoginViewController *loginVC = [LoginViewController new];
            [self presentViewController:loginVC animated:YES completion:nil];
        } else {
            
            User *user = [userDefaults getUserInfo];
            if (user.loginState) {
                if ([[FriendsManager shareFriendsManager] loginOut]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"退出成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [userDefaults removeUserInfo];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"messageDtaMuArr"];
                        [tableView reloadData];
                        NSLog(@"\n%@",NSHomeDirectory());
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                } else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"退出失败" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你还没有登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
}



// 内存
-(float)getFilePath{
    
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //缓存路径
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
    NSString *cacheDir = [cachePaths objectAtIndex:0];
    
    NSArray *cacheFileList;
    
    NSEnumerator *cacheEnumerator;
    
    NSString *cacheFilePath;
    
    unsigned long long cacheFolderSize = 0;
    
    cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
    
    cacheEnumerator = [cacheFileList objectEnumerator];
    
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        
    NSDictionary *cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
        
        cacheFolderSize += [cacheFileAttributes fileSize];
    }
    //单位MB
    return cacheFolderSize/1024/1024;
}
- (void)removeCaches{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    //缓存路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    if ([fileManager fileExistsAtPath:path]) {
            [fileManager removeItemAtPath:path error:nil];
    }


}
- (void)switchAction:(BOOL)isOn{
    
    if ([self.state isEqualToString:@"YES"]) {
        self.state = @"NO";
    } else {
        self.state = @"YES";
    }
     [[NSUserDefaults standardUserDefaults] setObject:self.state forKey:@"isOn"];
//    NSLog(@"开关改变,存值");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"night" object:nil userInfo:nil];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
