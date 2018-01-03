//
//  RHRightBarButtonItemViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/26.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "RHRightBarButtonItemViewController.h"

@interface RHRightBarButtonItemViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) NSArray *arrone;
@property (nonatomic, copy) NSArray *arrtwo;
@property (nonatomic, copy) NSArray *arrthree;
@end

@implementation RHRightBarButtonItemViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor purpleColor];
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
    return cell; 
}
#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
