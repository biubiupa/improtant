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
#import "AFNetworking.h"
#import "RHAccountBDViewController.h"

@interface RHProveViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *proveLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *bindBtn;
@property (nonatomic, strong) UIView *bacgroundView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, assign) BOOL Hiden;
@property (nonatomic, copy) NSString *confirm;
@property (nonatomic, copy) NSString *proString;
@property (nonatomic, copy) NSString *removePara;


@end

@implementation RHProveViewController
#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    self.Hiden=0;
    self.confirm=[UserDefaults objectForKey:@"numbers"];
//    if (self.toolType == 1) {
//        self.proString=[UserDefaults objectForKey:@"phone"];
//    }else {
//        self.proString=[UserDefaults objectForKey:@"mailBox"];
//    }
    self.proString=[UserDefaults objectForKey:@"proveString"];
}



#pragma mark - 处理布局
- (void)layoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"手机号绑定";
//    提示框已发送
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 15));
        make.left.equalTo(self.view).with.offset(12);
        make.top.equalTo(self.view).with.offset(22);
    }];
//    背景图
    [self.view addSubview:self.bacgroundView];
    [self.bacgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
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
    [self.bacgroundView addSubview:self.timeBtn];
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(self.view).with.offset(204);
    }];
}

#pragma mark - 事件处理
//  绑定点击事件
- (void)clickBtnAction {
    [self.textField resignFirstResponder];
    if (self.proString == nil) {
//        绑定手机
        [self bindPhoneOrMailBox];
    }else {
//        更换手机号
        [self removePhoneOrMailBox];
    }
    
    
    
}

//绑定手机、邮箱
- (void)bindPhoneOrMailBox {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:USER_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---%@",MSG);
        
        if (STATUS == 0) {
            if (self.confirm == nil && self.proString == nil) {
                NSDictionary *dict=@{@"Hiden":@(0), @"account":self.account, @"corporationNum":self.corporationNum};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:self userInfo:dict];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else {
                for (UIViewController *VC in self.navigationController.viewControllers) {
                    if ([VC isKindOfClass:[RHAccountBDViewController class]]) {
                        [self.navigationController popToViewController:VC animated:YES];
                        [UserDefaults removeObjectForKey:@"numbers"];
                        [UserDefaults removeObjectForKey:@"proveString"];
                    }
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"====error:%@",error);
    }];
}

//解绑手机
- (void)removePhoneOrMailBox {
    AFHTTPSessionManager *managert=[AFHTTPSessionManager manager];
    [managert POST:USER_API parameters:self.removePara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            [self bindPhoneOrMailBox];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
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

- (UIButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        NSMutableAttributedString *title=[[NSMutableAttributedString alloc] initWithString:@"59秒后重新获取"];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 8)];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 8)];
        [_timeBtn setAttributedTitle:title forState:UIControlStateNormal];
    }
    return _timeBtn;
}

- (UIButton *)bindBtn {
    if (!_bindBtn) {
        _bindBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _bindBtn.layer.cornerRadius=23;
        [_bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [_bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bindBtn.backgroundColor=[UIColor lightGrayColor];
        _bindBtn.enabled=NO;
        [_bindBtn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
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

//      request参数设置(绑定)
- (NSString *)parameter {
    if (!_parameter) {
        NSUserDefaults *userd=[NSUserDefaults standardUserDefaults];
        NSString *userId=[userd stringForKey:@"userId"];
        NSString *toolnumber=self.phoneNumber;
        NSString *verficationCode=self.textField.text;
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod":@"ios",
                             @"de": @"2017-11-14 00:00:00",
                             @"sync":@"1",
                             @"uuid":@"188111",
                             @"cmd":@"10003",
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"toolNumber":toolnumber,
                            @"userId":userId,
                            @"toolType":@(self.toolType),
                            @"verficationCode":verficationCode
                            };
        NSDictionary *dictJson=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dictJson options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

//解绑
- (NSString *)removePara {
    if (!_removePara) {
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @10006,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"userId": UserId,
                            @"toolType": @(self.toolType)
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _removePara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _removePara;
}


@end
