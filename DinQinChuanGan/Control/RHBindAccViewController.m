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



@interface RHBindAccViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, copy) NSString *parameter;
@end

@implementation RHBindAccViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - layoutSubviews
- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;

//  添加文本框
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(M_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(73);
    }];
//    添加下一步
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.height.mas_equalTo(45);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).with.offset(60);
        make.right.equalTo(self.view).with.offset(-60);
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
    [self setUserInFo];
    NSString *urlString=@"http://192.168.2.62:8089/diqin_app/user";
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:urlString parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"===发送成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---ERROR:%@",error);
    }];
    
}
//参数设置
- (void)setUserInFo {
    NSString *phoneNumber=self.textField.text;
    NSDate *date=[NSDate date];
    NSString *time=[NSString stringWithFormat:@"%@",date];
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": time,
                         @"sync": @"1",
                         @"uuid": @"188111",
                         @"cmd": @"10004",
                         @"chcode": @"ef19843298ae8f2134f"
                         };
    NSDictionary *con=@{
                        @"toolNumber": @"17621631698",
                        @"toolType": @"1",
                        @"userId": @"100001",
                        @"userType":@"0"
                        };
    NSDictionary *dictJson=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictJson options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paragmeter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.parameter=paragmeter;
}


@end
