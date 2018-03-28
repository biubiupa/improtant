//
//  RHMoveOneStepViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/22.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMoveOneStepViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "RHMoveTwoStepViewController.h"

@interface RHMoveOneStepViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, assign) NSInteger placeId;
@property (nonatomic, copy) NSString *placeName;

@end

@implementation RHMoveOneStepViewController

static NSString *identifier=@"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutviews];
}

- (void)layoutviews {
    self.navigationItem.title=@"移动到";
    [self.view addSubview:self.tableView];
    UIBarButtonItem *rightBBI=[[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(areaRequest)];
    rightBBI.enabled=NO;
    rightBBI.tintColor=LightGrayColor;
    self.navigationItem.rightBarButtonItem=rightBBI;
}

#pragma mark - delegate, datasourece
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 13;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 99;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.placeList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",self.placeList[indexPath.section][@"placeName"]];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor=CONTROL_COLOR;
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    self.navigationItem.rightBarButtonItem.tintColor=CONTROL_COLOR;
    self.navigationItem.rightBarButtonItem.enabled=YES;
    self.placeId=[self.placeList[indexPath.section][@"placeId"] integerValue];
    self.placeName=cell.textLabel.text;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.accessoryType=UITableViewCellAccessoryNone;
}

#pragma mark - 请求区域列表
- (void)areaRequest {
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
    backBBI.tintColor=CONTROL_COLOR;
    self.navigationItem.backBarButtonItem=backBBI;
    RHMoveTwoStepViewController *moveTwoVC=[RHMoveTwoStepViewController new];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            moveTwoVC.areaList=responseObject[@"body"][@"list"];
            moveTwoVC.placeName=self.placeName;
            [self.navigationController pushViewController:moveTwoVC animated:YES];
            [moveTwoVC.tableView reloadData];
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
        _tableView.sectionHeaderHeight=13;
        UIView *view=[UIView new];
        view.backgroundColor=BACKGROUND_COLOR;
        _tableView.tableFooterView=view;
        _tableView.backgroundColor=BACKGROUND_COLOR;
    }
    return _tableView;
}

- (NSString *)parameter {
    
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30005,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"placeId": @(self.placeId),
                            @"page": @1,
                            @"pageSize": @10
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return _parameter;
}




@end
