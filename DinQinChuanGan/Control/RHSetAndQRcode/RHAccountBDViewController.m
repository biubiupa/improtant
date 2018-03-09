//
//  RHAccountBDViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/8.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAccountBDViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "RHAccountBTableViewCell.h"

@interface RHAccountBDViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *descArr;
@property (nonatomic, copy) NSArray *imgName;
@property (nonatomic, copy) NSArray *accountArr;

@end

@implementation RHAccountBDViewController

static NSString *identifier=@"cell";

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - GUI、布局
- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"帐号绑定";
    [self.view addSubview:self.tableView];
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RHAccountBTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.desLabel.text=self.descArr[indexPath.row];
    cell.imgview.image=[UIImage imageNamed:self.imgName[indexPath.row]];
    cell.accountLabel.text=self.accountArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor=BACKGROUND_COLOR;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=41;
        _tableView.contentInset=UIEdgeInsetsMake(10, 0, 0, 0);
        UIView *view=[UIView new];
        view.backgroundColor=BACKGROUND_COLOR;
        _tableView.tableFooterView=view;
        [_tableView registerClass:[RHAccountBTableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (NSArray *)descArr {
    if (!_descArr) {
        _descArr=@[@"手机号", @"邮箱账号"];
    }
    return _descArr;
}

- (NSArray *)imgName {
    if (!_imgName) {
        _imgName=@[@"phone", @"email"];
    }
    return _imgName;
}

- (NSArray *)accountArr {
    if (!_accountArr) {
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        NSString *phone=[userDefaults objectForKey:@"phone"];
        NSString *email=[userDefaults objectForKey:@"mailbox"];
        if (phone == nil || email == nil) {
            if (phone == nil) {
                phone=@"未绑定";
            }else {
                email=@"未绑定";
            }
        }
        _accountArr=@[phone,email];
    }
    return _accountArr;
}

@end
