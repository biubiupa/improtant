//
//  RHProveViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/4.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHProveViewController.h"
#import "Header.h"
#import "Masonry.h"

@interface RHProveViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *proveLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *bindBtn;
@property (nonatomic, strong) UIView *bacgroundView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation RHProveViewController
#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - 处理布局
- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"手机号绑定";
//    提示框已发送
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 15));
        make.left.equalTo(self.view).with.offset(12);
        make.top.equalTo(self.view).with.offset(90);
    }];
//    背景图
    [self.view addSubview:self.bacgroundView];
    [self.bacgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(M_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.tipLabel).with.offset(27);
    }];
//    验证码label
    [self.bacgroundView addSubview:self.proveLabel];
    [self.proveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 15));
        make.centerY.equalTo(self.bacgroundView);
        make.left.equalTo(self.bacgroundView).with.offset(12);
    }];
//    验证码输入
    [self.bacgroundView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 15));
        make.centerY.equalTo(self.proveLabel);
        make.left.equalTo(self.proveLabel).with.offset(70);
    }];
//    倒计时
    [self.bacgroundView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(92, 14));
        make.centerY.equalTo(self.bacgroundView);
        make.right.equalTo(self.bacgroundView).with.offset(-5);
    }];
//    分割线
    [self.bacgroundView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 41));
        make.centerY.equalTo(self.bacgroundView);
        make.right.equalTo(self.bacgroundView).with.offset(-105);
    }];
//    绑定
    [self.view addSubview:self.bindBtn];
    [self.bindBtn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(293, 45));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(268);
    }];
}

#pragma mark - 懒加载
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel=[[UILabel alloc] init];
        NSString *text=@"验证短信已发送至 ";
        _tipLabel.text=[text stringByAppendingString:self.phoneNumber];
    }
    return _tipLabel;
}

- (UILabel *)proveLabel {
    if (!_proveLabel) {
        _proveLabel=[[UILabel alloc] init];
        _proveLabel.text=@"验证码";
    }
    return _proveLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField=[[UITextField alloc] init];
        _textField.placeholder=@"短信验证码";
        _textField.delegate=self;
    }
    return _textField;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc] init];
        _timeLabel.text=@"59秒后重新获取";
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.font=[UIFont systemFontOfSize:12];
        _timeLabel.textColor=[UIColor lightGrayColor];
    }
    return _timeLabel;
}

- (UIButton *)bindBtn {
    if (!_bindBtn) {
        _bindBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _bindBtn.layer.cornerRadius=23;
        [_bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [_bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bindBtn.backgroundColor=[UIColor lightGrayColor];
        _bindBtn.enabled=NO;
        
    }
    return _bindBtn;
}

- (UIView *)bacgroundView {
    if (!_bacgroundView) {
        _bacgroundView=[[UIView alloc] init];
        _bacgroundView.backgroundColor=[UIColor whiteColor];
    }
    return _bacgroundView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=[UIColor lightGrayColor];
    }
    return _lineView;
}

//  绑定点击事件
- (void)clickBtnAction {
    [self.textField resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//    代理设置按钮响应状态
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.bindBtn setBackgroundImage:[UIImage imageNamed:@"color"] forState:UIControlStateNormal];
    self.bindBtn.enabled=YES;
    self.bindBtn.backgroundColor=nil;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
