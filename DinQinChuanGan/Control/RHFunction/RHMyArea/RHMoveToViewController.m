//
//  RHMoveToViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/13.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMoveToViewController.h"
#import "AFNetworking.h"
#import "Header.h"

@interface RHMoveToViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, copy) NSString *delePara;
@property (nonatomic, copy) NSString *moveText;
@property (nonatomic, assign) NSInteger movePlaceId;

@end

@implementation RHMoveToViewController

static NSString *identifier=@"cell";

#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self placeListRequest];
}

- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"移动到";
    UIBarButtonItem *rightBBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneRequest)];
    [rightBBI setTintColor:LightGrayColor];
    rightBBI.enabled=NO;
    self.navigationItem.rightBarButtonItem=rightBBI;
    [self.view addSubview:self.tableView];
}

#pragma mark - delegate,datasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 13;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=self.listArr[indexPath.section][@"placeName"];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    获取相应点击的cell
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor=CONTROL_COLOR;
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    self.navigationItem.rightBarButtonItem.enabled=YES;
    self.navigationItem.rightBarButtonItem.tintColor=CONTROL_COLOR;
    self.moveText=cell.textLabel.text;
    self.movePlaceId=[self.listArr[indexPath.section][@"placeId"] integerValue];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    获取相应点击的cell

    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.accessoryType=UITableViewCellSelectionStyleNone;
}

#pragma mark - 事件处理
- (void)placeListRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (STATUS == 0) {
            self.listArr=responseObject[@"body"][@"list"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)doneRequest {
    self.block(self.moveText, self.movePlaceId);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor=BACKGROUND_COLOR;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=99;
        _tableView.sectionHeaderHeight=13;
        UIView *view=[UIView new];
        _tableView.tableFooterView=view;
    }
    return _tableView;
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
                             @"cmd": @30003,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"userId":UserId};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

- (NSString *)delePara {
    if (!_delePara) {
        
    }
    return _delePara;
}
@end
