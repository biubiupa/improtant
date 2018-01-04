//
//  ControlViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/14.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "RHControlViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "WRNavigationBar.h"
#import "WRCustomNavigationBar.h"
#import "ControlTableViewCell.h"
#import "SliderTableViewCell.h"
#import "RHRightBarButtonItemViewController.h"
#import "RHSignInViewController.h"

#define CONTROL_COLOR [UIColor colorWithRed:114.0/255.0 green:132.0/255.0 blue:235.0/255.0 alpha:1.0]

@interface RHControlViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, assign) BOOL Hidden;
@property (nonatomic, assign) BOOL lowHidden;
@property (nonatomic, strong) SliderTableViewCell *cellOne;
@property (nonatomic, strong) ControlTableViewCell *cellTwo;

@end

@implementation RHControlViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.backgroundView];

    self.tableView.tableHeaderView=self.topView;


    [self setNavigationBar];
    [self.backgroundView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62, 62));
        make.top.equalTo(self.backgroundView).with.offset(19);
        make.centerX.equalTo(self.backgroundView);
    }];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.topView).with.insets(UIEdgeInsetsMake([self navHeight]+12, 12, 0, 12));
    }];
//    帐号
    [self.backgroundView addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(148, 16));
        make.centerX.equalTo(self.backgroundView);
        make.bottom.equalTo(self.iconView).with.offset(32);
    }];
//    企业编号
    [self.backgroundView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 16));
        make.centerX.equalTo(self.iconView);
        make.bottom.equalTo(self.iconView).with.offset(55);
    }];
//    登录提示语
    [self.backgroundView addSubview:self.signInLabel];
    [self.signInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230, 17));
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView).with.offset(45);
    }];
//    登录按钮
    [self.backgroundView addSubview:self.signInBtn];
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(109, 31));
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.self.signInLabel).with.offset(41);
    }];
    [_signInBtn addTarget:self action:@selector(signInAcction) forControlEvents:UIControlEventTouchUpInside];
    self.iconView.hidden=YES;
    self.accountLabel.hidden=YES;
    self.numberLabel.hidden=YES;
}

#pragma mark - delegate / datasorce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cellOne=[SliderTableViewCell new];
    self.cellTwo=[ControlTableViewCell new];
    if (indexPath.row == 0) {
        self.cellOne.signLabel.hidden=self.Hidden;
        self.cellOne.curtainView.hidden=self.lowHidden;
        self.cellOne.hidden=YES;
        return self.cellOne;
    }else {
        return self.cellTwo;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 0;
    }else {
        return 450.0;
    }
}

- (int)navBarBottom {
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    }else {
        return 64;
    }
    
}

- (CGFloat)navHeight {
    if ([WRNavigationBar isIphoneX]) {
        return 88.0;
    }else {
        return 64.0;
    }
}
//设置导航栏属性
#pragma mark - 导航栏属性
- (void)setNavigationBar {
//左右buttonitem
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(rightbtnAction)];
//    rightBI.tintColor=CONTROL_COLOR;
    UIBarButtonItem *leftBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qrcode"] style:UIBarButtonItemStylePlain target:self action:nil];
//    leftBI.tintColor=CONTROL_COLOR;
    self.navigationItem.rightBarButtonItem=rightBI;
    self.navigationItem.leftBarButtonItem=leftBI;
//    [self wr_setNavBarBackgroundAlpha:0];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.title=@"管理";
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)rightbtnAction {
    [self.navigationController pushViewController:[RHRightBarButtonItemViewController new] animated:YES];
}
#pragma mark - 设置头视图
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset=UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
    }
    return _tableView;
}

- (UIView *)topView {
    if (!_topView) {
//        _topView=[[UIView alloc] init];
        _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 247)];
        _topView.backgroundColor=BACKGROUND_COLOR;
    }
    return _topView;
    
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc] init];
//        _backgroundView.bounds=CGRectMake(0, 0, self.view.frame.size.width-24, 172);
        _backgroundView.backgroundColor=[UIColor whiteColor];
    }
    return _backgroundView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView=[[UIImageView alloc] init];
        _iconView.bounds=CGRectMake(0, 0, 62, 62);
        _iconView.image=[UIImage imageNamed:@"cat.jpg"];
    }
    return _iconView;
    
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel=[[UILabel alloc] init];
        _accountLabel.text=@"账号:----------";
        _accountLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _accountLabel;
    
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel=[[UILabel alloc] init];
        _numberLabel.text=@"企业编号:------";
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        _numberLabel.textColor=[UIColor lightGrayColor];
        _numberLabel.font=[UIFont systemFontOfSize:14];
    }
    return _numberLabel;
}
//欢迎语label初始化
- (UILabel *)signInLabel {
    if (!_signInLabel) {
        _signInLabel=[[UILabel alloc] init];
        _signInLabel.text=@"登录AirBoB，成为环保主义者";
        _signInLabel.textColor=[UIColor lightGrayColor];
        _signInLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _signInLabel;
}
//button初始化
- (UIButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_signInBtn setTitle:@"登录" forState:UIControlStateNormal];
        _signInBtn.layer.borderWidth=1;
        _signInBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _signInBtn.layer.cornerRadius=15;
        [_signInBtn setTintColor:[UIColor lightGrayColor]];
        
    }
    return _signInBtn;
}
//button点击事件
- (void)signInAcction {

    RHSignInViewController *rhVC=[RHSignInViewController new];
    __weak typeof(self) weakSelf=self;
    rhVC.callbackBlock = ^(BOOL hiden, NSString *accText, NSString *userID) {
        weakSelf.signInLabel.hidden=!hiden;
        weakSelf.signInBtn.hidden=!hiden;
        weakSelf.iconView.hidden=hiden;
        weakSelf.accountLabel.hidden=hiden;
        weakSelf.numberLabel.hidden=hiden;
        weakSelf.accountLabel.text=[NSString stringWithFormat:@"帐号%@",accText];
        weakSelf.numberLabel.text=[NSString stringWithFormat:@"企业编号%@",userID];
    };
    [self.navigationController pushViewController:rhVC animated:YES];
    
}




#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    
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
