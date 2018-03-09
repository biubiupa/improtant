//
//  RHchangePWViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/7.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHChangePWViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import <CommonCrypto/CommonDigest.h>
#import "RHSignInViewController.h"

@interface RHChangePWViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *verCodeTF;
@property (nonatomic, strong) UITextField *newsPassTF;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) NSString *parameter;

@end

@implementation RHChangePWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"忘记密码";
    [self.view addSubview:self.verCodeTF];
    [self.verCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(14);
    }];
    [self.view addSubview:self.newsPassTF];
    [self.newsPassTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(70);
    }];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-120, 45));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(165);
    }];
}

#pragma mark - 事件处理
- (void)changePassword {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:USER_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            for (UIViewController *VC in self.navigationController.viewControllers) {
                if ([VC isKindOfClass:[RHSignInViewController class]]) {
                    [self.navigationController popToViewController:VC animated:YES];
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error:%@",error);
    }];
    
}

#pragma mark - lazyLoad
- (UITextField *)verCodeTF {
    if (!_verCodeTF) {
        _verCodeTF=[[UITextField alloc] init];
        _verCodeTF.delegate=self;
        _verCodeTF.placeholder=@"短信验证码";
        _verCodeTF.backgroundColor=WhiteColor;
        _verCodeTF.font=[UIFont systemFontOfSize:15];
//        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 41)];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 41)];
        label.text=@"验证码";
        label.font=[UIFont systemFontOfSize:15];
        label.textAlignment=NSTextAlignmentCenter;
        UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        rightBtn.frame=CGRectMake(SCREEN_WIDTH-100, 0, 100, 41);
        [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        rightBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        rightBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
        _verCodeTF.leftView=label;
        _verCodeTF.leftViewMode=UITextFieldViewModeAlways;
        _verCodeTF.rightView=rightBtn;
        _verCodeTF.rightViewMode=UITextFieldViewModeAlways;
    }
    return _verCodeTF;
}

- (UITextField *)newsPassTF {
    if (!_newsPassTF) {
        _newsPassTF=[[UITextField alloc] init];
        _newsPassTF.delegate=self;
        _newsPassTF.placeholder=@"6-20位字母数字组合";
        _newsPassTF.font=[UIFont systemFontOfSize:15];
        _newsPassTF.backgroundColor=WhiteColor;
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 41)];
        label.text=@"设置新密码";
        label.font=[UIFont systemFontOfSize:15];
        label.textAlignment=NSTextAlignmentCenter;
        _newsPassTF.leftView=label;
        _newsPassTF.leftViewMode=UITextFieldViewModeAlways;
    }
    return _newsPassTF;
}

- (UIButton *)button {
    if (!_button) {
        _button=[UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"登录" forState:UIControlStateNormal];
        [_button setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"color"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (NSString *)parameter {
    if (!_parameter) {
        NSString *password=[self MD5:self.newsPassTF.text];
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-11-14 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @"10008",
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"toolNumber": self.toolNumber,
                            @"toolType": @1,
                            @"userType": @0,
                            @"passwordnew": password,
                            @"verficationCode": self.verCodeTF.text
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",_parameter);
    }
    return _parameter;
}

//MD5加密
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


@end
