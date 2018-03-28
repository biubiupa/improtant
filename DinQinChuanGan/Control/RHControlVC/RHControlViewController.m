//
//  ControlViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/14.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "RHControlViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WRNavigationBar.h"
#import "WRCustomNavigationBar.h"
#import "ControlTableViewCell.h"
#import "RHRightBarButtonItemViewController.h"
#import "RHSignInViewController.h"
#import "RHMyPlaceViewController.h"
#import "RHMyAreaViewController.h"
#import "RHMyEquipmentViewController.h"
#import "RHJudgeMethod.h"

#define CONTROL_COLOR [UIColor colorWithRed:114.0/255.0 green:132.0/255.0 blue:235.0/255.0 alpha:1.0]

@interface RHControlViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) BOOL Hidden;
@property (nonatomic, assign) BOOL lowHidden;
@property (nonatomic, strong) ControlTableViewCell *cellTwo;
@property (nonatomic, strong) RHMyAreaViewController *areaVC;
@property (nonatomic, strong) RHMyPlaceViewController *placeVC;
//@property (nonatomic, strong) RHRightBarButtonItemViewController *setVC;
@property (nonatomic, strong) RHMyEquipmentViewController *equipmentVC;
@property (nonatomic, copy) NSString *paraPlace;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, copy) NSDictionary *surverPara;
@property (nonatomic, strong) UIImage *editedImage;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *reviseAccPara;
@property (nonatomic, copy) NSString *userPicture;

@end

@implementation RHControlViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSignIn:) name:@"change" object:nil];
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaozhuan:) name:@"tiaozhuan" object:nil];
}

//处理布局
- (void)layoutViews {
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.topView];
    [self.topView addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.topView).with.insets(UIEdgeInsetsMake(12, 12, 0, 12));
    }];
    self.tableView.tableHeaderView=self.topView;
    
    
    [self setNavigationBar];
    [self.backgroundView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62, 62));
        make.top.equalTo(self.backgroundView).with.offset(19);
        make.centerX.equalTo(self.backgroundView);
    }];
    [self.backgroundView addSubview:self.iconBtn];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62, 62));
        make.top.equalTo(self.backgroundView).with.offset(19);
        make.centerX.equalTo(self.backgroundView);
    }];
    //    帐号
    [self.backgroundView addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(148, 16));
        make.centerX.equalTo(self.backgroundView);
        make.bottom.equalTo(self.iconView).with.offset(32);
    }];
    //    企业编号
    [self.backgroundView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 16));
        make.centerX.equalTo(self.iconView);
        make.bottom.equalTo(self.iconView).with.offset(55);
    }];
    //    登录提示语
    [self.backgroundView addSubview:self.signInLabel];
    [self.signInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230, 17));
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView).with.offset(45);
    }];
    //    登录按钮
    [self.backgroundView addSubview:self.signInBtn];
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(109, 31));
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.self.signInLabel).with.offset(41);
    }];
    [_signInBtn addTarget:self action:@selector(signInAcction) forControlEvents:UIControlEventTouchUpInside];
    self.iconView.hidden=YES;
    self.accountLabel.hidden=YES;
    self.numberLabel.hidden=YES;

}
//设置导航栏属性
#pragma mark - 导航栏属性
- (void)setNavigationBar {
    //左右buttonitem
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(rightbtnAction)];
    //    rightBI.tintColor=CONTROL_COLOR;
    UIBarButtonItem *leftBI=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qrcode"] style:UIBarButtonItemStylePlain target:self action:nil];
    //    leftBI.tintColor=CONTROL_COLOR;
    self.navigationItem.rightBarButtonItem=rightBI;
    self.navigationItem.leftBarButtonItem=leftBI;
    //    [self wr_setNavBarBackgroundAlpha:0];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.title=@"管理";
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - delegate / datasorce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cellTwo=[ControlTableViewCell new];
    return self.cellTwo;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 450.0;
}



#pragma mark - 事件处理
//右BBI点击进入设置界面
- (void)rightbtnAction {
    if (UserId) {
        self.navigationItem.backBarButtonItem=[RHJudgeMethod creatBBIWithTitle:@"返回" Color:CONTROL_COLOR];
        RHRightBarButtonItemViewController *setVC=[RHRightBarButtonItemViewController new];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

 //登录
- (void)signInAcction {
    RHSignInViewController *rhVC=[RHSignInViewController new];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:rhVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
//接收通知后改变header view的布局视图
- (void)changeSignIn:(NSNotification *)notification {
    NSDictionary *dict=notification.userInfo;
    BOOL hiden=[dict[@"Hiden"] boolValue];
    NSString *account=dict[@"account"];
    NSString *corporationNum=dict[@"corporationNum"];
    self.userPicture=dict[@"userPicture"];
    NSURL *imgUrl=[NSURL URLWithString:self.userPicture];
    self.signInLabel.hidden=!hiden;
    self.signInBtn.hidden=!hiden;
    self.iconView.hidden=hiden;
    self.accountLabel.hidden=hiden;
    self.numberLabel.hidden=hiden;
    self.accountLabel.text=[NSString stringWithFormat:@"帐号%@",account];
    self.numberLabel.text=[NSString stringWithFormat:@"企业编号%@",corporationNum];
    self.iconBtn.enabled=YES;
    [self.iconView sd_setImageWithURL:imgUrl];
}
//    点击item跳转
- (void)tiaozhuan:(NSNotification *)notification {
    self.navigationItem.backBarButtonItem=[RHJudgeMethod creatBBIWithTitle:@"返回" Color:CONTROL_COLOR];
    
    RHMyAreaViewController *areaVC=[RHMyAreaViewController new];
    RHMyPlaceViewController *placeVC=[RHMyPlaceViewController new];
    
    self.equipmentVC=[RHMyEquipmentViewController new];
    self.areaVC=areaVC;
    self.placeVC=placeVC;
    
    NSDictionary *dict=notification.userInfo;
    int index=[dict[@"index"] intValue];
    self.arr=@[self.placeVC, self.areaVC, self.equipmentVC];
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    self.userId=[userDef stringForKey:@"userId"];
    if (self.userId) {
        if (index == 2) {
            [self placeRequest];
        }else {
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:self.arr[index] animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
    }else {
        NSLog(@"请先登录！！！");
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tiaozhuan" object:nil];
    
}

//自定义头像
- (void)changeIconImage {
    UIImagePickerController *imagePC=[[UIImagePickerController alloc] init];
    imagePC.delegate=self;
    imagePC.allowsEditing=YES;
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        确定sourcetype为相机
        if ([self isFrontCameraAvailable] || [self isRearCameraAvailable]) {
            imagePC.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePC animated:YES completion:nil];
        }else {
            NSLog(@"相机不可用!");
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePC animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//判断相机是否可用
- (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//取消拍照
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//确认编辑
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage=[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *original=[info objectForKey:UIImagePickerControllerOriginalImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(original, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
    self.editedImage=editedImage;
    [self uploadFile];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        NSLog(@"成功保存图片");
    }
    else{
        ///图片未能保存到本地
    }
}

//上传图片之资源服务器
- (void)uploadFile {
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyyyMMddHHmmSS";
    NSString *str=[formatter stringFromDate:[NSDate date]];
    NSData *imageData=UIImageJPEGRepresentation(self.editedImage, 1.0f);
    NSString *fileName=[NSString stringWithFormat:@"%@.jpeg",str];
    NSString *mineType=@"image/jpg";
    if (imageData == nil) {
        imageData=UIImagePNGRepresentation(self.editedImage);
        fileName=[NSString stringWithFormat:@"%@.png",str];
        mineType=@"image/png";
    }
    
    AFHTTPSessionManager *mange=[AFHTTPSessionManager manager];
    [mange POST:ASSETSERVER_API parameters:self.surverPara constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:mineType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.imageUrl=[NSString stringWithFormat:@"%@",responseObject[@"fileUrl"]];
            self.iconView.image=self.editedImage;
            [self reviseAccImageRequest];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

//把上传的图片和用户ID绑定修改上传
- (void)reviseAccImageRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:USER_API parameters:self.reviseAccPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            NSLog(@"修改成功");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
}


#pragma mark - 请求场所列表

- (void)placeRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.paraPlace progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *listArr=responseObject[@"body"][@"list"];
        self.equipmentVC.listArr=listArr;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:self.arr[2] animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:----%@",error);
    }];
}

#pragma mark - 设置头视图
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.estimatedRowHeight=44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (UIView *)topView {
    if (!_topView) {
        //        _topView=[[UIView alloc] init];
        _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 184)];
        _topView.backgroundColor=BACKGROUND_COLOR;
    }
    return _topView;
    
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc] init];
        //        _backgroundView.bounds=CGRectMake(0, 0, self.view.frame.size.width-24, 172);
        _backgroundView.backgroundColor=[UIColor whiteColor];
    }
    return _backgroundView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView=[[UIImageView alloc] init];
        _iconView.bounds=CGRectMake(0, 0, 62, 62);
        _iconView.image=[UIImage imageNamed:@"cat.jpg"];
        _iconView.layer.masksToBounds=YES;
        _iconView.layer.cornerRadius=31;
    }
    return _iconView;
    
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel=[[UILabel alloc] init];
        _accountLabel.text=@"账号:----------";
        _accountLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _accountLabel;
    
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel=[[UILabel alloc] init];
        _numberLabel.text=@"企业编号:------";
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        _numberLabel.textColor=[UIColor lightGrayColor];
        _numberLabel.font=[UIFont systemFontOfSize:14];
    }
    return _numberLabel;
}
//欢迎语label初始化
- (UILabel *)signInLabel {
    if (!_signInLabel) {
        _signInLabel=[[UILabel alloc] init];
        _signInLabel.text=@"登录AirBoB，成为环保主义者";
        _signInLabel.textColor=[UIColor lightGrayColor];
        _signInLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _signInLabel;
}
//button初始化
- (UIButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_signInBtn setTitle:@"登录" forState:UIControlStateNormal];
        _signInBtn.layer.borderWidth=1;
        _signInBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _signInBtn.layer.cornerRadius=15;
        [_signInBtn setTintColor:[UIColor lightGrayColor]];
        
    }
    return _signInBtn;
}

//自定义头像按钮
- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _iconBtn.layer.cornerRadius=31;
        _iconBtn.enabled=NO;
        [_iconBtn addTarget:self action:@selector(changeIconImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtn;
}

//场所请求参数
- (NSString *)paraPlace {
    if (!_paraPlace) {
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @30003,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"userId": self.userId};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _paraPlace=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _paraPlace;
}

//上传资源服务器参数
- (NSDictionary *)surverPara {
    if (!_surverPara) {
        NSInteger userId=[UserId integerValue];
        _surverPara=@{@"userId":@(userId), @"fileType":@0, @"file":@""};
    }
    return _surverPara;
}

//修改用户信息(参数)
- (NSString *)reviseAccPara {
        NSInteger userId=[UserId integerValue];
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-07-13 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @10007,
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"userId": @(userId),@"userPicture": self.imageUrl};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _reviseAccPara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return _reviseAccPara;
}





- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"change" object:nil];
    
}

@end
