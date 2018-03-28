//
//  RHMoveTwoStepViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/22.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMoveTwoStepViewController.h"
#import "Header.h"
#import "RHEquipMessageViewController.h"

@interface RHMoveTwoStepViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *areaName;

@end

@implementation RHMoveTwoStepViewController

static NSString *identifier=@"cellid";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutviews];
}

- (void)layoutviews {
    self.navigationItem.title=@"移动到";
    [self.view addSubview:self.tableView];
    UIBarButtonItem *rightBBI=[[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(popToEquipVC)];
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
    return self.areaList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",self.areaList[indexPath.section][@"areaName"]];
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
    self.areaName=cell.textLabel.text;
    self.areaId=[self.areaList[indexPath.section][@"areaId"] integerValue];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.accessoryType=UITableViewCellAccessoryNone;
}

- (void)popToEquipVC {
//    发送通知
    NSString *name=[self.placeName stringByAppendingPathComponent:self.areaName];
    NSDictionary *dict=@{@"name":name, @"areaId":@(self.areaId)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moveEquipment" object:self userInfo:dict];
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[RHEquipMessageViewController class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
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


@end
