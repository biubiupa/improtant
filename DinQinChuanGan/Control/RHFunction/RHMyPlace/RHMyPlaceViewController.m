//
//  RHMyPlaceViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/10.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMyPlaceViewController.h"
#import "RHAddPlaceViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "RHPlaceMessageViewController.h"
#import "PlaceModel.h"

@interface RHMyPlaceViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIBarButtonItem *rightBI;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) NSInteger st;
@property (nonatomic, assign) NSInteger placeId;
@property (nonatomic, copy) NSString *placeName;
@property (nonatomic, copy) NSArray *placeArr;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSMutableArray *list;


@end

@implementation RHMyPlaceViewController

//cell重用标识符
static NSString *identifier=@"identifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self placeRequest];
}
//  加载视图
- (void)layoutViews {
    self.navigationItem.title=@"我的场所";
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.rightBarButtonItem=self.rightBI;
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backItem;
    [self.view addSubview:self.tableView];
}

#pragma mark - delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//      cell的实例化
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    self.placeName=[NSString stringWithFormat:@"%@",self.list[indexPath.section][@"placeName"]];
    cell.textLabel.text=self.placeName;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
}
#pragma mark - 处理点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RHPlaceMessageViewController *pmVC=[RHPlaceMessageViewController new];
    self.placeId=[self.list[indexPath.section][@"placeId"] integerValue];
    NSString *str=[NSString stringWithFormat:@"%@",self.list[(_list.count-1)-indexPath.section][@"placeName"]];
    pmVC.titles=str;
//请求场所详情
    NSString *urlString=MANAGE_API;
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @"1",
                         @"uuid": @"188111",
                         @"cmd": @"30004",
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{@"placeId":@(self.placeId)};
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功%@",responseObject);
        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        if (st == 0) {
            NSDictionary *body=responseObject[@"body"];
            pmVC.placeName=[NSString stringWithFormat:@"%@",body[@"placeName"]];
            pmVC.placeArea=[body[@"placeArea"] integerValue];
            pmVC.deviceNum=[body[@"deviceNum"] integerValue];
            pmVC.placeId=[body[@"placeId"] integerValue];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:pmVC animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error---:%@",error);
    }];
//    self.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:pmVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}



#pragma mark - 初始化



- (NSString *)parameter {
    if (!_parameter) {
        NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
        self.userId=[userDef stringForKey:@"userId"];
        
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
        NSDictionary *con=@{@"userId": self.userId};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIView *view=[[UIView alloc] init];
        _tableView.tableFooterView=view;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=BACKGROUND_COLOR;
        _tableView.sectionHeaderHeight=20;
        _tableView.rowHeight=100;
    }
    return _tableView;
}

//add place（添加场所）
- (UIBarButtonItem *)rightBI {
    if (!_rightBI) {
        _rightBI=[[UIBarButtonItem alloc] initWithTitle:@"添加场所" style:UIBarButtonItemStylePlain target:self action:@selector(addPlace)];
    }
    return _rightBI;
}

//添加场所事件
- (void)addPlace {
    RHAddPlaceViewController *addPlaceVC=[RHAddPlaceViewController new];
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:addPlaceVC animated:YES];
}

// 请求场所列表
- (void)placeRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager POST:MANAGE_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *st=[NSString stringWithFormat:@"%@",responseObject[@"head"][@"st"]];
            self.st=[st integerValue];
            if (self.st==0) {
                self.list=responseObject[@"body"][@"list"];
                //            存储
                NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
                [userDefault setObject:self.list forKey:@"at"];
                [userDefault synchronize];
                [self.tableView reloadData];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"----ERROR:%@",error);
        }];
    
    
}



@end
