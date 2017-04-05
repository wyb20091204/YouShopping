//
//  SearchIntoViewController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SearchIntoViewController.h"
//与热门首页面共用一个xib  cell
#import "HotCollectionViewCell.h"
#import "HotRequest.h"
#import "SearchIntoModel.h"
#import "searchIntoWebViewController.h"

@interface SearchIntoViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong) UICollectionView *collectionView;

//存放第一步解析商品
@property (nonatomic,strong) NSMutableArray *searchIntoArr;


//用来存放第二步解析  获取ID
@property (nonatomic,strong) NSMutableArray *commodityIDArr;




@end

@implementation SearchIntoViewController

- (NSMutableArray *)commodityIDArr
{

    if (_commodityIDArr == nil) {
        
        _commodityIDArr = [NSMutableArray array];
    }
    
    return _commodityIDArr;
}




- (NSMutableArray *)searchIntoArr
{
    if (_searchIntoArr == nil) {
        
        _searchIntoArr = [NSMutableArray array];
    }
    return _searchIntoArr;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"宝贝详情";
    
    //    设置布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    设置Item 大小
    flowLayout.itemSize = CGSizeMake(kScreenWidth/2-10, 230);
    //    设置最小行间距
    flowLayout.minimumLineSpacing = 5;
    //    设置最小列间距
    flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //    注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:HotCollectionViewCell_Identifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
//    搜索关键字进入后的页面 解析的数据
    [self searchIntoRequest];
    
//    返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
}



//返回按钮
- (void)returnAction:(UIBarButtonItem *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}








//    搜索关键字进入后的页面 解析的数据
- (void)searchIntoRequest
{
    NSString *searchBarUrl = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/item?keyword=%@&limit=20&offset=0&sort=",_searchStr];
    
//    3、转码  把传过来的搜索内容(汉字)转码
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:searchBarUrl];
    NSString *url = [searchBarUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    
//    请求数据
    __weak typeof(self)weakSelf = self;
    [[HotRequest shareHotRequest] requestAllHotWithUrl:url success:^(NSDictionary *dic) {
//    调用请求数据
        weakSelf.searchIntoArr = [SearchIntoModel parseSearchIntoInterfaceWithDic:dic];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}













//每行有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.searchIntoArr.count;
}






//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HotCollectionViewCell_Identifier forIndexPath:indexPath];

//数组中是一个个 底层字典
    NSDictionary *dic = self.searchIntoArr[indexPath.row];
    
    SearchIntoModel *model = [SearchIntoModel new];
    
    [model setValuesForKeysWithDictionary:dic];

    cell.searchIntoModel = model;
    
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






//点击cell 跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchIntoWebViewController *webViewController = [searchIntoWebViewController new];
  
    NSDictionary *dic = self.searchIntoArr[indexPath.row];
    
    SearchIntoModel *model = [SearchIntoModel new];
    
    [model setValuesForKeysWithDictionary:dic];
    
#warning ---- 通过商品ID 获得URL 然后解析 再获得ID以便后面用--跳转淘宝Web
    
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@",model.ID];
//        请求数据
    [[HotRequest shareHotRequest] requestAllHotWithUrl:url success:^(NSDictionary *dic) {
//        拿到解析出来的ID
        NSString *purchase_id = dic[@"data"][@"purchase_id"];
        
//        用block 传值 传到下个界面;
        webViewController.block(purchase_id);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
//        跳转页面
    self.hidesBottomBarWhenPushed = YES;
      [self.navigationController pushViewController:webViewController animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
    
//        传值到下个界面 用于分享!
    webViewController.nameString = model.name;
    webViewController.imageUrl = model.cover_image_url;
//    评论用
    webViewController.commentID = model.ID;
    
}





//分别为上、左、下、右 留出空隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 10, 5);//分别为上、左、下、右
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
