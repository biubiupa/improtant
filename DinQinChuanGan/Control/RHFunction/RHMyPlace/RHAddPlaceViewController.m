//
//  RHAddPlaceViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/12.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAddPlaceViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "AFNetworking.h"


@interface RHAddPlaceViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIBarButtonItem *rightBI;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UIView *placeView;
@property (nonatomic, strong) UIView *areaView;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *areaTF;
@property (nonatomic, copy) NSString *parameter;

@end

@implementation RHAddPlaceViewController

#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    
}

//layoutviews
- (void)layoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"添加场所";
    self.navigationItem.rightBarButtonItem=self.rightBI;
    [self.view addSubview:self.placeLabel];
//    场所相关
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 15));
        make.left.equalTo(self.view).with.offset(16);
        make.top.equalTo(self.view).with.offset(31);
    }];
    [self.view addSubview:self.placeView];
    [self.placeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(60);
    }];
    [self.placeView addSubview:self.nameTF];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.centerY.equalTo(self.placeView);
        make.left.equalTo(self.placeView).with.offset(16);
    }];
//    面积相关
    [self.view addSubview:self.areaLabel];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 15));
        make.left.equalTo(self.view).with.offset(16);
        make.top.equalTo(self.placeView).with.offset(72);
    }];
    [self.view addSubview:self.areaView];
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.areaLabel).with.offset(29);
    }];
    [self.areaView addSubview:self.areaTF];
    [self.areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.centerY.equalTo(self.areaView);
        make.left.equalTo(self.areaView).with.offset(16);
    }];
    
}
#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//保存上传
- (void)actionBack {
    NSString *urlString=MANAGE_API;
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:urlString parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"---%@",responseObject);
//        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        [self.navigationController popViewControllerAnimated:YES];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===%@",error);
    }];    
}

#pragma mark - lazyLoad

- (UIBarButtonItem *)rightBI {
    if (!_rightBI) {
        _rightBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(actionBack)];
    }
    return _rightBI;
}

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
                            @"placeName":self.nameTF.text,
                            @"placeUrl": @"",
                            @"placeId":@(0),
                            @"placeArea":self.areaTF.text
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSLog(@"%@",dict);
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

//场所名称

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel=[[UILabel alloc] init];
        _placeLabel.text=@"场所名";
    }
    return _placeLabel;
}

- (UIView *)placeView {
    if (!_placeView) {
        _placeView=[[UIView alloc] init];
        _placeView.backgroundColor=[UIColor whiteColor];
    }
    return _placeView;
}

- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF=[[UITextField alloc] init];
        _nameTF.delegate=self;
        _nameTF.placeholder=@"公司";
        _nameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _nameTF;
}
//面积
- (UILabel *)areaLabel {
    if (!_areaLabel) {
        _areaLabel=[[UILabel alloc] init];
        _areaLabel.text=@"面积(㎡)";
    }
    return _areaLabel;
}

- (UIView *)areaView {
    if (!_areaView) {
        _areaView=[[UIView alloc] init];
        _areaView.backgroundColor=[UIColor whiteColor];
    }
    return _areaView;
}

- (UITextField *)areaTF {
    if (!_areaTF) {
        _areaTF=[[UITextField alloc] init];
        _areaTF.delegate=self;
        _areaTF.placeholder=@"0";
        _areaTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _areaTF;
}



//  done

//

@end
