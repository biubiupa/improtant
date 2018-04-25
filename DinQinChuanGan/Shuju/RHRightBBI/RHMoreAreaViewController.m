//
//  RHMoreAreaViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/4/24.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMoreAreaViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "Header.h"
#import "RHMoreTableViewCell.h"

@interface RHMoreAreaViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RHMoreAreaViewController

static NSString *identifier=@"cell";

#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutviews];
    
}

- (void)layoutviews {
    self.view.backgroundColor=WhiteColor;
    self.navigationItem.title=self.textTitle;
    [self.view addSubview:self.tableView];
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.areaList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RHMoreTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell=[[RHMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.lists=self.areaList;
    cell.aindex=indexPath.section;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6;
}

#pragma mark - lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=BACKGROUND_COLOR;
        _tableView.rowHeight=161;
        _tableView.sectionHeaderHeight=6;
        [_tableView registerClass:[RHMoreTableViewCell class] forCellReuseIdentifier:identifier];
        
        UIView *footview=[UIView new];
        footview.backgroundColor=BACKGROUND_COLOR;
        _tableView.tableFooterView=footview;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
