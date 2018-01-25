//
//  RHPlaceMessageViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/19.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHPlaceMessageViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "AFNetworking.h"

@interface RHPlaceMessageViewController ()
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *equipLabel;
@property (nonatomic, strong) UITextField *placeTF;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UITextField *equipTF;
@property (nonatomic, strong) UIBarButtonItem *rightBI;
@property (nonatomic, copy) NSString *parameter;


@end

@implementation RHPlaceMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - layoutViews
- (void)layoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.rightBarButtonItem=self.rightBI;
    self.navigationItem.title=self.title;
//    场所名称
    [self.view addSubview:self.placeLabel];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 15));
        make.left.equalTo(self.view).with.offset(16);
        make.top.equalTo(self.view).with.offset(33);
    }];
    [self.view addSubview:self.placeTF];
    [self.placeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(59);
    }];
//    场所面积
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 15));
        make.left.equalTo(self.view).with.offset(16);
        make.top.equalTo(self.view).with.offset(133);
    }];
    [self.view addSubview:self.contentTF];
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(158);
    }];
//    设备
    [self.view addSubview:self.equipLabel];
    [self.equipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 15));
        make.left.equalTo(self.view).with.offset(16);
        make.top.equalTo(self.view).with.offset(233);
    }];
    [self.view addSubview:self.equipTF];
    [self.equipTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(260);
    }];
    
}

#pragma mark - 储存上传
- (void)upload {
    NSString *urlString=MANAGE_API;
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:urlString parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"---%@",responseObject);
        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        if (st == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===%@",error);
    }];
}


#pragma mark - 控件初始化
//控件

- (NSString *)parameter {
    if (!_parameter) {
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        NSString *userId=[userDefault stringForKey:@"userId"];
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @"1",
                             @"uuid": @"188111",
                             @"cmd": @"30001",
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"userId":userId,
                            @"placeName":self.placeTF.text,
                            @"placeUrl": @"",
                            @"placeId":@(self.placeId),
                            @"placeArea":self.contentTF.text
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSLog(@"%@",dict);
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

- (UIBarButtonItem *)rightBI {
    if (!_rightBI) {
        _rightBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(upload)];
    }
    return _rightBI;
}

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel=[[UILabel alloc] init];
        _placeLabel.text=@"场所";
    }
    return _placeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc] init];
        _contentLabel.text=@"面积(㎡)";
    }
    return _contentLabel;
}

- (UILabel *)equipLabel {
    if (!_equipLabel) {
        _equipLabel=[[UILabel alloc] init];
        _equipLabel.text=@"设备(台)";
    }
    return _equipLabel;
}

- (UITextField *)placeTF {
    if (!_placeTF) {
        _placeTF=[[UITextField alloc] init];
        _placeTF.backgroundColor=[UIColor whiteColor];
        _placeTF.placeholder=@"例如：公司 / 学校 / 医院";
        _placeTF.text=self.placeName;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 41)];
        _placeTF.leftView=view;
        _placeTF.leftViewMode=UITextFieldViewModeAlways;
    }
    return _placeTF;
}

- (UITextField *)contentTF {
    if (!_contentTF) {
        _contentTF=[[UITextField alloc] init];
        _contentTF.backgroundColor=[UIColor whiteColor];
        _contentTF.placeholder=@"0";
        _contentTF.text=[NSString stringWithFormat:@"%ld",self.placeArea];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 41)];
        _contentTF.leftView=view;
        _contentTF.leftViewMode=UITextFieldViewModeAlways;
    }
    return _contentTF;
}

- (UITextField *)equipTF {
    if (!_equipTF) {
        _equipTF=[[UITextField alloc] init];
        _equipTF.backgroundColor=[UIColor whiteColor];
        _equipTF.placeholder=@"0";
        _equipTF.text=[NSString stringWithFormat:@"%ld",self.deviceNum];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 41)];
        _equipTF.leftView=view;
        _equipTF.enabled=NO;
        _equipTF.leftViewMode=UITextFieldViewModeAlways;
    }
    return _equipTF;
}

@end