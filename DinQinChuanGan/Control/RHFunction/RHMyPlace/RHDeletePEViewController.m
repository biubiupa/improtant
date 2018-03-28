//
//  RHDeletePEViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/27.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHDeletePEViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "RHPlaceEquipTableViewCell.h"

@interface RHDeletePEViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *equipPara;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *areaList;
@property (nonatomic, copy) NSArray *deviceList;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *deletBtn;
@property (nonatomic, copy) NSString *deletPara;

@end

@implementation RHDeletePEViewController

static NSString *identifier=@"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutviews];
    
}

- (void)layoutviews {
    self.navigationItem.title=self.stringTitle;
    self.view.backgroundColor=BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
    [self.footerView addSubview:self.deletBtn];
    [self.deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 45));
        make.center.equalTo(self.footerView);
    }];
    self.tableView.tableFooterView=self.footerView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self defaultRequest];
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.areaList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RHPlaceEquipTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell=[[RHPlaceEquipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.nameLabel.text=self.areaList[indexPath.section][@"areaName"];
    cell.deviceList=self.areaList[indexPath.section][@"deviceList"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.deviceList=self.areaList[indexPath.section][@"deviceList"];
    if (self.deviceList.count > 3) {
        return 238;
    }else {
        return 151;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark - 事件处理
//我的设备请求
- (void)defaultRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.equipPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.areaList=responseObject[@"body"][@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:---%@",error);
    }];
}

//删除场所下所有设备
- (void)deletePlaceEquipment {
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"删除该场所全部设备?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        确认后执行删除操作
        [self deleteRequest];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)deleteRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.deletPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            NSString *str=@"0";
            self.placeBlock(str);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
}

#pragma mark - lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor=BACKGROUND_COLOR;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.sectionHeaderHeight=10;
        _tableView.sectionFooterHeight=0;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _footerView.backgroundColor=BACKGROUND_COLOR;
    }
    return _footerView;
}

- (UIButton *)deletBtn {
    if (!_deletBtn) {
        _deletBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _deletBtn.backgroundColor=DELETEBTN_COLOR;
        [_deletBtn setTitle:@"全部删除" forState:UIControlStateNormal];
        [_deletBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _deletBtn.layer.cornerRadius=22;
        [_deletBtn addTarget:self action:@selector(deletePlaceEquipment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deletBtn;
}


- (NSString *)equipPara {
    if (!_equipPara) {
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
                            @"placeId": @(self.placeId),
                            @"page": @1,
                            @"pageSize": @50
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _equipPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _equipPara;
}

- (NSString *)deletPara {
    if (!_deletPara) {
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30014,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"ascriptionId": @(self.placeId),@"ascriptionType":@(1)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _deletPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _deletPara;
}




@end
