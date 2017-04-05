//
//  PersonInformationViewController.m
//  YouShopping
//
//  Created by Akira_Hideto on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "PersonInformationViewController.h"
#import "PersonInformationTableViewCell.h"
#import "NameViewController.h"
#import "STPickerDate.h"
#import "UIViewController+BackButtonHandler.h"

@interface PersonInformationViewController ()<
UITableViewDelegate,
UITableViewDataSource,
STPickerDateDelegate,  // 时间选择代理
UIImagePickerControllerDelegate,   // 打开相册
UINavigationControllerDelegate     // 打开相册代理
>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *titleArr;
@property(nonatomic, strong)NSMutableArray *detailArr;
//
@property(nonatomic, strong)UIImagePickerController *picker;
//
@property(nonatomic, strong)UIImage *avatorImage;
//
@property(nonatomic, strong)NSMutableString *detailPath;
//
@property(nonatomic, strong)NSMutableString *avatorPath;
//
@property(nonatomic, strong)NSMutableData *encodeData;
//
@property(nonatomic, strong)NSMutableData *decodeData;
//

@end

@implementation PersonInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.navigationController.navigationBar.hidden = NO;
    self.titleArr = @[@"头像", @"名字", @"账号", @"性别", @"生日", @"手机号", @"邮箱"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[ud objectForKey:@"detailArr"] mutableCopy];
    
    if (array.count == 0) {
        self.detailArr = [@[@"avatorImage", @"我的小可爱在吗", @"Akira-Hideto",@"未选择", @"未选择", @"未绑定", @"未绑定"] mutableCopy];
    } else {
        self.detailArr = array;
    }
    
    NSData *data = [ud objectForKey:@"avator"];
    if (data == nil) {
        
        self.avatorImage = [UIImage imageNamed:self.detailArr[0]];
    } else {
        self.avatorImage = [UIImage imageWithData:data];
    }
    
    [self setViews];
}
- (void)setViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonInformationTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PersonInformationTableViewCell"];
    [self.view addSubview:self.tableView];
    
    self.picker = [UIImagePickerController new];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInformationTableViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = self.titleArr[indexPath.row];
    
    if (indexPath.row == 0) {
            cell.myImageView.image = self.avatorImage;
    } else if (indexPath.row == 1) {
            cell.detailLabel.text = self.detailArr[indexPath.row];
    } else {
        cell.detailLabel.text = self.detailArr[indexPath.row];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
    // 头像
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *caremaAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [weakSelf presentViewController:self.picker animated:YES completion:nil];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

            weakSelf.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:weakSelf.picker animated:YES completion:nil];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        
        [alertC addAction:caremaAction];
        [alertC addAction:photoAction];
        [alertC addAction:cancelAction];
        
        [self presentViewController:alertC animated:YES completion:nil];
    } else if (indexPath.row == 1) {
    // 昵称
        NameViewController *nameVC = [[NameViewController alloc]init];
        
        [self.navigationController pushViewController:nameVC animated:YES];
        __weak PersonInformationViewController *personVC = self;
        
        nameVC.block = ^(NSString *string)
        {
            personVC.detailArr[indexPath.row] = string;
            [personVC.tableView reloadData];
        };

    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
    // 性别
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.detailArr[indexPath.row] = @"男";
            [weakSelf.tableView reloadData];
        }];
        
        UIAlertAction *womanAction = [UIAlertAction actionWithTitle:@"女" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.detailArr[indexPath.row] = @"女";
            [weakSelf.tableView reloadData];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [alertC addAction:manAction];
        [alertC addAction:womanAction];
        [alertC addAction:cancelAction];

        
        [self presentViewController:alertC animated:YES completion:nil];
    } else if (indexPath.row == 4) {
    // 生日
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];
        
    } else if (indexPath.row == 5) {
    // 手机号
        if ([self.detailArr[indexPath.row] isEqualToString:@"未绑定"]) {
        // 绑定手机号
            
        } else {
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
            UIAlertAction *unbundlingAction = [UIAlertAction actionWithTitle:@"解绑" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                UIAlertController *alertCo = [UIAlertController alertControllerWithTitle:@"提示" message:@"您真的要解绑此手机号码吗?" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    // 解绑
                    
                    
                }];
                UIAlertAction *cancelAcion = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
                [alertCo addAction:sureAction];
                [alertCo addAction:cancelAcion];
                [weakSelf presentViewController:alertCo animated:YES completion:nil];
            }];
            
            UIAlertAction *changeAction = [UIAlertAction actionWithTitle:@"更换手机号" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                // 更换手机号
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            
            [alertC addAction:unbundlingAction];
            [alertC addAction:changeAction];
            [alertC addAction:cancelAction];
            
            [self presentViewController:alertC animated:YES completion:nil];

        }
        
    } else {
    // 邮箱
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *unbundlingAction = [UIAlertAction actionWithTitle:@"解绑" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *changeAction = [UIAlertAction actionWithTitle:@"更换邮箱" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        
        [alertC addAction:unbundlingAction];
        [alertC addAction:changeAction];
        [alertC addAction:cancelAction];
        [self presentViewController:alertC animated:YES completion:nil];

    }
}
#pragma mark ----------- 生日日期选择
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)year, (long)month, (long)day];
    self.detailArr[4] = text;
    [self.tableView reloadData];
}

#pragma mark ----------- 打开系统相册选择好图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.avatorImage = image;    //如果拍的照片 拍完后保存到相册
    if (_picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        //获取修改过的图片
        UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        self.avatorImage = editImage;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = UIImageJPEGRepresentation(self.avatorImage, 1);
    [ud setObject:data forKey:@"avator"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"avator" object:nil];
    [self.tableView reloadData];
}
// 保存到相册
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    
    if (error) {
        NSLog(@"error -- %@", error);
    } else {
        NSLog(@"已保存");
    }
}


// 借用一个开源的extension，点击系统的back按钮触发的方法
- (BOOL)navigationShouldPopOnBackButton {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.detailArr forKey:@"detailArr"];
    NSData *data = UIImageJPEGRepresentation(self.avatorImage, 1);
    [ud setObject:data forKey:@"avator"];
    self.block(self.detailArr[1]);
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
