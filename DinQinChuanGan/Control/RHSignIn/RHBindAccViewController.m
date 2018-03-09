//
//  RHBindAccViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/3.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHBindAccViewController.h"
#import "Masonry.h"
#import "Header.h"
#import "AFNetworking.h"
#import "RHProveViewController.h"




@interface RHBindAccViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, strong) UIAlertController *alertCon;
@end

@implementation RHBindAccViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - layoutSubviews
- (void)layoutViews {
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backItem;
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"账号绑定";
    self.edgesForExtendedLayout=UIRectEdgeNone;
//  添加文本框
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(22);
    }];
//    添加下一步
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(293, 45));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.textField).with.offset(151);
    }];
}

#pragma mark - 懒加载
//文本框
- (UITextField *)textField {
    if (!_textField) {
        _textField=[[UITextField alloc] init];
        _textField.placeholder=@"绑定手机";
        _textField.backgroundColor=[UIColor whiteColor];
        _textField.textAlignment=NSTextAlignmentCenter;
        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _textField;
}
//提示框
- (UIAlertController *)alertCon {
    if (!_alertCon) {
        _alertCon=[UIAlertController alertControllerWithTitle:@"获取验证码失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [_alertCon addAction:done];
    }
    return _alertCon;
}

//下一步
- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"color"] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius=22.6;
        [_nextBtn addTarget:self action:@selector(netRequestAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
//获取验证码事件
- (void)netRequestAction {
    if (self.textField.text.length==11) {
        [self setUserInFo];
        NSString *urlString=USER_API;
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager POST:urlString parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (STATUS == 0) {
                RHProveViewController *proVC=[RHProveViewController new];
                proVC.phoneNumber=self.textField.text;
                proVC.account=self.account;
                proVC.corporationNum=self.corporationNum;
                [self.navigationController pushViewController:proVC animated:YES];
            }else {
                [self presentViewController:self.alertCon animated:YES completion:nil];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---ERROR:%@",error);
        }];
    }else {
        NSLog(@"请重新输入手机号！");
    }
    
    
}
//参数设置
- (void)setUserInFo {
    NSUserDefaults *userd=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userd stringForKey:@"userId"];
    NSString *phoneNumber=self.textField.text;
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @"1",
                         @"uuid": @"188111",
                         @"cmd": @"10004",
                         @"chcode": @"ef19843298ae8f2134f"
                         };
    NSDictionary *con=@{
                        @"toolNumber": phoneNumber,
                        @"toolType": @"1",
                        @"userId": userId,
                        @"userType":@"0"
                        };
    NSDictionary *dictJson=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictJson options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paragmeter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.parameter=paragmeter;
}


@end
