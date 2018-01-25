//
//  RHMyAreaViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/11.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMyAreaViewController.h"
#import "Header.h"

@interface RHMyAreaViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic,strong) UIView * markView;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, strong) UIButton *dropBtn;
@property (nonatomic, strong) UITableViewCell *cell;



@end

@implementation RHMyAreaViewController

static NSString *identifier=@"identifier";
static NSString *ident=@"ident";

//初始化视图


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];

}


//处理布局
- (void)layoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
//    点击第一次的初始状态
    self.status=YES;
    self.list=@[@"zhangsan", @"lisi",@"wahaha"];
//    self.view.backgroundColor=[UIColor purpleColor];
    UIButton *dropBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [dropBtn setTitle:@"我又来了" forState:UIControlStateNormal];
    [dropBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dropBtn addTarget:self action:@selector(clickDropOrPick) forControlEvents:UIControlEventTouchUpInside];
    self.dropBtn=dropBtn;
    self.navigationItem.titleView=self.dropBtn;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.markView];
    [self.view addSubview:self.listView];

}

#pragma mark - 实现tableview的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.listView) {
        return 1;
    }else {
        return 5;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.listView) {
        return self.list.count;
    }else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.listView) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ident];
        cell.textLabel.text=self.list[indexPath.row];
        cell.backgroundColor=BACKGROUND_COLOR;
        
        return cell;
    } else {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        cell.textLabel.text=@"34567890-";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        self.cell=cell;
        return self.cell;
    }
    
}

//下拉列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.listView) {
        [self.dropBtn setTitle:self.list[indexPath.row] forState:UIControlStateNormal];
        [self pickUpAnimation];
        self.status=!self.status;
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.listView) {
        return self.dropBtn.frame.size.height;
    } else {
        return 99;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 13;
    } else {
        return 0;
    }
}

//添加下拉，收起动画
- (void)dropDownAnimation {
    CGRect frame=self.listView.frame;
    frame.size.height=self.dropBtn.frame.size.height * self.list.count;
    [UIView animateWithDuration:0.3 animations:^{
        self.listView.frame=frame;
        self.markView.alpha=0.5;
        self.markView.backgroundColor=[UIColor lightGrayColor];
        self.cell.userInteractionEnabled=NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)pickUpAnimation {
    CGRect frame=self.listView.frame;
    frame.size.height=0;
    [UIView animateWithDuration:0.3 animations:^{
        self.listView.frame=frame;
        self.markView.alpha=0;
        self.markView.userInteractionEnabled=YES;
        self.cell.userInteractionEnabled=YES;
    } completion:^(BOOL finished) {
        
    }];
}

//添加点击事件
- (void)clickDropOrPick {
    
    self.status ? [self dropDownAnimation] : [self pickUpAnimation];
    self.status=!self.status;
    
    [self.listView reloadData];
}

#pragma mark - 懒加载
//下拉列表
- (UITableView *)listView {
    if (!_listView) {
        _listView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _listView.delegate=self;
        _listView.dataSource=self;
        [_listView registerClass:[UITableViewCell class] forCellReuseIdentifier:ident];
    }
    return _listView;
}

//场所列表
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=BACKGROUND_COLOR;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}

- (UIView *)markView {
    if (!_markView) {
        _markView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _markView.alpha=0;
    }
    return _markView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
