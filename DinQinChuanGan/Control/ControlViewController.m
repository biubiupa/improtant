//
//  ControlViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/14.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "ControlViewController.h"
#import "Masonry.h"
#import "WRNavigationBar.h"
#import "WRCustomNavigationBar.h"
#import "ControlTableViewCell.h"
#import "SliderTableViewCell.h"


#define CONTROL_COLOR [UIColor colorWithRed:114.0/255.0 green:132.0/255.0 blue:235.0/255.0 alpha:1.0]

@interface ControlViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *signInLabel;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, assign) BOOL Hidden;
@property (nonatomic, assign) BOOL lowHidden;
@property (nonatomic, strong) SliderTableViewCell *cellOne;
@property (nonatomic, strong) ControlTableViewCell *cellTwo;

@end

@implementation ControlViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.iconView];
    self.tableView.tableHeaderView=self.topView;
    [self setNavigationBar];
    [self.topView addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(148, 16));
        make.centerX.equalTo(self.iconView);
        make.bottom.equalTo(self.iconView).with.offset(35);
    }];
    [self.topView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 16));
        make.centerX.equalTo(self.iconView);
        make.bottom.equalTo(self.iconView).with.offset(60);
    }];
    [self.topView addSubview:self.signInLabel];
    [self.signInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230, 17));
        make.center.equalTo(self.topView);
    }];
    [self.topView addSubview:self.signInBtn];
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(109, 31));
        make.centerX.equalTo(self.topView);
        make.bottom.equalTo(self.topView).with.offset(-41);
    }];
    [_signInBtn addTarget:self action:@selector(signInAcction) forControlEvents:UIControlEventTouchUpInside];
    self.iconView.hidden=YES;
    self.accountLabel.hidden=YES;
    self.numberLabel.hidden=YES;
    self.lowHidden=YES;
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
        return self.cellOne;
    }else {
        return self.cellTwo;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 72.0;
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

- (void)setNavigationBar {
//左右buttonitem
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shezhi"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *leftBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tianjia"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem=rightBI;
    self.navigationItem.leftBarButtonItem=leftBI;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
}
#pragma mark - 设置头视图
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset=UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
    }
    return _tableView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 208)];
        _topView.backgroundColor=CONTROL_COLOR;
    }
    return _topView;
    
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView=[[UIImageView alloc] init];
        _iconView.center=self.topView.center;
        _iconView.bounds=CGRectMake(0, 0, 62, 62);
        _iconView.image=[UIImage imageNamed:@"head"];
    }
    return _iconView;
    
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel=[[UILabel alloc] init];
        _accountLabel.text=@"账号:-------";
        _accountLabel.backgroundColor=[UIColor whiteColor];
    }
    return _accountLabel;
    
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel=[[UILabel alloc] init];
        _numberLabel.text=@"企业编号:------";
    }
    return _numberLabel;
}

- (UILabel *)signInLabel {
    if (!_signInLabel) {
        _signInLabel=[[UILabel alloc] init];
        _signInLabel.text=@"登录AirBoB，成为环保主义者";
        _signInLabel.textColor=[UIColor whiteColor];
        _signInLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _signInLabel;
}

- (UIButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_signInBtn setTitle:@"登录" forState:UIControlStateNormal];
        _signInBtn.layer.borderWidth=1;
        _signInBtn.layer.borderColor=[UIColor whiteColor].CGColor;
        _signInBtn.layer.cornerRadius=15;
        [_signInBtn setTintColor:[UIColor whiteColor]];
        
    }
    return _signInBtn;
}
//button点击事件
- (void)signInAcction {
    self.iconView.hidden=NO;
    self.accountLabel.hidden=NO;
    self.numberLabel.hidden=NO;
    self.signInLabel.hidden=YES;
    self.signInBtn.hidden=YES;
    
//    [self.control.backgoundView setHidden:NO];
    self.Hidden=YES;
    self.lowHidden=NO;
    [self.tableView reloadData];

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
