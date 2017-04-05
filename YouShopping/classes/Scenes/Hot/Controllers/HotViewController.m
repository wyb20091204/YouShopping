//
//  HotViewController.m
//  YouShop
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "HotViewController.h"
#import "HotCollectionViewCell.h"
#import "HotModel.h"
#import "HotRequest.h"
#import "RequestUrl.h"
#import "SearchHotViewController.h"
#import "WebViewHotController.h"
#import "AppDelegate.h"
#import <MJRefresh.h>


@interface HotViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate
>

//解析数据
@property (nonatomic,strong) NSMutableArray *dataArray;

//创建页面
@property (nonatomic,strong) UICollectionView *collectionView;


//网址中 拿到下一页的地址.依次循环
@property (nonatomic,strong) NSString *nextURL;

//
@property(nonatomic, strong)UIImage *avatorImage;
//

@property(nonatomic, strong)UIButton *drawerButton;
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"热门";
    
    //    创建热门主页面
    [self createCollectionView];
    
    //    添加右搜索按钮
    [self addRightSearch];
    
    //    上拉加载更多
#warning downRefreshAndPullUpLoad 上拉加载哦------------下拉刷新!!
    //    调用下拉刷新,上拉加载.解析数据
    [self downRefreshAndPullUpLoad];

    
    

    
    [self createNavigtionBarAvator];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createAvator) name:@"avator" object:nil];

}

- (void)createAvator{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"avator"];
    if (data == nil) {
        
        self.avatorImage = [UIImage imageNamed:@"avatorImage"];
    } else {
//        NSLog(@"不是吧");
        self.avatorImage = [UIImage imageWithData:data];
    }
    [self.drawerButton setBackgroundImage:self.avatorImage forState:(UIControlStateNormal)];
}

- (void)createNavigtionBarAvator{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"avator"];
    if (data == nil) {
        
        self.avatorImage = [UIImage imageNamed:@"avatorImage"];
    } else {
        self.avatorImage = [UIImage imageWithData:data];
    }
    
    // navigationBar 左侧头像按钮
    self.drawerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.drawerButton.frame = CGRectMake(0, 0, 40, 40);
    [self.drawerButton setBackgroundImage:self.avatorImage forState:(UIControlStateNormal)];
    self.drawerButton.layer.cornerRadius = self.drawerButton.frame.size.height / 2;
    self.drawerButton.layer.masksToBounds = YES;
    [self.drawerButton addTarget:self action:@selector(openOrCloseLeftDrawerClicked) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.drawerButton];
}


    //    创建热门主页面
- (void)createCollectionView
{
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
}





//添加右搜索按钮
- (void)addRightSearch
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glass.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(searchClick)];
}


//搜索点击 跳转到搜索界面
- (void)searchClick
{
    SearchHotViewController *searchVC = [SearchHotViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}





//下拉刷新 上拉加载数据,
- (void)downRefreshAndPullUpLoad
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //  调用解析数据
        [weakSelf requestHot];
    // 结束刷新
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    // 调用上拉加载更多数据
        [weakSelf requestHotMore:weakSelf.nextURL];
        
    // 结束刷新
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
#warning MJRefresh------------   先不能删除,可能有问题,现在不用这串代码 也能实现上拉刷新
    //    if (self.nextURL.length) {
    //         明杰第三方中没有if 没有下面这一句代码  只有默认先隐藏footer
    //        [self.collectionView.mj_footer beginRefreshing];
    //        // 默认先隐藏footer
    //        self.collectionView.mj_footer.hidden = YES;
    //    }
}




//    解析热门数据
- (void)requestHot
{
    __weak typeof(self)weakSelf = self;
    [[HotRequest shareHotRequest] requestAllHotWithUrl:hotRequest_URL success:^(NSDictionary *dic) {
        weakSelf.dataArray = [HotModel parseHotWithDic:dic];
#warning priceSort----------------------- 按照价格排序----- 数组排序法
//        按照价格排序----- 数组排序法
//        [weakSelf.dataArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//            obj1 = (HotModel *)obj1;
//            obj2 = (HotModel *)obj2;
//           调用model 的价格转成CGFloat类型, 然后比较,  字符串用Compara比较
//        return [[obj1 price] floatValue] > [[obj2 price] floatValue];
//        }];
//        拿到当前网址中的 新地址(上拉加载用)
        weakSelf.nextURL = dic[@"data"][@"paging"][@"next_url"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}






//更多热门数据
- (void)requestHotMore:(NSString *)nextUrl
{
    __weak typeof(self)weakSelf = self;
        //    传入一个新的地址 上个页面地址中拿到的地址 nextUrl
    [[HotRequest shareHotRequest] requestAllHotWithUrl:nextUrl success:^(NSDictionary *dic) {
        
        //        定义一个可变数据,接收解析出来的数组
        NSMutableArray *tmpArr = [NSMutableArray array];
        tmpArr = [HotModel parseHotWithDic:dic];
        //        NSLog(@"zhiqian = %ld",weakSelf.dataArray.count);
        
        //        把可变数组遍历,得到元素,是底层的一个个字典
        for (NSDictionary *nextDic in tmpArr) {
        //        然后把这些字典 添加到总的数据 数组中. 数组个数增加 cell 自动增加
            [weakSelf.dataArray addObject:nextDic];
        }
        //        再从当期页面拿到新地址  赋值到 nextURL   再次上拉刷新运行执行的就是此地址
        weakSelf.nextURL =dic[@"data"][@"paging"][@"next_url"];
        
        //        NSLog(@"zhihou = %ld",weakSelf.dataArray.count);
        
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
    return self.dataArray.count;
}




//每个item 显示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HotCollectionViewCell_Identifier forIndexPath:indexPath];
    
    HotModel *model = [HotModel new];
    
    model = self.dataArray[indexPath.row];
    
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




//点击cell 跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewHotController *webViewController = [WebViewHotController new];

#warning push hidden tabBar --------------------push时 隐藏tabBar 的写法;
//    跳转时隐藏tabBar
    self.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:webViewController animated:YES];
    
//    返回时显示TabBar
    self.hidesBottomBarWhenPushed=NO;
    
    HotModel *model = self.dataArray[indexPath.row];
    //    把解析到的ID 传值到web界面.
    webViewController.ID = model.purchase_id;
    
//    先把评论界面ID 传到webView界面 然后再传给评论界面
    webViewController.commentID = model.ID;
    //    传值分享用
    webViewController.nameString = model.name;
    webViewController.imageUrl = model.cover_image_url;
}




//分别为上、左、下、右 留出空隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 10, 5);//分别为上、左、下、右
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark ---------- Drawer ----------
    // 头像按钮 点击方法
- (void)openOrCloseLeftDrawerClicked{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // 根据isClosed (BOOL)判断 抽屉的状态, 展开<->隐藏
    if (app.leftDrawerVC.isClosed) {
        [app.leftDrawerVC openLeftView];
    } else {
        [app.leftDrawerVC closeLeftView];
    }
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC setPanEnabled:NO];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.leftDrawerVC setPanEnabled:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"avator"];
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
