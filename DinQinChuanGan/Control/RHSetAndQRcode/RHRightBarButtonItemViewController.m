//
//  RHRightBarButtonItemViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/26.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "RHRightBarButtonItemViewController.h"
#import "Masonry.h"
#import "Header.h"
#import "RHAmendPassWViewController.h"

@interface RHRightBarButtonItemViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) NSArray *arrone;
@property (nonatomic, copy) NSArray *arrtwo;
@property (nonatomic, copy) NSArray *arrthree;
@property (nonatomic, strong) UISwitch *noticeS;
@property (nonatomic, strong) UISwitch *publicS;
@end

@implementation RHRightBarButtonItemViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor purpleColor];
    self.navigationItem.title=@"设置";
    [self.view addSubview:self.tableView];
}
#pragma mark - delegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=self.array[indexPath.section][indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    if (indexPath.section == 2) {
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
//    添加控件
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row==3) {
        [cell.contentView addSubview:self.noticeS];
        [self.noticeS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).with.offset(-15);
        }];
    }else if (indexPath.row == 4) {
        [cell.contentView addSubview:self.publicS];
        [self.publicS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).with.offset(-15);
        }];
    }
    return cell;
}

//    处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    点击cell时取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        RHAmendPassWViewController *amendVC=[RHAmendPassWViewController new];
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem=backItem;
        [self.navigationController pushViewController:amendVC animated:YES];
    }
    
}
//    section之间的间距(组成：section的头视图高度和尾视图高度)
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=44;
        _tableView.sectionHeaderHeight=12;
        _tableView.sectionFooterHeight=0;
//        解决tableview占不满屏幕，下方空白处有分割线的问题
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
- (NSArray *)arrone {
    if (!_arrone) {
        _arrone=@[@"账号", @"密码", @"账号绑定"];
    }
    return _arrone;
}

- (NSArray *)arrtwo {
    if (!_arrtwo) {
        _arrtwo=@[@"清除缓存", @"语言", @"软件更新", @"消息通知" ,@"公开数据"];
    }
    return _arrtwo;
}

- (NSArray *)arrthree {
    if (!_arrthree) {
        _arrthree=@[@"退出登录"];
    }
    return _arrthree;
}
- (NSArray *)array {
    if (!_array) {
        _array=@[self.arrone, self.arrtwo, self.arrthree];
    }
    return _array;
}
//      switch
- (UISwitch *)noticeS {
    if (!_noticeS) {
        _noticeS=[[UISwitch alloc] init];
        _noticeS.onTintColor=CONTROL_COLOR;
    }
    return _noticeS;
}

- (UISwitch *)publicS {
    if (!_publicS) {
        _publicS=[[UISwitch alloc] init];
        _publicS.onTintColor=CONTROL_COLOR;
    }
    return _publicS;
}


@end
