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

@interface RHMoreAreaViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, copy) NSMutableArray *searchArr;

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
    self.searchController=[[UISearchController alloc] initWithSearchResultsController:nil];
    //    代理
    self.searchController.delegate=self;
    self.searchController.searchResultsUpdater=self;
    
    //    searchbar颜色
    self.searchController.searchBar.barTintColor=BACKGROUND_COLOR;
    self.searchController.searchBar.placeholder=@"搜索";
    
    //    点击时属性设置
    self.searchController.dimsBackgroundDuringPresentation=NO;
    self.searchController.hidesNavigationBarDuringPresentation=YES;
    //添加search bar到headerview
    [self.searchController.searchBar  sizeToFit];
    self.tableView.tableHeaderView=self.searchController.searchBar;
    self.definesPresentationContext=YES;

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

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    searchController.searchBar.showsCancelButton = YES;
        for(id sousuo in [searchController.searchBar subviews])
        {
            for (id zz in [sousuo subviews])
            {
                if([zz isKindOfClass:[UIButton class]]){
                    UIButton *btn = (UIButton *)zz;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
        }
    
    
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
