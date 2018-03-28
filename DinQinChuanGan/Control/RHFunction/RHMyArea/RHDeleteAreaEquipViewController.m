//
//  RHMoveAreaEquipViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/23.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHDeleteAreaEquipViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "RHDeleteEquipTableViewCell.h"
#import "Masonry.h"

@interface RHDeleteAreaEquipViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *delePara;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, strong) RHDeleteEquipTableViewCell *deleteCell;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *deletBtn;

@end

@implementation RHDeleteAreaEquipViewController

static NSString *identifier=@"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutviews];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self areaEquipRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UserDefaults removeObjectForKey:@"item"];
}

- (void)layoutviews {
    self.navigationItem.title=self.itemTitle;
    self.view.backgroundColor=BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
    [self.footerView addSubview:self.deletBtn];
    [self.deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 45));
        make.center.equalTo(self.footerView);
//        make.bottom.equalTo(self.footerView).with.offset(-70);
    }];
    self.tableView.tableFooterView=self.footerView;
    
}

#pragma mark - delegate, datasource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.deleteCell.frame.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RHDeleteEquipTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell=[[RHDeleteEquipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    self.deleteCell=cell;
    return cell;
}

#pragma mark - 事件处理
//请求该区域下所有设备
- (void)areaEquipRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.listArr=responseObject[@"body"][@"list"];
            [UserDefaults setObject:self.listArr forKey:@"item"];
            [UserDefaults synchronize];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
}

//删除该区域下所有设备
- (void)deleteAreaEquipment {
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"删除该区域全部设备?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        确认后执行删除操作
        [self deleteEquipmentesRequest];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//删除请求
- (void)deleteEquipmentesRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.delePara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            NSLog(@"%@",MSG);
            NSString *str=@"0";
            self.backBlock(str);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
    }];
}


#pragma mark - lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor=BACKGROUND_COLOR;

        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView=[UIView new];
        _footerView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 200);
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
        [_deletBtn addTarget:self action:@selector(deleteAreaEquipment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deletBtn;
}

//请求该区域下所有设备参数
- (NSString *)parameter {
    if (!_parameter) {
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30016,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"areaId": @(self.areaId)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

//删除区域设备参数
- (NSString *)delePara {
    if (!_delePara) {
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
        NSDictionary *con=@{@"ascriptionId": @(self.areaId),@"ascriptionType":@(2)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _delePara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _delePara;
}

@end
