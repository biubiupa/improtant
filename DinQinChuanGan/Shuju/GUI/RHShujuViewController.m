//
//  ViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/14.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "RHShujuViewController.h"
#import "Masonry.h"
#import "Header.h"
#import "AFNetworking.h"
#import "WRNavigationBar.h"
#import "RHJudgeMethod.h"
#import "RHIHAITableViewCell.h"
#import "RHAirIndexTableViewCell.h"
#import "RHAirParameterTableViewCell.h"
#import "RHPollutionTableViewCell.h"
#import "RHMoreAreaViewController.h"

@interface RHShujuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *dropBtn;
@property (nonatomic, strong) UIImageView *dropImageView;
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, assign) BOOL dropState;
@property (nonatomic, copy) NSArray *placeArr;
@property (nonatomic, assign) NSInteger placeId;
@property (nonatomic, copy) NSDictionary *ihaiDict;
@property (nonatomic, copy) NSArray *airIndexArr;
@property (nonatomic, copy) NSDictionary *pullutDict;
@property (nonatomic, copy) NSArray *envirLists;
/*----------------------------------------------------------自定义cell */
@property (nonatomic, strong) RHAirParameterTableViewCell *airParaCell;

/*----------------------------------------------------------网络请求参数(各种) */
@property (nonatomic, copy) NSString *moreAreaPara;

@property (nonatomic, copy) NSString *placePara;
@property (nonatomic, copy) NSString *ihaiPara;
@property (nonatomic, copy) NSString *airInsexPara;
@property (nonatomic, copy) NSString *airParameter;
@property (nonatomic, copy) NSString *pullutionPara;
@property (nonatomic, copy) NSString *enviromentPara;

@end

@implementation RHShujuViewController

#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
//    [self allHttpRequests];
    [self requestPlaceList];
    [self IHAIRequest];
    [self airIndexRequest];
    [self pollutionRequest];
    [self enviromentRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.dropBtn.titleLabel.text == nil) {
        [self requestPlaceList];
    }
}


#pragma mark - layoutViews
- (void)layoutViews {
    self.dropState=YES;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"测试数据";
//    左BBI
    UIBarButtonItem *leftBBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qrcode"] style:UIBarButtonItemStylePlain target:self action:nil];
    leftBBI.tintColor=CONTROL_COLOR;
    self.navigationItem.leftBarButtonItem=leftBBI;
//    右BBI
    UIBarButtonItem *rightBBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"house"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAreaAction)];
    rightBBI.tintColor=CONTROL_COLOR;
    self.navigationItem.rightBarButtonItem=rightBBI;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.markView];
    [self.view addSubview:self.listView];
//    导航栏title自定义下拉列表按钮
    [self.dropBtn addSubview:self.dropImageView];
    [self.dropImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(13, 7));
        make.centerY.equalTo(self.dropBtn);
        make.right.equalTo(self.dropBtn).with.offset(15);
    }];
    self.navigationItem.titleView=self.dropBtn;
}

#pragma mark - delegate, datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  tableView == self.tableView ? 4 : self.placeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        //    不同roll使用不同类型的cell
        RHIHAITableViewCell *ihaiCell=[[RHIHAITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        ihaiCell.dataDict=self.ihaiDict;
        
        RHAirIndexTableViewCell *indexCell=[[RHAirIndexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        indexCell.indexArr=self.airIndexArr;
        
        RHAirParameterTableViewCell *paraCell=[[RHAirParameterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        paraCell.envirLists=self.envirLists;
        self.airParaCell=paraCell;
        
        RHPollutionTableViewCell *pollutCell=[[RHPollutionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        pollutCell.dict=self.pullutDict;
        NSArray *cellArr=@[ihaiCell, indexCell, paraCell, pollutCell];
        // ------------------------------------------------------------------------------
        return cellArr[indexPath.row];
    }else {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text=self.placeArr[indexPath.row][@"placeName"];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];

    if (tableView == self.listView) {
        if ([cell.textLabel.text isEqualToString:self.dropBtn.titleLabel.text]) {
            
        }else {
            [self.dropBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
            self.placeId=[self.placeArr[indexPath.row][@"placeId"] integerValue];
            [self IHAIRequest];
            [self airIndexRequest];
            [self pollutionRequest];
            [self enviromentRequest];
        }
    }else if ([tableView isEqual:self.airParaCell.dateTableView]) {
        NSLog(@"我是日期");
    }else if (tableView == self.airParaCell.kindTableView) {
        NSLog(@"我是二氧化碳");
    }else {
//        占位
    }
    [self pullList];
    self.dropState=!self.dropState;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        switch (indexPath.row) {
            case 0:
                return 300;
                break;
            case 1:
                return 300;
                break;
            case 2:
                return 360;
                break;
            default:
                return 200;
                break;
        }
    }else {
        return 40;
    }
    
}

#pragma mark - all of kinds actions
- (void)dropList {
    CGRect frame=self.listView.frame;
    frame.size.height=self.placeArr.count * 40;
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.listView.frame=frame;
        self.dropImageView.transform=transform;
        self.markView.backgroundColor=LightGrayColor;
        self.markView.alpha=0.5;
        self.tableView.userInteractionEnabled=NO;
    }];
}

- (void)pullList {
    CGRect frame=self.listView.frame;
    frame.size.height=0;
    CGAffineTransform transform=CGAffineTransformMakeRotation(0);

    [UIView animateWithDuration:0.2 animations:^{
        self.listView.frame=frame;
        self.dropImageView.transform=transform;
        self.markView.alpha=0;
        self.tableView.userInteractionEnabled=YES;
    }];
}

- (void)dropAndPullAction {
    self.dropState ? [self dropList] : [self pullList];
    self.dropState=!self.dropState;
}

//更多区域
- (void)moreAreaAction {
    RHMoreAreaViewController *moreVC=[RHMoreAreaViewController new];
    moreVC.textTitle=self.dropBtn.titleLabel.text;
    
    //    请求更多区域数据,先加载页面，数据请求成功后再刷新
    

    AFHTTPSessionManager *moreManager=[AFHTTPSessionManager manager];
    [moreManager POST:RECORD_API parameters:self.moreAreaPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            NSLog(@"%@",responseObject);
            moreVC.areaList=RESPONSE_BODY[@"list"];
            [moreVC.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http error-----%@",error);
        
    }];
    
    self.navigationItem.backBarButtonItem=[RHJudgeMethod creatBBIWithTitle:@"返回" Color:CONTROL_COLOR];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:moreVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark - 网络请求

//请求场所列表
- (void)requestPlaceList {
    AFHTTPSessionManager *managerPlace=[AFHTTPSessionManager manager];
    [managerPlace POST:MANAGE_API parameters:self.placePara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.placeArr=responseObject[@"body"][@"list"];
            if (self.placeArr != nil) {
                self.placeId=[self.placeArr[0][@"placeId"] integerValue];
                NSString *title=[NSString stringWithFormat:@"%@",self.placeArr[0][@"placeName"]];
                [self.dropBtn setTitle:title forState:UIControlStateNormal];
                [self.listView reloadData];
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http error%@",error);
    }];
}

//获取日常ihai
- (void)IHAIRequest {
    AFHTTPSessionManager *ihaiManager=[AFHTTPSessionManager manager];
    [ihaiManager POST:RECORD_API parameters:self.ihaiPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.ihaiDict=RESPONSE_BODY;
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http error%@",error);
    }];
}

//获取空气指数
- (void)airIndexRequest {
    AFHTTPSessionManager *indexManager=[AFHTTPSessionManager manager];
    [indexManager POST:RECORD_API parameters:self.airInsexPara progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.airIndexArr=RESPONSE_BODY[@"list"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http error%@",error);
    }];
}

//图表

//获取主要污染物
- (void)pollutionRequest {
    AFHTTPSessionManager *pullutManager=[AFHTTPSessionManager manager];
    [pullutManager POST:RECORD_API parameters:self.pullutionPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.pullutDict=RESPONSE_BODY;
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http error-----%@",error);
    }];
}

//环境参数
- (void)enviromentRequest {
    AFHTTPSessionManager *enviroManager=[AFHTTPSessionManager manager];
    [enviroManager POST:RECORD_API parameters:self.enviromentPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.envirLists=RESPONSE_BODY[@"lists"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http error-----%@",error);
    }];
}
#pragma mark - lazyload
- (UIView *)markView {
    if (!_markView) {
        _markView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _markView.alpha=0;
    }
    return _markView;
}

- (UITableView *)listView {
    if (!_listView) {
        _listView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _listView.delegate=self;
        _listView.dataSource=self;
    }
    return _listView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=BACKGROUND_COLOR;
        if ([WRNavigationBar isIphoneX]) {
            _tableView.contentInset=UIEdgeInsetsMake(0, 0, 83+88, 0);
        }else {
            _tableView.contentInset=UIEdgeInsetsMake(0, 0, 49+64, 0);
        }
    }
    return _tableView;
}

- (UIButton *)dropBtn {
    if (!_dropBtn) {
        
        _dropBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        _dropBtn.titleLabel.font=SYSTEMFONT(17);
        [_dropBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dropBtn addTarget:self action:@selector(dropAndPullAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dropBtn;
}

- (UIImageView *)dropImageView {
    if (!_dropImageView) {
        _dropImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop"]];
        _dropImageView.transform=CGAffineTransformMakeRotation(0);
    }
    return _dropImageView;
}
/*--------------------------------------------------------------网络参数（各种） */
//更多区域
- (NSString *)moreAreaPara {
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @1,
                         @"uuid": @"188111",
                         @"cmd": @20001,
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{
                        @"placeId": @(self.placeId),
                        @"page": @1,
                        @"pageSize": @100,
                        @"searchName": @"",
                        @"sorting": @1
                        };
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _moreAreaPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return _moreAreaPara;
}

//场所列表参数
- (NSString *)placePara {
        NSInteger userId=[UserId integerValue];
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @"1",
                             @"uuid": @"188111",
                             @"cmd": @"30003",
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"userId":@(userId)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _placePara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return _placePara;
}

//IHAI参数
- (NSString *)ihaiPara {
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @1,
                         @"uuid": @"188111",
                         @"cmd": @20002,
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{
                        @"ascriptionId":@(self.placeId),
                        @"ascriptionType":@1
                        };
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _ihaiPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return _ihaiPara;
}

//空气指数
- (NSString *)airInsexPara {
    NSInteger userId=[UserId integerValue];
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @1,
                         @"uuid": @"188111",
                         @"cmd": @20003,
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{
                        @"ascriptionId": @(self.placeId),
                        @"ascriptionType": @1,
                        @"userId": @(userId)
                        };
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _airInsexPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return _airInsexPara;
}

//图表

//主要污染物
- (NSString *)pullutionPara {
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @1,
                         @"uuid": @"188111",
                         @"cmd": @20006,
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{
                        @"ascriptionType":@1,
                        @"ascriptionId": @(self.placeId)
                        };
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _pullutionPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return _pullutionPara;
}

//环境参数
- (NSString *)enviromentPara {
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @1,
                         @"uuid": @"188111",
                         @"cmd": @20012,
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{
                        @"ascriptionId":@(self.placeId) ,
                        @"ascriptionType":@1
                        };
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _enviromentPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return _enviromentPara;
    
}




@end
