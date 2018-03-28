//
//  RHAmendPassWViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/5.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAmendPassWViewController.h"
#import "Header.h"
#import "Masonry.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"
#import "RHSignInViewController.h"

@interface RHAmendPassWViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UITextField *oldsPsTF;
@property (nonatomic, strong) UITextField *newsPsTF;
@property (nonatomic, strong) UITextField *confirmTF;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *oldPassword;
@property (nonatomic, copy) NSString *newsPassword;
@property (nonatomic, strong) UIBarButtonItem *rightBBI;


@end

@implementation RHAmendPassWViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self lauoutViews];
}

#pragma mark - lauoutViews
//处理视图
- (void)lauoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"重置密码";
    self.rightBBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(changePassword)];
    self.rightBBI.tintColor=LightGrayColor;
    self.rightBBI.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightBBI;
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backBBI;
    //    the year which of 2018 is begin,you must be very hard,ok?fighting!believe your self;
    
    UIView *oneview=[UIView new];
    oneview.backgroundColor=BACKGROUND_COLOR;
    UIView *twoview=[UIView new];
    twoview.backgroundColor=BACKGROUND_COLOR;
    UIView *threeview=[UIView new];
    threeview.backgroundColor=BACKGROUND_COLOR;
    
    
    [self.view addSubview: self.bacView];
    [self.bacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 10));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(10);
    }];
    [self.bacView addSubview:self.accountTF];
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 41));
        make.left.equalTo(self.bacView).with.offset(20);
        make.top.equalTo(self.bacView).with.offset(0);
    }];
    [self.bacView addSubview:self.oldsPsTF];
    [self.oldsPsTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 41));
        make.left.equalTo(self.bacView).with.offset(20);
        make.top.equalTo(self.bacView).with.offset(41);
    }];
    [self.bacView addSubview:self.newsPsTF];
    [self.newsPsTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 41));
        make.left.equalTo(self.bacView).with.offset(20);
        make.top.equalTo(self.bacView).with.offset(82);
    }];
    [self.bacView addSubview:self.confirmTF];
    [self.confirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 41));
        make.left.equalTo(self.bacView).with.offset(20);
        make.top.equalTo(self.bacView).with.offset(123);
    }];
    [self.bacView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(245, 10));
        make.left.equalTo(self.bacView).with.offset(20);
        make.top.equalTo(self.bacView).with.offset(180);
    }];
    [self.bacView addSubview:oneview];
    [oneview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 1));
        make.centerX.equalTo(self.bacView);
        make.top.equalTo(self.bacView).with.offset(82);
    }];
    [self.bacView addSubview:twoview];
    [twoview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 1));
        make.centerX.equalTo(self.bacView);
        make.top.equalTo(self.bacView).with.offset(123);
    }];
    [self.bacView addSubview:threeview];
    [threeview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 1));
        make.centerX.equalTo(self.bacView);
        make.top.equalTo(self.bacView).with.offset(164);
    }];
    
    
    
}

#pragma mark - uitextfielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.rightBBI.tintColor=CONTROL_COLOR;
    self.rightBBI.enabled=YES;
    return YES;
}

#pragma mark - 事件处理
//请求修改密码
- (void)changePassword {
    if ([self.confirmTF.text isEqualToString:self.newsPsTF.text]) {
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager POST:USER_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSInteger st=[responseObject[@"head"][@"st"] integerValue];
            if (st == 0) {
                [self.navigationController pushViewController:[RHSignInViewController new] animated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"--error:%@",error);
        }];
    }else {
        NSLog(@"密码输入不一致!");
    }
    
}

- (NSString *)MD5:(NSString *)input {
    const char *cStr=[input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString *output=[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH  * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [output appendFormat:@"%02x",digest[i]] ;
    }
    return output;
}

#pragma mark - lazyLoad

- (UIView *)bacView {
    if (!_bacView) {
        _bacView=[UIView new];
        _bacView.backgroundColor=[UIColor whiteColor];
    }
    return _bacView;
}

- (UITextField *)accountTF {
    if (!_accountTF) {
        _accountTF=[[UITextField alloc] init];
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 41)];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 41)];
        label.text=@"帐号";
        label.textColor=[UIColor grayColor];
        [leftView addSubview:label];
        _accountTF.leftView=leftView;
        _accountTF.leftViewMode=UITextFieldViewModeAlways;
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        _accountTF.text=[user objectForKey:@"account"];
        _accountTF.textColor=[UIColor grayColor];
        _accountTF.enabled=NO;
    }
    return _accountTF;
}

- (UITextField *)oldsPsTF {
    if (!_oldsPsTF) {
        _oldsPsTF=[[UITextField alloc] init];
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 41)];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 41)];
        label.text=@"旧密码";
        _oldsPsTF.placeholder=@"请输入旧密码";
        [leftView addSubview:label];
        _oldsPsTF.leftView=leftView;
        _oldsPsTF.leftViewMode=UITextFieldViewModeAlways;
        _oldsPsTF.delegate=self;
    }
    return _oldsPsTF;
}

- (UITextField *)newsPsTF {
    if (!_newsPsTF) {
        _newsPsTF=[[UITextField alloc] init];
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 41)];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 41)];
        label.text=@"新密码";
        _newsPsTF.placeholder=@"请设置登录密码";
        [leftView addSubview:label];
        _newsPsTF.leftView=leftView;
        _newsPsTF.leftViewMode=UITextFieldViewModeAlways;
        _newsPsTF.delegate=self;
    }
    return _newsPsTF;
}

- (UITextField *)confirmTF {
    if (!_confirmTF) {
        _confirmTF=[[UITextField alloc] init];
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 41)];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 41)];
        label.text=@"确认密码";
        [leftView addSubview:label];
        _confirmTF.placeholder=@"请再次输入登录密码";
        _confirmTF.leftView=leftView;
        _confirmTF.leftViewMode=UITextFieldViewModeAlways;
        _confirmTF.delegate=self;
    }
    return _confirmTF;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel=[[UILabel alloc] init];
        _tipsLabel.textColor=[UIColor lightGrayColor];
        _tipsLabel.text=@"密码必须包含至少8个字符，而且同时包含字母和数字";
        _tipsLabel.font=[UIFont systemFontOfSize:10];
    }
    return _tipsLabel;
}

//参数
- (NSString *)parameter {
    if (!_parameter) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *str=[user objectForKey:@"userId"];
        NSInteger userId=[str integerValue];
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-11-14 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @10002,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        self.oldPassword=[self MD5:self.oldsPsTF.text];
        self.newsPassword=[self MD5:self.newsPsTF.text];
        NSDictionary *con=@{
                            @"passwordold": self.oldPassword,
                            @"passwordnew": self.newsPassword,
                            @"userId": @(userId)
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}


@end
