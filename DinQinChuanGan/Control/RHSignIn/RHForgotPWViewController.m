//
//  RHForgotPWViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/6.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHForgotPWViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "RHChangePWViewController.h"

@interface RHForgotPWViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *provePara;

@end

@implementation RHForgotPWViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}
#pragma mark -GUI处理
- (void)layoutViews {
    
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"忘记密码";
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backBBI;
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(14);
    }];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-120, 45));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(165);
    }];
}

#pragma mark - delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"color"] forState:UIControlStateNormal];
    self.nextBtn.enabled=YES;
    return YES;
}

- (void)verificationCodeRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:USER_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        if (st == 0) {
            RHChangePWViewController *changeVC=[RHChangePWViewController new];
            changeVC.toolNumber=self.textField.text;
            [self.navigationController pushViewController:changeVC animated:YES];
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--error:%@",error);
    }];
    
}

- (void)proveRequest {
    AFHTTPSessionManager *managerP=[AFHTTPSessionManager manager];
    [managerP POST:USER_API parameters:self.provePara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"head"][@"msg"]);
        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        if (st == 0) {
            [self verificationCodeRequest];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - lazyLoad
- (UITextField *)textField {
    if (!_textField) {
        _textField=[[UITextField alloc] init];
        _textField.placeholder=@"绑定手机／绑定邮箱";
        _textField.font=[UIFont systemFontOfSize:15];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 41)];
        _textField.leftView=view;
        _textField.leftViewMode=UITextFieldViewModeAlways;
        _textField.backgroundColor=WhiteColor;
        _textField.delegate=self;
    }
    return _textField;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _nextBtn.layer.cornerRadius=23;
        _nextBtn.backgroundColor=[UIColor lightGrayColor];
        [_nextBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(proveRequest) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.enabled=NO;
    }
    return _nextBtn;
}

- (NSString *)parameter {
    if (!_parameter) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *str=[user objectForKey:@"userId"];
        if (str!=nil) {
            self.userId=str;
        }else {
            self.userId=@"";
        }
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @10004,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"toolNumber": self.textField.text,
                            @"toolType": @1,
                            @"userId": self.userId,
                            @"userType": @0
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

- (NSString *)provePara {
    if (!_provePara) {
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-11-14 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @"10009",
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"toolNumber": self.textField.text,
                            @"toolType": @1,
                            @"userType": @0
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _provePara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _provePara;
}


@end
