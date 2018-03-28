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
#import "RHDeletePEViewController.h"
#import "RHJudgeMethod.h"

@interface RHPlaceMessageViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *equipLabel;
@property (nonatomic, strong) UITextField *placeTF;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UITextField *equipTF;
@property (nonatomic, strong) UIBarButtonItem *rightBI;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *deParameter;


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
    self.navigationItem.title=self.titles;
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
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 45));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-118);
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

#pragma mark - 删除场所事件
- (void)deletePlace {
    if ([self.equipTF.text integerValue] == 0) {
        
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"确认删除该场所" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            设备数为0，执行删除操作
            [self deleteRequest];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else {
        RHDeletePEViewController *placeEquipVC=[RHDeletePEViewController new];
        __weak typeof(self) weakSelf=self;
        placeEquipVC.placeBlock = ^(NSString *string) {
            weakSelf.equipTF.text=string;
        };
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"移除所有设备才可删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            设备不为0，先删除该场所下所有设备
            self.navigationItem.backBarButtonItem=[RHJudgeMethod creatBBIWithTitle:@"取消" Color:CONTROL_COLOR];
            
            
            placeEquipVC.placeId=self.placeId;
            placeEquipVC.stringTitle=self.titles;
            [self.navigationController pushViewController:placeEquipVC animated:YES];
            
        }]];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    
}

#pragma mark - 请求删除场所
- (void)deleteRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.deParameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *st=[NSString stringWithFormat:@"%@",responseObject[@"head"][@"st"]];
        if ([st integerValue] == 0) {
            NSLog(@"%@",responseObject);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--error:%@",error);
    }];
}

#pragma mark - uitextfield代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.rightBI.tintColor=CONTROL_COLOR;
    self.rightBI.enabled=YES;
    return YES;
}

#pragma mark - 控件初始化
//控件

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _deleteBtn.layer.cornerRadius=22;
        _deleteBtn.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:47.0/255.0 blue:85.0/255.0 alpha:1.0];
        [_deleteBtn setTitle:@"删除场所" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deletePlace) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
//场所详情参数
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

//删除场所参数
- (NSString *)deParameter  {
    if (!_deParameter) {
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30008,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"placeId": @(self.placeId)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _deParameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _deParameter;
}

- (UIBarButtonItem *)rightBI {
    if (!_rightBI) {
        _rightBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(upload)];
        _rightBI.tintColor=LightGrayColor;
        _rightBI.enabled=NO;
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
        _placeTF.delegate=self;
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
        _contentTF.delegate=self;
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
