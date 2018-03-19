//
//  RHMyEquipmentViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/11.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMyEquipmentViewController.h"
#import "Masonry.h"
#import "Header.h"
#import "AFNetworking.h"
#import "WRNavigationBar.h"
#import "RHEquipMessageViewController.h"
#import "RHEquipStandardViewController.h"
#import "RHEquipMentTableViewCell.h"

#define NavBarHeight [self navBarHeight]
#define TransFormBound  [self transformBound]

@interface RHMyEquipmentViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSArray *areaList;
@property (nonatomic, copy) NSArray *deviceList;

@end

@implementation RHMyEquipmentViewController

static NSString *identifier=@"cell";
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutViews];
    [self defaultRequest];
}

- (void)layoutViews {
    self.view.backgroundColor=[UIColor redColor];
    self.navigationItem.title=@"我的设备";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.scrollView];
    UIBarButtonItem *rightBBI=[[UIBarButtonItem alloc] initWithTitle:@"添加设备" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=rightBBI;
//    批量添加按钮
    for (int i = 0; i < self.listArr.count; ++i) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=i+100;
        button.frame=CGRectMake((100*i +10), 10, 90, 40);
        button.layer.cornerRadius=3;
        button.layer.borderWidth=1;
        button.layer.borderColor=[[UIColor grayColor] CGColor];
        NSString *title=self.listArr[i][@"placeName"];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button setTitle:title forState:UIControlStateNormal];
        if (button.tag==100) {
            button.backgroundColor=CONTROL_COLOR;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else {
            button.backgroundColor=[UIColor whiteColor];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(btnChangeState:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    
    }
}



#pragma mark - dataSource,delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.deviceList=self.areaList[indexPath.section][@"deviceList"];
    if (self.deviceList.count > 3) {
        return 238;
    }else {
        return 151;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.areaList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RHEquipMentTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell=[[RHEquipMentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.nameLabel.text=self.areaList[indexPath.section][@"areaName"];
    cell.deviceList=self.areaList[indexPath.section][@"deviceList"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSLog(@"%@",cell.deviceList);
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark - misk
- (CGFloat)navBarHeight {
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    }else {
        return 64;
    }
}

#pragma mark - 事件处理
//切换按钮时，背景色以及字体颜色的改变（按钮多时）
- (void)btnChangeState:(UIButton *)sender {
//    防止tag值为0的UIImageView乱入,造成crash
    if (sender.tag>0) {
        self.index=sender.tag-100;
    }
    for (UIButton *button in self.scrollView.subviews) {
        if (button.tag == sender.tag) {
            button.backgroundColor=CONTROL_COLOR;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (button.tag != 0) {
            button.backgroundColor=[UIColor whiteColor];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
//    请求设备
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:[self equipPara:self.index] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.areaList=responseObject[@"body"][@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error---:%@",error);
    }];
}

//默认请求
- (void)defaultRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:[self equipPara:0] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.areaList=responseObject[@"body"][@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:---%@",error);
    }];
}

//设备详细信息
- (void)rightAction {
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:[RHEquipMessageViewController new] animated:YES];
//    [self.navigationController pushViewController:[RHEquipStandardViewController new] animated:YES];

}



#pragma mark - lazyload
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, 60)];
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.delegate=self;
        _scrollView.contentSize=CGSizeMake((100 * self.listArr.count +10), 60);
        _scrollView.showsHorizontalScrollIndicator=NO;
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor=BACKGROUND_COLOR;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.sectionHeaderHeight=10;
        _tableView.sectionFooterHeight=0;
        _tableView.tableFooterView=[UIView new];
        _tableView.contentInset=UIEdgeInsetsMake(60, 0, 0, 0);
//        _tableView.rowHeight=238;
    }
    return _tableView;
}



- (NSString *)equipPara:(NSInteger)index {
        int placeId=[self.listArr[index][@"placeId"] intValue];
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30011,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"placeId": @(placeId),
                            @"page": @1,
                            @"pageSize": @10
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *equipPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return equipPara;
}



@end
