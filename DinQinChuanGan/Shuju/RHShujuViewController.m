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

@interface RHShujuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RHShujuViewController

#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - layoutViews
- (void)layoutViews {
    self.navigationItem.title=@"测试数据";
//    左BBI
    UIBarButtonItem *leftBBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qrcode"] style:UIBarButtonItemStylePlain target:self action:nil];
    leftBBI.tintColor=CONTROL_COLOR;
    self.navigationItem.leftBarButtonItem=leftBBI;
//    右BBI
    UIBarButtonItem *rightBBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"house"] style:UIBarButtonItemStylePlain target:self action:nil];
    rightBBI.tintColor=CONTROL_COLOR;
    self.navigationItem.rightBarButtonItem=rightBBI;
    [self.view addSubview:self.tableView];
}

#pragma mark - delegate, datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    不同roll使用不同类型的cell
    RHIHAITableViewCell *ihaiCell=[[RHIHAITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    RHAirIndexTableViewCell *indexCell=[[RHAirIndexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    RHAirParameterTableViewCell *paraCell=[[RHAirParameterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    RHPollutionTableViewCell *pollutCell=[[RHPollutionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *cellArr=@[ihaiCell, indexCell, paraCell, pollutCell];
// ------------------------------------------------------------------------------
    
    
    
    return cellArr[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
}

#pragma mark - lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=BACKGROUND_COLOR;
        if ([WRNavigationBar isIphoneX]) {
            _tableView.contentInset=UIEdgeInsetsMake(0, 0, 83, 0);
        }else {
            _tableView.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);
        }
    }
    return _tableView;
}




@end
