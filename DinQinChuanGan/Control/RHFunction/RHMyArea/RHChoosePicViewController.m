//
//  RHChoosePicViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/31.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHChoosePicViewController.h"
#import "Header.h"
#import "RHDfaultImageViewController.h"

@interface RHChoosePicViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *arr;

@end

@implementation RHChoosePicViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - 控件、视图
- (void)layoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"选取墙纸";
    [self.view addSubview:self.tableView];
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backBBI;
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=self.arr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - didSelectRow
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        RHDfaultImageViewController *defaultVC=[RHDfaultImageViewController new];
        [self.navigationController pushViewController:defaultVC animated:YES];
    }
}

#pragma mark - 控件初始化
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        UIView *view=[UIView new];
        _tableView.tableFooterView=view;
    }
    return _tableView;
}

- (NSArray *)arr {
    if (!_arr) {
        _arr=@[@"默认墙纸", @"拍照", @"从相册选择"];
    }
    return _arr;
}

@end
