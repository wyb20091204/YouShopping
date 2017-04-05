//
//  SelectPresentSortViewController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SelectPresentSortViewController.h"
#import "HotCollectionViewCell.h"
#import "HotRequest.h"
#import "SelectPresentWebView.h"

//popupView-------------引入头文件
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"




@interface SelectPresentSortViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong) UICollectionView *collectionView;

//解析数据数组
@property (nonatomic,strong) NSMutableArray *selectPresentArray;


@end


@implementation SelectPresentSortViewController


- (NSMutableArray *)selectPresentArray
{
    if (_selectPresentArray == nil) {
        _selectPresentArray = [NSMutableArray array];
    }
    return _selectPresentArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选礼神器";
    
    //    设置布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    设置Item 大小
    flowLayout.itemSize = CGSizeMake(kScreenWidth/2-10, 230);
    //    设置最小行间距
    flowLayout.minimumLineSpacing = 5;
    //    设置最小列间距
    flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //    注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:HotCollectionViewCell_Identifier];
    
    [self.view addSubview:_collectionView];
    
    //    返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
//    解析快速选择礼物数据
    [self requestSelectPresentSort];
    
//    排序按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(sortClicked:)];
}





#warning sort present ----------------- 商品的各种排序 ------!!!!!
//排序按钮
- (void)sortClicked:(UIBarButtonItem *)sender
{
    NSMutableArray *obj = [NSMutableArray array];
    for (NSInteger i = 0; i < [self titles].count; i++) {
        WBPopMenuModel * info = [WBPopMenuModel new];
//        info.image = [self images][i];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    
    __weak typeof(self)weakSelf = self;
    [[WBPopMenuSingleton shareManager]showPopMenuSelecteWithFrame:300 item:obj action:^(NSInteger index) {
//        点击的是第几个cell
//        NSLog(@"index:%ld",(long)index);
        
        switch (index) {
            case 0:{
//        重新解析数据,得到默认排序
               [self requestSelectPresentSort];
                break;
            }
                
            case 1:
            {
                [weakSelf.selectPresentArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    obj1 = (HotModel *)obj1;
                    obj2 = (HotModel *)obj2;
//        调用model 的喜欢人数 然后比较,  字符串用Compara比较
                    return [obj1 favorites_count]  < [obj2 favorites_count];
                }];
//        刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.collectionView reloadData];
                });
                break;
            }
                
            case 2:
            {
                [weakSelf.selectPresentArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    obj1 = (HotModel *)obj1;
                    obj2 = (HotModel *)obj2;
//         调用model 的价格转成CGFloat类型, 然后比较,  字符串用Compara比较
                    return [[obj1 price] floatValue] > [[obj2 price] floatValue];
                }];
//         刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.collectionView reloadData];
                });
                break;
            }
                
            case 3:{
                [weakSelf.selectPresentArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    obj1 = (HotModel *)obj1;
                    obj2 = (HotModel *)obj2;
//         调用model 的价格转成CGFloat类型, 然后比较,  字符串用Compara比较
                    return [[obj1 price] floatValue] < [[obj2 price] floatValue];
                }];
//         刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.collectionView reloadData];
                });
                break;
            }
                
            default:{
                break;
            }
        }
    }];
}



//cell 赋值
- (NSArray *) titles {
    return @[@"默认排序",
             @"按热度排序",
             @"价格由低到高",
             @"价格由高到低"];
}

// cell 的图片
//- (NSArray *) images {
//    return @[@"right_menu_QR@3x",
//             @"right_menu_addFri@3x",
//             @"right_menu_multichat@3x",
//             @"right_menu_sendFile@3x",
//             @"right_menu_facetoface@3x",
//             @"right_menu_payMoney@3x"];
//}








//返回按钮
- (void)returnAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



//    解析快速选择礼物数据
- (void)requestSelectPresentSort
{
    __weak typeof(self)weakSelf = self;
    [[HotRequest shareHotRequest] requestAllHotWithUrl:FastSelectPresentSortRequest_URL success:^(NSDictionary *dic) {
        weakSelf.selectPresentArray = [HotModel parseSelectPresentWithDic:dic];
#warning priceSort----------------------- 按照价格排序----- 数组排序法
        //        按照价格排序----- 数组排序法
        //        [weakSelf.dataArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //            obj1 = (HotModel *)obj1;
        //            obj2 = (HotModel *)obj2;
        //           调用model 的价格转成CGFloat类型, 然后比较,  字符串用Compara比较
        //        return [[obj1 price] floatValue] > [[obj2 price] floatValue];
        //        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}





//每个分区有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectPresentArray.count;
}




//每个item 显示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HotCollectionViewCell_Identifier forIndexPath:indexPath];
    
//    跟主页面 用同一个Model
    HotModel *model = [HotModel new];
    model = self.selectPresentArray[indexPath.row];
    cell.hotModel = model;
   
    
#warning cell layer.cornerRadius -------------cell 设置圆角 -------------
    cell.layer.cornerRadius = 7;
    cell.contentView.layer.cornerRadius = 7.0f;
    cell.contentView.layer.borderWidth = 0.7f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
#warning cell border --------------------  cell 设置边框 深灰色!!!----------
    cell.layer.borderColor=[UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth=0.3;
    
    return cell;
}



//分别为上、左、下、右 留出空隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 10, 5);//分别为上、左、下、右
}




//点击选择的cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    跟主页面 用同一个Model
    HotModel *model = [HotModel new];
    model = self.selectPresentArray[indexPath.row];

    SelectPresentWebView *webVC = [SelectPresentWebView new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
//    传出ID 在下面拼接网址 然后解析 获得跳转淘宝页面
    webVC.ID = model.ID;

//    把商品名  图片传递给分享
    webVC.imageUrl = model.cover_image_url;
    webVC.nameString = model.name;
    
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
