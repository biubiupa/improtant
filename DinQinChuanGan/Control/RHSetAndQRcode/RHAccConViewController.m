//
//  RHAccConViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/9.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAccConViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "Header.h"

@interface RHAccConViewController ()
@property (nonatomic, copy) NSString *parameter;

@end

@implementation RHAccConViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - layoutViews
- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"帐号绑定";
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66, 51));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(50);
    }];
    [self.view addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 21));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(146);
    }];
    [self.view addSubview:self.changeBtn];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 120, 45));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(220);
    }];
    [self.view addSubview:self.removeBtn];
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 120, 45));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(290);
    }];
}

#pragma mark - 点击事件处理
- (void)removeAcction {
    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:self.tipStr message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager POST:USER_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",MSG);
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertCon animated:YES completion:nil];
    
}

#pragma mark - lazyLoad
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView=[[UIImageView alloc] init];
        _imgView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel=[[UILabel alloc] init];
        _accountLabel.textColor=[UIColor lightGrayColor];
        _accountLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _accountLabel;
}

- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _changeBtn.layer.cornerRadius=23;
        [_changeBtn setBackgroundImage:[UIImage imageNamed:@"color"] forState:UIControlStateNormal];
        [_changeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    }
    return _changeBtn;
}

- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _removeBtn.layer.cornerRadius=23;
        [_removeBtn setTitle:@"解绑" forState:UIControlStateNormal];
        [_removeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _removeBtn.backgroundColor=WhiteColor;
        [_removeBtn addTarget:self action:@selector(removeAcction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}

- (NSString *)parameter {
    if (!_parameter) {
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
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}




@end
