//
//  RHSenAndMeaViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/20.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHSenAndMeaViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "RHSenTableViewCell.h"
#import "RHMeasureTableViewCell.h"

@interface RHSenAndMeaViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *arrZero;
@property (nonatomic, copy) NSArray *arrOne;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSArray *listArr;

@end

@implementation RHSenAndMeaViewController

static NSString *sensor=@"sensorid";
static NSString *measure=@"measureid";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dataRequest];
}

#pragma mark - layoutviews
- (void)layoutViews {
    self.navigationItem.title=@"传感器与测量";
    self.view.backgroundColor=WhiteColor;
    [self.view addSubview:self.tableView];
}

#pragma mark - deledate, datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.arrZero.count : self.arrOne.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RHSenTableViewCell *senCell=[RHSenTableViewCell new];
    RHMeasureTableViewCell *measureCell=[RHMeasureTableViewCell new];
    if (indexPath.section == 0) {
        
        if (self.listArr == nil) {
            senCell.textLabel.text=self.arrZero[indexPath.row];
            NSLog(@"模拟数据");
        }else {
            senCell.textLabel.text=self.listArr[indexPath.row][@"sensorName"];

            senCell.rangeLabel.text=[NSString stringWithFormat:@"量程: %@",self.listArr[indexPath.row][@"range"]];
            senCell.precisionLabel.text=[NSString stringWithFormat:@"精度: %@",self.listArr[indexPath.row][@"accuracy"]];
            senCell.resolutionLabel.text=[NSString stringWithFormat:@"单位: %@",self.listArr[indexPath.row][@"resolvingPower"]];
        }
        senCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return senCell;
    }else {
        measureCell.textLabel.text=self.arrOne[indexPath.row];
        measureCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return measureCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 125;
    }else {
        return 41;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 41;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"其他传感器";
    }else {
        return @"";
    }
}

#pragma mark - 事件处理
- (void)dataRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.listArr=responseObject[@"body"][@"list"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
}

#pragma mark - lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.sectionHeaderHeight=41;
        _tableView.contentInset=UIEdgeInsetsMake(-41, 0, 0, 0);
    }
    return _tableView;
}



- (NSArray *)arrZero {
    
//        NSString  *str=[NSString stringWithFormat:@"%ld", self.listArr.count];
        if (self.listArr == nil) {
            _arrZero=@[@"PM2.5(颗粒物)", @"PM10(颗粒物)", @"TVOC(挥发性物质总称)", @"CO2(二氧化碳)", @"CH2O(甲醛)", @"Temp(温度)", @"RH(湿度)", @"O3", @"NOx(氮氧化物)", @"H2S(硫化氢)", @"CO(一氧化碳)", @"SO2(二氧化硫)"];
        }else {
            _arrZero=self.listArr;
        }
        
    return _arrZero;
}

- (NSArray *)arrOne {
    if (!_arrOne) {
        _arrOne=@[@"气压传感器", @"环境光传感器", @"噪音传感器", @"加速度传感器", @"陀螺仪"];
    }
    return _arrOne;
}

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
                             @"cmd": @30020,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"deviceCode":self.deviceCode};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}


@end
