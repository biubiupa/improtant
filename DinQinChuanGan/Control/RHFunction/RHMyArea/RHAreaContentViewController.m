//
//  RHAreaContentViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/2/1.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAreaContentViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "RHChoosePicViewController.h"
#import "UIImageView+WebCache.m"
#import "RHMoveToViewController.h"
#import "RHDeleteAreaEquipViewController.h"

@interface RHAreaContentViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UILabel *ratioLabel;
@property (nonatomic, strong) UILabel *equipLabel;
@property (nonatomic, strong) UILabel *wallpaperL;
@property (nonatomic, strong) UITextField *areaTF;
@property (nonatomic, strong) UITextField *ratioTF;
@property (nonatomic, strong) UITextField *equipTF;
@property (nonatomic, strong) UITextField *moveTF;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UIButton *moveBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *doneParameter;
@property (nonatomic, strong) UIBarButtonItem *rightBI;
@property (nonatomic, copy) NSDictionary *surverPara;
@property (nonatomic, copy) NSString *areauUrl;
@property (nonatomic, strong) UILabel *moveLabel;

@end

@implementation RHAreaContentViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDefaultImg:) name:@"imgurl" object:nil];
}

#pragma mark - 控件，视图处理
- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=self.titleN;
    UIBarButtonItem *backBI=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
    backBI.tintColor=CONTROL_COLOR;
    self.navigationItem.backBarButtonItem=backBI;
    self.navigationItem.rightBarButtonItem=self.rightBI;
    
//    添加控件,布局
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.areaLabel];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.left.equalTo(self.scrollView).with.offset(16);
        make.top.equalTo(self.scrollView).with.offset(33);
    }];
    [self.scrollView addSubview:self.areaTF];
    [self.areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).with.offset(59);
    }];
    //    区域面积
    [self.scrollView addSubview:self.ratioLabel];
    [self.ratioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 15));
        make.left.equalTo(self.scrollView).with.offset(16);
        make.top.equalTo(self.scrollView).with.offset(133);
    }];
    [self.scrollView addSubview:self.ratioTF];
    [self.ratioTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).with.offset(158);
    }];
    //    设备
    [self.scrollView addSubview:self.equipLabel];
    [self.equipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 15));
        make.left.equalTo(self.scrollView).with.offset(16);
        make.top.equalTo(self.scrollView).with.offset(233);
    }];
    [self.scrollView addSubview:self.equipTF];
    [self.equipTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 41));
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).with.offset(260);
    }];
//    墙纸
    [self.scrollView addSubview:self.wallpaperL];
    [self.wallpaperL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 15));
        make.left.equalTo(self.scrollView).with.offset(16);
        make.top.equalTo(self.equipTF).with.offset(75);
    }];
    [self.scrollView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-32, 195));
        make.top.equalTo(self.scrollView).with.offset(372);
        make.left.equalTo(self.scrollView).with.offset(16);
    }];
    [self.scrollView addSubview:self.chooseBtn];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-32, 195));
        make.top.equalTo(self.scrollView).with.offset(372);
        make.left.equalTo(self.scrollView).with.offset(16);
    }];
//    移动到...
    [self.scrollView addSubview:self.moveTF];
    [self.moveTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 33));
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).with.offset(602);
    }];
    [self.scrollView addSubview:self.moveBtn];
    [self.moveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 33));
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).with.offset(602);
    }];
    [self.scrollView addSubview:self.moveLabel];
    [self.moveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 16, 33));
        make.top.equalTo(self.scrollView).with.offset(602);
        make.left.equalTo(self.scrollView).with.offset(0);
    }];
//    删除区域
    [self.scrollView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 45));
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).with.offset(665);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.rightBI.tintColor=CONTROL_COLOR;
    self.rightBI.enabled=YES;
    
    return YES;
}

#pragma mark - 更换背景/移动区域/删除区域/编辑保存
//更换为默认背景
- (void)changeDefaultImg:(NSNotification *)notification {
    NSString *urlString=notification.userInfo[@"imgurl"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.rightBI.tintColor=CONTROL_COLOR;
    self.rightBI.enabled=YES;
}

//更换背景
- (void)changeBacImage {
    __weak typeof(self) weakSelf=self;
    RHChoosePicViewController *chooseVC=[RHChoosePicViewController new];
    chooseVC.block = ^(UIImage *image) {
        weakSelf.imageView.image=image;
        self.rightBI.tintColor=CONTROL_COLOR;
        self.rightBI.enabled=YES;
    };
    
    [self.navigationController pushViewController:chooseVC animated:YES];
}

//移动区域
- (void)moveToPlace {
    RHMoveToViewController *moveVC=[RHMoveToViewController new];
    __weak typeof(self) weakSelf=self;
    moveVC.block = ^(NSString *placeName, NSInteger placeId) {
        weakSelf.moveLabel.text=placeName;
//        判断是否是移动区域
        if (weakSelf.moveLabel.text != nil) {
            self.placeId=placeId;
            self.rightBI.tintColor=DEFAULTCOLOR;
            self.rightBI.enabled=YES;
        }
        
    };
    [self.navigationController pushViewController:moveVC animated:YES];
}

//删除区域
- (void)deleteAreaRequest {
//    设备为0台，可以直接删除设备
    
    if ([self.equipTF.text intValue] == 0) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"确认删除该区域" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self httpRequest];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
//        有设备，先删除设备
    }else {
        RHDeleteAreaEquipViewController *areaEquipVC=[RHDeleteAreaEquipViewController new];
        __weak typeof(self) weakSelf=self;
        areaEquipVC.backBlock = ^(NSString *zeroStr) {
            weakSelf.equipTF.text=zeroStr;
        };
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"移除所有设备才可删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            areaEquipVC.itemTitle=self.titleN;
            areaEquipVC.areaId=self.areaId;
            [self.navigationController pushViewController:areaEquipVC animated:YES];
            
        }]];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    
}
//删除区域事件
- (void)httpRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===error:%@",error);
    }];
}


//上传图片至资源服务器
- (void)surverRequest {
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyyyMMddHHmmSS";
    NSString *str=[formatter stringFromDate:[NSDate date]];
    NSData *imageData=UIImageJPEGRepresentation(self.imageView.image, 1.0f);
    NSString *fileName=[NSString stringWithFormat:@"%@.jpeg",str];
    NSString *mineType=@"image/jpg";
    if (imageData == nil) {
        imageData=UIImagePNGRepresentation(self.imageView.image);
        fileName=[NSString stringWithFormat:@"%@.png",str];
        mineType=@"image/png";
    }
    
    AFHTTPSessionManager *mange=[AFHTTPSessionManager manager];
    [mange POST:ASSETSERVER_API parameters:self.surverPara constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:mineType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        NSInteger st=[responseObject[@"status"] integerValue];
        if (st == 0) {
            self.areauUrl=[NSString stringWithFormat:@"%@",responseObject[@"fileUrl"]];
            [self upload];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}
//编辑后，保存上传
- (void)upload {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.doneParameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        NSInteger st=[responseObject[@"head"][@"st"] integerValue];
        if (st == 0) {

            [self.navigationController popViewControllerAnimated:YES];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===error:%@",error);
    }];
}
#pragma mark - 初始化
- (UIScrollView  *)scrollView {
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 810);
        _scrollView.delegate=self;
        _scrollView.bounces=YES;
        _scrollView.showsVerticalScrollIndicator=NO;
    }
    return _scrollView;
}

- (UILabel *)areaLabel {
    if (!_areaLabel) {
        _areaLabel=[[UILabel alloc] init];
        _areaLabel.text=@"区域名";
    }
    return _areaLabel;
}

- (UILabel *)ratioLabel {
    if (!_ratioLabel) {
        _ratioLabel=[[UILabel alloc] init];
        _ratioLabel.text=@"面积(㎡)";
    }
    return _ratioLabel;
}

- (UILabel *)equipLabel {
    if (!_equipLabel) {
        _equipLabel=[[UILabel alloc] init];
        _equipLabel.text=@"设备(台)";
    }
    return _equipLabel;
}

- (UILabel *)wallpaperL {
    if (!_wallpaperL) {
        _wallpaperL=[[UILabel alloc] init];
        _wallpaperL.text=@"墙纸";
    }
    return _wallpaperL;
}

- (UITextField *)areaTF {
    if (!_areaTF) {
        _areaTF=[[UITextField alloc] init];
        _areaTF.backgroundColor=[UIColor whiteColor];
        _areaTF.placeholder=@"例如：部门/房间号";
//        _placeTF.text=self.placeName;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 41)];
        _areaTF.leftView=view;
        _areaTF.leftViewMode=UITextFieldViewModeAlways;
        _areaTF.text=self.areaName;
        _areaTF.delegate=self;
    }
    return _areaTF;
}

- (UITextField *)ratioTF {
    if (!_ratioTF) {
        _ratioTF=[[UITextField alloc] init];
        _ratioTF.backgroundColor=[UIColor whiteColor];
        _ratioTF.placeholder=@"0";
//        _ratioTF.text=[NSString stringWithFormat:@"%ld",self.placeArea];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 41)];
        _ratioTF.leftView=view;
        _ratioTF.leftViewMode=UITextFieldViewModeAlways;
        _ratioTF.text=self.ratio;
        _ratioTF.delegate=self;
    }
    return _ratioTF;
}

- (UITextField *)equipTF {
    if (!_equipTF) {
        _equipTF=[[UITextField alloc] init];
        _equipTF.backgroundColor=[UIColor whiteColor];
        _equipTF.placeholder=@"0";
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 41)];
        _equipTF.leftView=view;
        _equipTF.enabled=NO;
        _equipTF.leftViewMode=UITextFieldViewModeAlways;
        _equipTF.text=self.equipName;
    }
    return _equipTF;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
        _imageView.clipsToBounds=YES;
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        if (self.imgUrl) {
            [_imageView sd_setImageWithURL:self.imgUrl];
        }
    }
    return _imageView;
}

- (UIButton *)chooseBtn {
    if (!_chooseBtn) {
        _chooseBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_chooseBtn addTarget:self action:@selector(changeBacImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}
//移动到...
- (UITextField *)moveTF {
    if (!_moveTF) {
        _moveTF=[[UITextField alloc] init];
        _moveTF.text=@"移动到...";
        _moveTF.enabled=NO;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 41)];
        _moveTF.leftView=view;
        _moveTF.leftViewMode=UITextFieldViewModeAlways;
        _moveTF.backgroundColor=[UIColor whiteColor];
    }
    return _moveTF;
}

- (UIButton *)moveBtn {
    if (!_moveBtn) {
        _moveBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_moveBtn addTarget:self action:@selector(moveToPlace) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moveBtn;
}

//删除区域
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _deleteBtn.layer.cornerRadius=22;
        _deleteBtn.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:47.0/255.0 blue:85.0/255.0 alpha:1.0];
        [_deleteBtn setTitle:@"删除区域" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAreaRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

//右BI
- (UIBarButtonItem *)rightBI {
    if (!_rightBI) {
        _rightBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(surverRequest)];
        _rightBI.enabled=NO;
        _rightBI.tintColor=[UIColor lightGrayColor];
    }
    return _rightBI;
}

//移动到显示label
- (UILabel *)moveLabel {
    if (!_moveLabel) {
        _moveLabel=[[UILabel  alloc] init];
        _moveLabel.textAlignment=NSTextAlignmentRight;
    }
    return _moveLabel;
}

//删除区域参数
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
                             @"cmd": @30007,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"areaId":@(self.areaId)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

//修改区域参数
- (NSString *)doneParameter {
    if (!_doneParameter) {
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
                            @"areaName": self.areaTF.text,
                            @"areaPicture": self.areauUrl,
                            @"area": self.ratioTF.text,
                            @"areaId": @(self.areaId)
                            };
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _doneParameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _doneParameter;
}

//上传图片参数(至资源服务器)
- (NSDictionary *)surverPara {
    if (!_surverPara) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *userId=[user objectForKey:@"userId"];
        
        _surverPara=@{@"userId": userId, @"fileType":@0, @"file":@""};
    }
    return _surverPara;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"imgurl" object:nil];
}



@end
