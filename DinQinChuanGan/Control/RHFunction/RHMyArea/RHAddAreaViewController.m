//
//  RHAddAreaViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/30.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAddAreaViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "Header.h"
#import "RHChoosePicViewController.h"

#define UploadImageBoundary @"KhTmLbOuNdArY0001KhTmLbOuNdArY0001"


@interface RHAddAreaViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *areaNameL;
@property (nonatomic, strong) UILabel *areaRatioL;
@property (nonatomic, strong) UILabel *bacImageL;
@property (nonatomic, strong) UITextField *nameT;
@property (nonatomic, strong) UITextField *ratioT;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIBarButtonItem *rightBI;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *photoIV;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *surverPara;
@property (nonatomic, strong) RHChoosePicViewController *chooseVC;
@property (nonatomic, copy) NSDictionary *aparagrams;
@property (nonatomic, copy) NSString *areaUrl;


@end

@implementation RHAddAreaViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - 处理视图布局/逻辑
- (void)layoutViews {
//    逻辑处理
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"添加区域";
    UIBarButtonItem *barBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(saveRequest)];
    UIBarButtonItem *backBI=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    barBI.tintColor=[UIColor lightGrayColor];
//    barBI.enabled=NO;
    barBI.tintColor=CONTROL_COLOR;
    self.rightBI=barBI;
    backBI.tintColor=CONTROL_COLOR;
    self.navigationItem.rightBarButtonItem=self.rightBI;
    self.navigationItem.backBarButtonItem=backBI;
    self.chooseVC=[RHChoosePicViewController new];
//    控件布局
    [self.view addSubview:self.areaNameL];
    [self.areaNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 15));
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(33);
    }];
    [self.view addSubview:self.nameT];
    [self.nameT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(59);
    }];
    [self.view addSubview:self.areaRatioL];
    [self.areaRatioL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 15));
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(133);
    }];
    [self.view addSubview:self.ratioT];
    [self.ratioT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(158);
    }];
    [self.view addSubview:self.bacImageL];
    [self.bacImageL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 15));
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(233);
    }];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 195));
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(271);
    }];
    [self.view addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 195));
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(271);
    }];
    [self.view addSubview:self.photoIV];
    [self.photoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 34));
        make.center.equalTo(self.maskView);
    }];
    [self.view addSubview:self.chooseBtn];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 195));
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(271);
    }];
}

#pragma mark - 功能
//UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.rightBI.enabled=YES;
    self.rightBI.tintColor=CONTROL_COLOR;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - chooseAction
- (void)chooseAction {
    __weak typeof(self) weakSelf=self;
    self.chooseVC.block = ^(UIImage *image) {
        weakSelf.imageView.image=image;
    };
    [self.navigationController pushViewController:self.chooseVC animated:YES];
    
    
}

#pragma mark - 上传图片.保存上传
- (void)saveRequest {
//    避免照片名字重复，用时间辅助命名
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyyy-MMdd-HH:mm:ss";
    NSString *str=[formatter stringFromDate:[NSDate date]];
//    把照片转化为数据流
    NSData *imageData=UIImageJPEGRepresentation(self.imageView.image, 1.0f);
    NSString *fileName=[NSString stringWithFormat:@"%@.jpeg",str];
    NSString *mimeType=@"image/jpg";
    if (imageData==nil) {
        imageData=UIImagePNGRepresentation(self.imageView.image);
        fileName=[NSString stringWithFormat:@"%@.png",str];
        mimeType=@"image/png";
    }
//    建立网络请求
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:ASSETSERVER_API parameters:self.aparagrams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        NSDictionary *returnDict=responseObject;
        NSInteger st=[returnDict[@"st"] integerValue];
        if (st == 0) {
            self.areaUrl=[NSString stringWithFormat:@"%@",returnDict[@"fileUrl"]];
            [self uploadRequest];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error--:%@",error);
    }];
    
}

//保存上传
- (void)uploadRequest {
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage POST:MANAGE_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        if (st == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error:%@",error);
    }];
}


#pragma mark - 控件初始化
- (UILabel *)areaNameL {
    if (!_areaNameL) {
        _areaNameL=[[UILabel alloc] init];
        _areaNameL.text=@"区域名";
    }
    return _areaNameL;
}

- (UILabel *)areaRatioL {
    if (!_areaRatioL) {
        _areaRatioL=[[UILabel alloc] init];
        _areaRatioL.text=@"面积(㎡)";
    }
    return _areaRatioL;
}

- (UILabel *)bacImageL {
    if (!_bacImageL) {
        _bacImageL=[[UILabel alloc] init];
        _bacImageL.text=@"墙纸";
    }
    return _bacImageL;
}

- (UITextField *)nameT {
    if (!_nameT) {
        _nameT=[[UITextField alloc] init];
        _nameT.clearButtonMode=UITextFieldViewModeWhileEditing;
        _nameT.placeholder=@"例如：部门/房间号";
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 41)];
        _nameT.leftView=view;
        _nameT.leftViewMode=UITextFieldViewModeAlways;
        _nameT.delegate=self;
    }
    return _nameT;
}

- (UITextField *)ratioT {
    if (!_ratioT) {
        _ratioT=[[UITextField alloc] init];
        _ratioT.clearButtonMode=UITextFieldViewModeWhileEditing;
        _ratioT.placeholder=@"120";
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 41)];
        _ratioT.leftView=view;
        _ratioT.leftViewMode=UITextFieldViewModeAlways;
        _ratioT.delegate=self;
    }
    return _ratioT;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
//        _imageView.image=[UIImage imageNamed:@"bacimage.jpeg"];
//       防止图片变形，作保持比例可裁剪填充
        _imageView.clipsToBounds=YES;
        _imageView.contentMode=UIViewContentModeScaleAspectFill;


    }
    return _imageView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView=[UIView new];
        _maskView.alpha=0.3;
        _maskView.backgroundColor=[UIColor blackColor];
    }
    return _maskView;
}

- (UIImageView *)photoIV {
    if (!_photoIV) {
        _photoIV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo"]];
        
    }
    return _photoIV;
}

- (UIButton *)chooseBtn {
    if (!_chooseBtn) {
        _chooseBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_chooseBtn addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}

//图片上传参数
- (NSDictionary *)aparagrams {
    if (!_aparagrams) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *userId=[user objectForKey:@"userId"];
        
        NSDictionary *dict=@{@"userId": userId, @"fileType":@0, @"file":@""};
        
        _aparagrams=dict;

    }
    return _aparagrams;
}

- (NSString *)parameter {
    if (!_parameter) {
//        图片转string后作为参数上传
        
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30002,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{
                            @"placeId": @(self.placeId),
                            @"areaName": self.nameT.text,
                            @"areaPicture": self.areaUrl,
                            @"area": self.ratioT.text,
                            @"areaId": @0
                            };

        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",_parameter);
    }
    return _parameter;
}

@end
