//
//  RHEquipStandardViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/6.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHEquipStandardViewController.h"
#import "Header.h"

@interface RHEquipStandardViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *arr;

@end

@implementation RHEquipStandardViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutViews];
}

- (void)layoutViews {
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.title=@"无限规格";
}

#pragma mark - 代理, 数据源
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 58;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"兼容性";
    } else {
        return @"支持的安全";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text=self.arr[indexPath.section];
    return cell;
}

#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
//        _tableView.backgroundColor=[UIColor lightGrayColor];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=41;
        _tableView.sectionHeaderHeight=58;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.backgroundColor=BACKGROUND_COLOR;
        _tableView.tableFooterView=view;
    }
    return _tableView;
}

- (NSArray *)arr {
    if (!_arr) {
        _arr=@[@"IEEE 802.11b/g/n（2.4G", @"无加密／WEP／WAP－PSK／WPA2-PSK"];
    }
    return _arr;
}

@end
