//
//  RHSignInViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/28.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "RHSignInViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "Masonry.h"
#import "AFNetworking.h"
#import "RHBindAccViewController.h"


@interface RHSignInViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *logoImaV;
@property (nonatomic, strong) UILabel *notationLabel;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *passWordLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *forgotBtn;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, copy) NSString *strMD5;
@property (nonatomic, copy) NSDictionary *responseDict;
@property (nonatomic,assign) BOOL Hiden;
@property (nonatomic, strong) ControlViewController *controlVC;

@end

@implementation RHSignInViewController
#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Hiden=NO;
    self.view.backgroundColor=[UIColor whiteColor];
//    调布局方法
    [self layoutSubivews];
}

#pragma mark - 布局
- (void)layoutSubivews {
    
//    添加logo及其布局
    
    UIBarButtonItem *nullItem=[[UIBarButtonItem alloc] init];
    self.navigationItem.leftBarButtonItem=nullItem;
    [self.view addSubview:self.logoImaV];
    [self.logoImaV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(53, 53));
        make.left.equalTo(self.view).with.offset(124);
        make.top.equalTo(self.view).with.offset(144);
    }];
    
//   添加提示及其布局
    [self.view addSubview:self.notationLabel];
    [self.notationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(99, 31));
        make.centerY.equalTo(self.logoImaV);
        make.left.equalTo(self.logoImaV).with.offset(66);
    }];
    
//    账号及其布局
    [self.view addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 16));
        make.left.equalTo(self.view).with.offset(64);
        make.top.equalTo(self.view).with.offset(312);
    }];
    [self.view addSubview:self.account];
    [self.account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 16));
        make.centerY.equalTo(self.accountLabel);
        make.left.equalTo(self.accountLabel).with.offset(43);
    }];
    
//    密码及其布局
    [self.view addSubview:self.passWordLabel];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 16));
        make.centerX.equalTo(self.accountLabel);
        make.top.equalTo(self.accountLabel).with.offset(45);
    }];
    [self.view addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 16));
        make.centerY.equalTo(self.passWordLabel);
        make.left.equalTo(self.passWordLabel).with.offset(43);
    }];
    
//    提示线
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.height.mas_equalTo(1);
        make.top.equalTo(self.passWordLabel).with.offset(25);
        make.left.equalTo(self.view).with.offset(59);
        make.right.equalTo(self.view).with.offset(-59);
    }];
    
//忘记密码
    [self.view addSubview:self.forgotBtn];
    [self.forgotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(61, 16));
        make.top.equalTo(self.passWordLabel).with.offset(36);
        make.right.equalTo(self.view).with.offset(-59);
    }];
    
//    登录
    [self.view addSubview:self.signInBtn];
    [self.signInBtn addTarget:self action:@selector(signAcction) forControlEvents:UIControlEventTouchUpInside];
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(293, 46));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passWordLabel).with.offset(89);
    }];
}
#pragma mark - textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.account || textField == self.password) {
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark - 懒加载property
//logo图标初始化
- (UIImageView *)logoImaV {
    if (!_logoImaV) {
        _logoImaV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechat"]];
    }
    return _logoImaV;
}
//右边提示语初始化
- (UILabel *)notationLabel {
    if (!_notationLabel) {
        _notationLabel=[[UILabel alloc] init];
        _notationLabel.textColor=[UIColor lightGrayColor];
        _notationLabel.font=[UIFont systemFontOfSize:12];
        _notationLabel.numberOfLines=2;
        _notationLabel.text=@"关心生活品质    从呼吸的空气开始";
    }
    return _notationLabel;
}

/*
 账号密码初始化
*/
- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel=[[UILabel alloc] init];
        _accountLabel.text=@"帐号";
        _accountLabel.adjustsFontSizeToFitWidth=YES;
    }
    return _accountLabel;
}
- (UILabel *)passWordLabel {
    if (!_passWordLabel) {
        _passWordLabel=[[UILabel alloc] init];
        _passWordLabel.text=@"密码";
        _passWordLabel.adjustsFontSizeToFitWidth=YES;
    }
    return _passWordLabel;
}
- (UITextField *)account {
    if (!_account) {
        _account=[[UITextField alloc] init];
        _account.placeholder=@"请输入帐号";
        _account.delegate=self;
        _account.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _account;
}
- (UITextField *)password {
    if (!_password) {
        _password=[[UITextField alloc] init];
        _password.placeholder=@"请输入密码";
        _password.delegate=self;
        _password.clearButtonMode=UITextFieldViewModeWhileEditing;
//        密码文本为加密样式，不显示正文
        _password.secureTextEntry=YES;
    }
    return _password;
}

//提示线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=[UIColor lightGrayColor];
    }
    return _lineView;
}

//忘记密码
- (UIButton *)forgotBtn {
    if (!_forgotBtn) {
        _forgotBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        NSMutableAttributedString *title=[[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 5)];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 5)];
        [title addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(0, 5)];
        [_forgotBtn setAttributedTitle:title forState:UIControlStateNormal];
    }
    return _forgotBtn;
}

//登录及其处理事件
- (UIButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _signInBtn.layer.cornerRadius=23;
        [_signInBtn setTitle:@"登录" forState:UIControlStateNormal];
        _signInBtn.tintColor=[UIColor whiteColor];
//        _signInBtn.backgroundColor=[UIColor purpleColor];
        [_signInBtn setBackgroundImage:[UIImage imageNamed:@"color"] forState:UIControlStateNormal];
        
    }
    return _signInBtn;
}
- (void)signAcction {


//    返回到上一层
    self.strMD5=[self MD5:self.password.text];
    NSString *urlString=@"http://192.168.2.62:8089/diqin_app/user";
    NSDictionary *head=@{@"aid":@"1and6uu",
                         @"ver":@"1.0",
                         @"ln":@"cn",
                         @"mod":@"ios",
                         @"de":@"2017-11-14 00:00:00",
                         @"sync":@"1",
                         @"uuid":@"188111",
                         @"cmd":@"10001",
                         @"chcode":@"ef19843298ae8f2134f"};
    NSDictionary *con=@{@"account":self.account.text,
                        @"password":self.strMD5,
                        @"userType":@"0"};
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *parameters=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功-------%@",responseObject);
       
        self.responseDict=responseObject;
        NSString *st=[NSString stringWithFormat:@"%@",self.responseDict[@"head"][@"st"]];
//        判断登录是否成功
        if ([st isEqualToString:@"0"]) {
            NSString *userId=[NSString stringWithFormat:@"%@",self.responseDict[@"body"][@"userId"]];
            NSLog(@"========%@",userId);
//        block逆向传值
            self.callbackBlock(self.Hiden, self.account.text, userId);
            [self.navigationController popViewControllerAnimated:YES];
//            登录失败
        }else {
            NSLog(@"请重新输入密码！");
//            自定义返回按钮，即A控制器push到b控制器时，返回按钮是需要在A控制器push之前自定义的
            UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem=backItem;
            RHBindAccViewController *bindVC=[RHBindAccViewController new];
            [self.navigationController pushViewController:bindVC animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR:%@",error);
    }];
}
//MD5算法
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
