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
#import "RHAccountBDViewController.h"
#import "UIImageView+WebCache.m"
#import "AppDelegate.h"

@interface RHRightBarButtonItemViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) NSArray *arrone;
@property (nonatomic, copy) NSArray *arrtwo;
@property (nonatomic, copy) NSArray *arrthree;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, strong) UISwitch *noticeS;
@property (nonatomic, strong) UISwitch *publicS;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *clearLabel;
@end

@implementation RHRightBarButtonItemViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    计算缓存大小
    NSUInteger size=[[SDImageCache sharedImageCache] getSize];
    CGFloat MBcache=size/1024/1024;
    self.clearLabel.text=[NSString stringWithFormat:@"%.1lfM",MBcache];

}
- (void)layoutViews {
    self.view.backgroundColor=[UIColor purpleColor];
    self.navigationItem.title=@"设置";
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backItem;
    [self.view addSubview:self.tableView];
    NSUserDefaults *userd=[NSUserDefaults standardUserDefaults];
    self.account=[userd objectForKey:@"account"];
}

#pragma mark - delegate/datasource
//    section之间的间距(组成：section的头视图高度和尾视图高度)
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=self.array[indexPath.section][indexPath.row];
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
    if (indexPath.row == 0) {
        if (indexPath.section == 0) {
            [cell.contentView addSubview:self.accountLabel];
            [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(100, 15));
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).with.offset(-15);
            }];
        }else if (indexPath.section == 1) {
            [cell.contentView addSubview:self.clearLabel];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [self.clearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo (CGSizeMake(50, 15));
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).with.offset(0);
            }];
        }
    }
    return cell;
}

#pragma mark - 事件处理
//    处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    点击cell时取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            RHAmendPassWViewController *amendVC=[RHAmendPassWViewController new];
            [self.navigationController pushViewController:amendVC animated:YES];
        }else if (indexPath.row == 2) {
            [self.navigationController pushViewController:[RHAccountBDViewController new] animated:YES];
        }
    }else if (indexPath.section == 1) {
//        清除缓存
        if (indexPath.row == 0) {
            [self clearCache];
        }else if (indexPath.row == 1) {
            [self changeLangue];
        }
    }else {
//        退出登录
        self.accountLabel.text=@"";
        AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [UserDefaults removeObjectForKey:@"userId"];
        [appdelegate realloc];
    }
    
    
}

//清除缓存事件
- (void)clearCache {
    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        self.clearLabel.text=@"0M";
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertCon animated:YES completion:nil];
}

//切换语言
- (void)changeLangue {
    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"中文" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"English" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertCon animated:YES completion:nil];
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

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel=[[UILabel alloc] init];
        _accountLabel.text=self.account;
        _accountLabel.textColor=[UIColor grayColor];
        _accountLabel.textAlignment=NSTextAlignmentRight;
    }
    return _accountLabel;
}

- (UILabel *)clearLabel  {
    if (!_clearLabel) {
        _clearLabel=[[UILabel alloc] init];
        _clearLabel.textAlignment=NSTextAlignmentRight;
        
    }
    return _clearLabel;
}


@end
