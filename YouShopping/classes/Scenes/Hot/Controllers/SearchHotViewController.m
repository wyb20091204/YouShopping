//
//  SearchHotViewController.m
//  YouShoping
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "SearchHotViewController.h"
#import "SearchHotCollectionViewCell.h"
#import "HotRequest.h"
#import "RequestUrl.h"
#import "SearchHotModel.h"
#import "SearchIntoViewController.h"
#import "SelectPresentSortViewController.h"

@interface SearchHotViewController ()
<
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UISearchBarDelegate//搜索栏代理
>

//搜索栏
@property (nonatomic,strong) UISearchBar *searchBar;

//
@property (nonatomic,strong) UICollectionView *collectionView;

//存放搜索内容 按钮cell 的数组(手链,杯子,家居)等等`````
@property (nonatomic,strong) NSMutableArray *searchBtnArr;



@end

@implementation SearchHotViewController

//懒加载!!
- (NSMutableArray *)searchBtnArr
{

    if (_searchBtnArr == nil) {
        
        _searchBtnArr = [NSMutableArray array];
    }
    return _searchBtnArr;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    //    设置布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    设置Item 大小
    flowLayout.itemSize = CGSizeMake(kScreenWidth/5, 30);
    //    设置最小行间距
    flowLayout.minimumLineSpacing = 15;
    //    设置最小列间距
    flowLayout.minimumInteritemSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 220) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //    注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchHotCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:SearchHotCollectionViewCell_ID];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];

//   搜索头标题
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, -60, self.collectionView.frame.size.width, 50)];
    label.text = @"大家都在搜";
    label.textColor = [UIColor grayColor];
    [self.collectionView addSubview:label];
    
//    创建搜索栏
    [self createSearchBar];
    
//    解析热搜按钮
    [self parseSearchButton];
    
#warning ------------------- 自定义打印字体:
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames )
//    {
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames )
//        {
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }
    
    
    //    返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
//    挑选礼物按钮
    UIButton *selectPresentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    selectPresentBtn.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)+10, self.view.frame.size.width, 40);
    selectPresentBtn.backgroundColor = [UIColor whiteColor];
    [selectPresentBtn setTitle:@"❤️ 使用选礼神器快速选择礼物    >" forState:(UIControlStateNormal)];
    [selectPresentBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [selectPresentBtn addTarget:self action:@selector(selectPresentClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:selectPresentBtn];
}


//快速挑选礼物按
- (void)selectPresentClicked:(UIButton *)btn
{
    SelectPresentSortViewController *selectPresentVC = [SelectPresentSortViewController new];
//    隐藏tabBar
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:selectPresentVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}







//返回按钮
- (void)returnAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}





//创建搜索栏
- (void)createSearchBar
{
    //    搜索栏初始化
    self.searchBar = [[UISearchBar alloc] init];
    //    默认样式
    self.searchBar.barStyle = UIBarStyleDefault;
    
    self.searchBar.backgroundColor = [UIColor clearColor];
    //    代理 跳转页面
    self.searchBar.delegate = self;
    
    _searchBar.layer.cornerRadius = 10;
    _searchBar.layer.masksToBounds = YES;
    self.searchBar.placeholder = @"快选一份礼物，送给亲爱的Ta吧";
    //    添加到导航栏
    self.navigationItem.titleView = self.searchBar;
}



//键盘搜索按钮点击的回调
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchIntoViewController *searchIntoVC = [SearchIntoViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchIntoVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
//    传值  把搜索的内容传递过去
    searchIntoVC.searchStr = self.searchBar.text;
    
//    回收键盘
    [self.searchBar resignFirstResponder];
}





//    解析热搜按钮
- (void)parseSearchButton
{
    __weak typeof(self)weakSelf = self;
    [[HotRequest shareHotRequest] requestAllHotWithUrl:searchHotRequest_URL success:^(NSDictionary *dic) {
        weakSelf.searchBtnArr = [SearchHotModel parseSearchBtnWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}






//    每个区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    SearchHotModel *model = [SearchHotModel new];
    NSDictionary *dic = [self.searchBtnArr firstObject];
//    用model的数组 接收搜索按钮
    model.hot_words = dic[@"hot_words"];
    
    return model.hot_words.count-1;
}



//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SearchHotCollectionViewCell_ID forIndexPath:indexPath];
    
    SearchHotModel *model = [SearchHotModel new];
    NSDictionary *dic = [self.searchBtnArr firstObject];
//    用model的数组 接收搜索按钮
    model.hot_words = dic[@"hot_words"];
//    给cell赋值
    cell.searchLabel.text = model.hot_words[indexPath.row];
//    修改字体 自定义字体:
    cell.searchLabel.font = [UIFont fontWithName:@"SourceHanSansCN-Medium" size:17];
    
    return cell;
}





//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchIntoViewController *searchIntoVC = [SearchIntoViewController new];
    
    SearchHotModel *model = [SearchHotModel new];
    NSDictionary *dic = [self.searchBtnArr firstObject];
//    用model的数组 接收搜索按钮
    model.hot_words = dic[@"hot_words"];
//    点击cell 把要搜索的内容 添加到搜索栏
    self.searchBar.text = model.hot_words[indexPath.row];
    
//    点击 大家都在搜, 每个按钮跳转网页
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchIntoVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    searchIntoVC.searchStr = model.hot_words[indexPath.row];
    
}


//设置 上下做左右 的空间
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 5, 10);//分别为上、左、下、右
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
