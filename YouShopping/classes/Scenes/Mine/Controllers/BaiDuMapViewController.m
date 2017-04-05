//
//  BaiDuMapViewController.m
//  YouShopping
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "BaiDuMapViewController.h"

//显示百度地图
#import <BaiduMapAPI_Map/BMKMapComponent.h>

//地图编码百度(根据位置信息检索)
#import <BaiduMapAPI_Search/BMKSearchComponent.h>




@interface BaiDuMapViewController ()
<
BMKMapViewDelegate,
BMKGeoCodeSearchDelegate
>

@property (nonatomic,strong) BMKMapView *mapView;

//检索
@property (nonatomic,strong) BMKGeoCodeSearch *searcher;


@end



@implementation BaiDuMapViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地图";
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view = _mapView;
    
#warning --------------定位具体地点------
    //    缩放比例
    _mapView.zoomLevel = 15;
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    //    地图接收城市名字
//    geoCodeSearchOption.city= _cityStr;
    //    地图接收具体地址
    geoCodeSearchOption.address = _cityStr;
    
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    
    if(flag)
    {
//        NSLog(@"geo检索发送成功");
    }
    else
    {
//        NSLog(@"geo检索发送失败");
    }
    
}





//实现Deleage处理回调结果       代理方法 ----------------BMKGeoCodeSearchDelegate
//接收正向编码结果
//参数1: 搜索对象
//参数2: 搜索结BMKGeoCodeSearch果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
//    NSLog(@"--------------%@",result);
    
    //    创建大头针
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
    //    大头针赋值 经纬度
    pointAnnotation.coordinate = result.location;
    pointAnnotation.title = result.address;
    [_mapView addAnnotation:pointAnnotation];
    
    //    地图中心以大头针为中心
    _mapView.centerCoordinate = result.location;
}




/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
//刷新大头针     代理方法-------------------BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //    当做大头针视图的标识符
    NSString *annotationViewID = @"annotationID";
    
    //    根据标识符,查找复用的大头针
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
    
    //    如果没有可复用的大头针,就创建一个新的大头针,并加上标识符
    //    BMKPinAnnotationView 是BMKAnnotationVie子类,添加了颜色以及一个动画效果
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID];
    //    大头针颜色
        ((BMKPinAnnotationView *)annotationView).pinColor = BMKPinAnnotationColorRed;
        
    //    动画效果添加大头针
        ((BMKPinAnnotationView *)annotationView).animatesDrop = YES;
    }
    annotationView.annotation = annotation;
    //    设置点击 大头针提示框 是否弹出
    annotationView.canShowCallout = YES;
    return annotationView;
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
