//
//  RHDropDownButton.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/22.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHDropDownButton.h"
#import "Header.h"

@interface RHDropDownButton()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL status;

@end

@implementation RHDropDownButton
//静态标识符
static NSString *identifier=@"identifier";

//button初始化
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title list:(NSArray *)list {
    self=[super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.title=[NSString stringWithFormat:@"%@",title];
        self.list=[NSArray arrayWithArray:list];
        self.status=YES;
        [self setUp];
    }
    return self;
}

//添加下拉，收起动画
- (void)dropDownAnimation {
    CGRect frame=self.tableView.frame;
    frame.size.height=self.frame.size.height * self.list.count;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame=frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)pickUpAnimation {
    CGRect frame=self.tableView.frame;
    frame.size.height=0;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame=frame;
    } completion:^(BOOL finished) {
        
    }];
}

//添加点击事件
- (void)clickDropOrPick {

    self.status ? [self dropDownAnimation] : [self pickUpAnimation];
    self.status=!self.status;

    [self.tableView reloadData];
}

#pragma mark - 实现tableview的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text=self.list[indexPath.row];
    cell.textLabel.font=self.titleLabel.font;
    
    return cell;
}

//下拉列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setTitle:self.list[indexPath.row] forState:UIControlStateNormal];
    [self pickUpAnimation];
    self.status=!self.status;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height;
}

//设置button的初始化
- (void)setUp {
    [self setTitle:self.title forState:UIControlStateNormal];
//    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self addTarget:self action:@selector(clickDropOrPick) forControlEvents:UIControlEventTouchUpInside];
}

//下拉列表
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

//初始化button时也要把tableview添加到父视图上
- (void)didMoveToSuperview {
    [self.superview addSubview:self.tableView];
}


@end
