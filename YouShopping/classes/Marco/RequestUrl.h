//
//  RequestUrl.h
//  YouShopping
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h

//轮播图url;
#define ShufflingFigure_url @"http://api.liwushuo.com/v2/banners?channel=iOS"

//轮播图详情页面
#define FirstHeaderDatil(ID)[NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?limit=20&offset=0",ID]

//精选
#define selection_url @"http://api.liwushuo.com/v2/channels/100/items_v2?ad=2&gender=1&generation=1&limit=20&offset=0"

//海淘
#define second_url @"http://api.liwushuo.com/v2/channels/129/items_v2?gender=1&generation=1&limit=20&offset=0"

//创意生活
#define Third_url @"http://api.liwushuo.com/v2/channels/125/items_v2?gender=1&generation=1&limit=20&offset=0"
//送女票
#define Fourth_url @"http://api.liwushuo.com/v2/channels/10/items_v2?limit=20&offset=0"
//科技范
#define Fifth_url @"http://api.liwushuo.com/v2/channels/28/items_v2?gender=1&generation=1&limit=20&offset=0"

//送爸妈
#define Sixth_url @"http://api.liwushuo.com/v2/channels/6/items_v2?limit=20&offset=0"

//设计感
#define Seventh_url @"http://api.liwushuo.com/v2/channels/127/items_v2?limit=20&offset=0"

//文艺风
#define Eighth_url @"http://api.liwushuo.com/v2/channels/14/items_v2?limit=20&offset=0"
//奇葩搞怪
#define Nineth_url @"http://api.liwushuo.com/v2/channels/126/items_v2?limit=20&offset=0"
//萌萌哒
#define Tenth_url @"http://api.liwushuo.com/v2/channels/11/items_v2?limit=20&offset=0"

//礼物
#define Eleventh_url @"http://api.liwushuo.com/v2/channels/111/items_v2?limit=20&offset=0"

//美食
#define Twelfth_url @"http://api.liwushuo.com/v2/channels/118/items_v2?limit=20&offset=0"
//送自己
#define Thirteenth_url @"http://api.liwushuo.com/v2/channels/134/items_v2?limit=20&offset=0"
//饰品
#define Fourteenth_url @"http://api.liwushuo.com/v2/channels/116/items_v2?limit=20&offset=0"
//穿搭
#define Fifteenth_url @"http://api.liwushuo.com/v2/channels/110/items_v2?limit=20&offset=0"
//家居
#define Sixteenth_url @"http://api.liwushuo.com/v2/channels/112/items_v2?limit=20&offset=0"

//cell上方小标题的接口

#define CellOntitleRequest(ID) [NSString stringWithFormat:@"http://api.liwushuo.com/v2/columns/%@?limit=20&offset=0",ID]

//点击cell进去的页面的接口
#define EnterCellRequest(ID) [NSString stringWithFormat:@"http://api.liwushuo.com/v2/posts_v2/%@?show_baichuan=0",ID]

//cell上方小标题里的cell进去的接口
#define TitleOnCellRequest(ID) [NSString stringWithFormat:@"http://api.liwushuo.com/v2/posts_v2/%@",ID]

//评论接口
#define commentRequest(ID) [NSString stringWithFormat:@"http://api.liwushuo.com/v2/posts/%@/comments?limit=20&offset=0",ID]


//***************************************************************
//YK热门页面请求
#define hotRequest_URL @"http://api.liwushuo.com/v2/items?gender=1&generation=1&limit=50&offset=0"


// 加载更多热门请求,没实现
#define hotRequestLoadMore_URL @"http://api.liwushuo.com/v2/items?generation=1&gender=1&limit=50&offset=50"


//搜索button 获取到按钮 添加的cell上!
#define searchHotRequest_URL @"http://api.liwushuo.com/v2/search/hot_words"


//热门跳转webView后,进入详情,点击评论
#define fristWebViewCommentRequest_URL(ID)[NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@/comments?limit=20&offset=0",ID] 


//礼物快速选择排序界面
#define FastSelectPresentSortRequest_URL @"http://api.liwushuo.com/v2/search/item_by_type?limit=20&offset=0"





#endif /* RequestUrl_h */






