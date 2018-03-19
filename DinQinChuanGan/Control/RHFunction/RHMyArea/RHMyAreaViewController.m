//
//  RHMyAreaViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/11.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMyAreaViewController.h"
#import "Header.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "RHAddAreaViewController.h"
#import "RHAreaContentViewController.h"

@interface RHMyAreaViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic,strong) UIView * markView;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, strong) UIButton *dropBtn;
@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, assign) NSInteger placeId;
@property (nonatomic, copy) NSMutableArray *areaList;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, assign) NSInteger areaId;



@end

@implementation RHMyAreaViewController

static NSString *identifier=@"identifier";
static NSString *ident=@"ident";



//初始化视图


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    self.list=[ud objectForKey:@"at"];
    [self listRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    if (self.listView.frame.size.height > 0) {
        [self pickUpAnimation];
        self.status=!self.status;
    }
}
#pragma mark - 界面布局
//处理布局
- (void)layoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
//    点击第一次的初始状态
    self.status=YES;
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSArray *arr=[NSArray array];
    arr=[ud objectForKey:@"at"];
    NSString *title=[NSString stringWithFormat:@"%@",arr[0][@"placeName"]];
    UIButton *dropBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [dropBtn setTitle:title forState:UIControlStateNormal];
    [dropBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dropBtn addTarget:self action:@selector(clickDropOrPick) forControlEvents:UIControlEventTouchUpInside];
    self.dropBtn=dropBtn;
//    UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 50, 50)];
//    imgview.image=[UIImage imageNamed:@"online"];
//    [self.dropBtn addSubview:imgview];
    
    self.navigationItem.titleView=self.dropBtn;
//    添加区域
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithTitle:@"添加区域" style:UIBarButtonItemStylePlain target:self action:@selector(addAreaAction)];
    UIBarButtonItem *backBI=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backBI;
    self.navigationItem.rightBarButtonItem=rightBI;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.markView];
    [self.view addSubview:self.listView];

}


#pragma mark - 实现tableview的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.listView) {
        return 1;
    }else {
        return self.arr.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.listView) {
        return self.list.count;
    }else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.listView) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ident];
        cell.textLabel.text=self.list[indexPath.row][@"placeName"];
        cell.backgroundColor=BACKGROUND_COLOR;
        
        return cell;
    } else {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        cell.textLabel.text=self.arr[indexPath.section][@"areaName"];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        self.cell=cell;
        return self.cell;
    }
    
}

#pragma mark - 点击事件
//添加区域事件
- (void)addAreaAction {
    RHAddAreaViewController *areaVC=[RHAddAreaViewController new];
    areaVC.placeId=self.placeId;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:areaVC animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //下拉列表点击事件
    if (tableView == self.listView) {
        [self.dropBtn setTitle:self.list[indexPath.row][@"placeName"] forState:UIControlStateNormal];
        [self pickUpAnimation];
        self.status=!self.status;
//        if (self.placeId) {
//            self.placeId=[self.list[indexPath.row][@"placeId"] integerValue];
//        }
        self.placeId=[self.list[indexPath.row][@"placeId"] integerValue];

        [self listRequest];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        RHAreaContentViewController *areaConVC=[RHAreaContentViewController new];
        areaConVC.titleN=self.arr[indexPath.section][@"areaName"];
        self.areaId=[self.arr[indexPath.section][@"areaId"] integerValue];
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager POST:MANAGE_API parameters:[self conParameter:self.areaId] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *body=responseObject[@"body"];
            areaConVC.areaName=[NSString stringWithFormat:@"%@",body[@"areaName"]];
            areaConVC.ratio=[NSString stringWithFormat:@"%@",body[@"area"]];
            areaConVC.equipName=[NSString stringWithFormat:@"%@",body[@"deviceNum"]];
            areaConVC.areaId=[body[@"areaId"] integerValue];
            areaConVC.placeId=self.placeId;
            NSString *str=[NSString stringWithFormat:@"%@",body[@"areaPicture"]];
            if (str) {
                 areaConVC.imgUrl=[NSURL URLWithString:str];
            }
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:areaConVC animated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"=====error:%@",error);
        }];
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.listView) {
        return self.dropBtn.frame.size.height;
    } else {
        return 99;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 13;
    } else {
        return 0;
    }
}

//添加下拉，收起动画
- (void)dropDownAnimation {
    CGRect frame=self.listView.frame;
    frame.size.height=self.dropBtn.frame.size.height * self.list.count;
    [UIView animateWithDuration:0.3 animations:^{
        self.listView.frame=frame;
        self.markView.alpha=0.5;
        self.markView.backgroundColor=[UIColor lightGrayColor];
        self.cell.userInteractionEnabled=NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)pickUpAnimation {
    CGRect frame=self.listView.frame;
    frame.size.height=0;
    [UIView animateWithDuration:0.3 animations:^{
        self.listView.frame=frame;
        self.markView.alpha=0;
        self.markView.userInteractionEnabled=YES;
        self.cell.userInteractionEnabled=YES;
    } completion:^(BOOL finished) {
        
    }];
}

//添加点击事件
- (void)clickDropOrPick {
    
    self.status ? [self dropDownAnimation] : [self pickUpAnimation];
    self.status=!self.status;
   
    
    [self.listView reloadData];
}

#pragma mark - 网络请求事件
//首次进入请求区域列表
- (void)listRequest {
    if (!self.placeId) {
        self.placeId=[self.list[0][@"placeId"] integerValue];
    }
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:[self parameter:self.placeId] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        if (st == 0) {
//            NSLog(@"%@",responseObject);
            self.arr=responseObject[@"body"][@"list"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--error:%@",error);
    }];
}


#pragma mark - 懒加载
//下拉列表
- (UITableView *)listView {
    if (!_listView) {
        _listView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _listView.delegate=self;
        _listView.dataSource=self;
        [_listView registerClass:[UITableViewCell class] forCellReuseIdentifier:ident];
    }
    return _listView;
}

//场所列表
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=BACKGROUND_COLOR;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}

- (UIView *)markView {
    if (!_markView) {
        _markView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _markView.alpha=0;
    }
    return _markView;
}

//区域列表请求参数
- (NSString *)parameter:(NSInteger) placeId{
        NSDictionary *head=@{
            @"aid": @"1and6uu",
            @"ver": @"1.0",
            @"ln": @"cn",
            @"mod": @"ios",
            @"de": @"2017-07-13 00:00:00",
            @"sync": @"1",
            @"uuid": @"188111",
            @"cmd": @"30005",
            @"chcode": @" ef19843298ae8f2134f "
            };
        NSDictionary *con=@{
                            @"placeId": @(placeId),
                            @"page": @1,
                            @"pageSize": @6
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return parameter;
}

//区域详情请求参数
- (NSString *)conParameter:(NSInteger)areaId {
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2011-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30006,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"areaId": @(areaId)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
        NSString *parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return parameter;
}


@end
