//
//  RHEquipMessageViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/2.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHEquipMessageViewController.h"
#import "RHJudgeMethod.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "Header.h"
#import "RHEquipStandardViewController.h"
#import "RHSenAndMeaViewController.h"
#import "RHMoveOneStepViewController.h"

@interface RHEquipMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *equipText;
@property (nonatomic, strong) UILabel *equipNum;
@property (nonatomic, strong) UILabel *statu;
@property (nonatomic, strong) UILabel *describe;
@property (nonatomic, copy) NSArray *arrAll;
@property (nonatomic, copy) NSArray *arrZero;
@property (nonatomic, copy) NSArray *arrOne;
@property (nonatomic, copy) NSArray *arrTwo;
@property (nonatomic, copy) NSArray *arrThree;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, copy) NSArray *sectionTitle;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIImageView *lastImgView;
@property (nonatomic, strong) UILabel *lastLabel;
@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, strong) UIButton *deletBtn;
@property (nonatomic, strong) UIButton *moveBtn;
@property (nonatomic, strong) UILabel *moveLabel;
@property (nonatomic, strong) UILabel *moveTolabel;
@property (nonatomic, strong) UIImageView *moveImgView;
@property (nonatomic, copy) NSString *deletePara;
@property (nonatomic, copy) NSString *placePara;
@property (nonatomic, assign) NSInteger areaId;
@property (nonatomic, copy) NSString *movePara;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *dayLabel;


@end

@implementation RHEquipMessageViewController

static NSString *identifier=@"cell";


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveAction:) name:@"moveEquipment" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.totalArr=@[self.basiclistArr, self.spelistArr, self.acclistArr];
    [self.tableView reloadData];
}

#pragma mark - 处理GUI
- (void)layoutViews {
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"设备";
    UIBarButtonItem *rightBBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    rightBBI.tintColor=LightGrayColor;
    rightBBI.enabled=NO;
    self.navigationItem.rightBarButtonItem=rightBBI;
    
    [self.view addSubview:self.tableView];
//    尾视图
    self.tableView.tableFooterView=self.footerView;
    [self.footerView addSubview:self.lastBtn];
    [self.footerView addSubview:self.deletBtn];
    [self.lastBtn addSubview:self.lastLabel];
    [self.lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 21));
        make.centerY.equalTo(self.lastBtn);
        make.left.equalTo(self.lastBtn).with.offset(20);
    }];
    [self.lastBtn addSubview:self.lastImgView];
    [self.lastImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 19));
        make.centerY.equalTo(self.lastBtn);
        make.right.equalTo(self.lastBtn).with.offset(-20);
    }];
    [self.footerView addSubview:self.moveBtn];
    [self.moveBtn addSubview:self.moveLabel];
    [self.moveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 41));
        make.centerY.equalTo(self.moveBtn);
        make.left.equalTo(self.moveBtn).with.offset(20);
    }];
    
    [self.moveBtn addSubview:self.moveImgView];
    [self.moveImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 19));
        make.centerY.equalTo(self.moveBtn);
        make.right.equalTo(self.moveBtn).with.offset(-20);
    }];
    [self.moveBtn addSubview:self.moveTolabel];
    [self.moveTolabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 41));
        make.centerY.equalTo(self.moveBtn);
        make.right.equalTo(self.moveImgView).with.offset(-15);
    }];
    [self.deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 45));
        make.centerX.equalTo(self.footerView);
        make.bottom.equalTo(self.footerView).with.offset(-70);
    }];
//    头视图
    self.tableView.tableHeaderView=self.bacView;
    //    根据设备状态改变相应空间显示
    if (self.state == 1) {
        self.statu.text=@"在线";
        self.bacView.backgroundColor=WhiteColor;
        self.describe.text=[NSString stringWithFormat:@"已为您续航%@天",self.numberDaty];
        self.describe.hidden=NO;
        [self.bacView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bacView).with.insets(UIEdgeInsetsMake(7, 8, 7, 8));
        }];
    }else {
        self.statu.text=@"离线";
        self.describe.hidden=YES;
        self.bacView.backgroundColor=[UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0f];
    }
    [self.bacView addSubview:self.equipText];
    [self.equipText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 17));
        make.left.equalTo(self.bacView).with.offset(22);
        make.top.equalTo(self.bacView).with.offset(34);
    }];
    [self.bacView addSubview:self.equipNum];
    [self.equipNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 17));
        make.left.equalTo(self.bacView).with.offset(22);
        make.top.equalTo(self.bacView).with.offset(55);
    }];
    [self.bacView addSubview:self.statu];
    [self.statu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(76, 30));
        make.right.equalTo(self.bacView).with.offset(-28);
        make.top.equalTo(self.bacView).with.offset(28);
    }];
    [self.bacView addSubview:self.describe];
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 13));
        make.right.equalTo(self.bacView).with.offset(-17);
        make.top.equalTo(self.bacView).with.offset(67);
    }];
    self.arrAll=@[self.arrZero, self.arrOne, self.arrTwo, self.arrThree];

}

#pragma mark - delegate,datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 59;
    }else {
        return 41;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitle[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 6;
            break;
        case 1:
            return 10;
            break;
        case 2:
            return 5;
            break;
        default:
            return 4;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
//        添加控件slider
        [self createSlider];
        [cell.contentView addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).with.insets(UIEdgeInsetsMake(20, 108, 20, 108));
        }];
        [self createRightView];
        [cell.contentView addSubview:self.rightView];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 59));
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).with.offset(0);
        }];
        
//        测试数据判断(若真实设备数据,则直接执行else)
        NSString *str=[NSString stringWithFormat:@"%ld", self.listArr.count];
        if ([str isEqualToString:@"0"]) {
            self.dayLabel.text=@"--";
            self.slider.value=0;
        }else {
            NSInteger allDays=[self.listArr[indexPath.row][@"sensorTime"] integerValue];
            NSInteger useDays=[self.listArr[indexPath.row][@"sensorOldTime"] integerValue];
            NSInteger leftDays=(allDays - useDays);
            self.dayLabel.text=[NSString stringWithFormat:@"%ld",leftDays];
            CGFloat value=(CGFloat)useDays/allDays*100;
            self.slider.value=value;
        }
        
    }else {
//        cell.textLabel.font=[UIFont systemFontOfSize:15];
//        添加控件
        if (indexPath.section == 2) {
            if (indexPath.row != 0) {
                [self creatLabel];
                self.label.text=[NSString stringWithFormat:@"%@",self.totalArr[indexPath.section - 1][indexPath.row - 1]];
                [cell.contentView addSubview:self.label];
                [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 21));
                    make.right.equalTo(cell.contentView).with.offset(-19);
                    make.centerY.equalTo(cell.contentView);
                }];
            }
        }else {
            [self creatLabel];
            self.label.text=[NSString stringWithFormat:@"%@",self.totalArr[indexPath.section - 1][indexPath.row]];
            [cell.contentView addSubview:self.label];
            [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 21));
                make.right.equalTo(cell.contentView).with.offset(-19);
                make.centerY.equalTo(cell.contentView);
            }];
        }
    }
    
    cell.textLabel.text=self.arrAll[indexPath.section][indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentLeft;
    if (indexPath.row == 0 && indexPath.section == 2) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled=YES;
    }else {
        cell.userInteractionEnabled=NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backBBI;
    self.navigationItem.backBarButtonItem.tintColor=CONTROL_COLOR;
    
    [self.navigationController pushViewController:[RHEquipStandardViewController new] animated:YES];
}

#pragma mark - 事件处理
//控件slider
- (void)createSlider {
    UISlider *slider=[[UISlider alloc] init];
    slider.minimumValue=0;
    slider.maximumValue=100;
//    slider.minimumTrackTintColor=[UIColor colorWithRed:12/255.0 green:167/255.0 blue:60/255.0 alpha:1.0f];
//    slider.maximumTrackTintColor=[UIColor lightGrayColor];
    if (self.state == 1) {
        [slider setMinimumTrackImage:[UIImage imageNamed:@"greenimg"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"grayimg"] forState:UIControlStateNormal];
        [slider setThumbImage:[UIImage imageNamed:@"thumbimg"] forState:UIControlStateNormal];
    }else {
        [slider setMinimumTrackImage:[UIImage imageNamed:@"heavygray"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"grayimg"] forState:UIControlStateNormal];
        [slider setThumbImage:[UIImage imageNamed:@"thumbimg"] forState:UIControlStateNormal];
    }
    
    self.slider=slider;
}

//空间label
- (void)creatLabel {
    UILabel *label=[[UILabel alloc] init];
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentRight;
    self.label=label;
}

//cell右视图
- (void)createRightView {
    UIView *view=[UIView new];
    UILabel *dayLabel=[[UILabel alloc] init];
    dayLabel.font=[UIFont systemFontOfSize:15];
    dayLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:dayLabel];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 11));
        make.top.equalTo(view).with.offset(15);
        make.right.equalTo(view).with.offset(-14);
    }];
    self.dayLabel=dayLabel;
    
    UILabel *otherLabel=[[UILabel alloc]  init];
    otherLabel.font=[UIFont systemFontOfSize:12];
    otherLabel.text=@"剩余时间(天)";
    if (self.state == 1) {
        otherLabel.textColor=[UIColor blackColor];
        self.dayLabel.textColor=[UIColor blackColor];
    }else {
//        otherLabel.textColor=[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0f];
        otherLabel.textColor=LightGrayColor;
        self.dayLabel.textColor=LightGrayColor;
    }
    otherLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:otherLabel];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 11));
        make.top.equalTo(view).with.offset(35);
        make.right.equalTo(view).with.offset(-14);
    }];
    
    self.rightView=view;
}

//传感器与测量跳转
- (void)jumpToVC {
    RHSenAndMeaViewController *senAndMeaVC=[RHSenAndMeaViewController new];
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    backBBI.tintColor=CONTROL_COLOR;
    self.navigationItem.backBarButtonItem=backBBI;
    senAndMeaVC.deviceCode=self.deviceCode;
    [self.navigationController pushViewController:senAndMeaVC animated:YES];
}

//移动设备
- (void)moveEquipment {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.placePara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
        backBBI.tintColor=CONTROL_COLOR;
        self.navigationItem.backBarButtonItem=backBBI;
        
        RHMoveOneStepViewController *moveOneVC=[RHMoveOneStepViewController new];
        moveOneVC.placeList=responseObject[@"body"][@"list"];
        [self.navigationController pushViewController:moveOneVC animated:YES];
        [moveOneVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

//删除设备请求
- (void)deleteEquipmentRequest {
    UIAlertController *alertContro=[UIAlertController alertControllerWithTitle:nil message:@"确定删除该设备" preferredStyle:UIAlertControllerStyleAlert];
    [alertContro addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager POST:MANAGE_API parameters:self.deletePara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",MSG);
            if (STATUS == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }]];
    [alertContro addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alertContro animated:YES completion:nil];
}

//通知处理事件
- (void)moveAction:(NSNotification *)notification {
    self.navigationItem.rightBarButtonItem.tintColor=CONTROL_COLOR;
    self.navigationItem.rightBarButtonItem.enabled=YES;
    NSString *name=notification.userInfo[@"name"];
    self.moveTolabel.text=name;
    self.areaId=[notification.userInfo[@"areaId"] integerValue];
}

//右BBI事件处理
- (void)done {
//    我要开始移动设备了
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:MANAGE_API parameters:self.movePara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",MSG);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
}


#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=WhiteColor;
        _tableView.sectionHeaderHeight=35;
    }
    return _tableView;
}
- (UIView *)bacView {
    if (!_bacView) {
        _bacView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 116)];
    }
    return _bacView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"equipColor"]];
    }
    return _imageView;
}

- (UILabel *)equipText {
    if (!_equipText) {
        _equipText=[[UILabel alloc] init];
        _equipText.text=@"设备编号";
        _equipText.textColor=WhiteColor;
        _equipText.font=[UIFont systemFontOfSize:15];
    }
    return _equipText;
}

- (UILabel *)equipNum {
    if (!_equipNum) {
        _equipNum=[[UILabel alloc] init];
        _equipNum.text=self.deviceCode;
        _equipNum.textColor=WhiteColor;
        _equipNum.font=[UIFont systemFontOfSize:15];
    }
    return _equipNum;
}

- (UILabel *)statu {
    if (!_statu) {
        _statu=[[UILabel alloc] init];
        _statu.textColor=WhiteColor;
        _statu.font=[UIFont systemFontOfSize:14];
        _statu.textAlignment=NSTextAlignmentCenter;
        _statu.layer.borderWidth=1;
        _statu.layer.borderColor=WhiteColor.CGColor;
    }
    return _statu;
}

- (UILabel *)describe {
    if (!_describe) {
        _describe=[[UILabel alloc] init];
        _describe.textColor=WhiteColor;
        _describe.font=[UIFont systemFontOfSize:14];
    }
    return _describe;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView=[UIView new];
        _footerView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 350);
        _footerView.backgroundColor=WhiteColor;
    }
    return _footerView;
}

- (UIButton *)lastBtn {
    if (!_lastBtn) {
        _lastBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _lastBtn.frame=CGRectMake(0, 41, SCREEN_WIDTH, 41);
        _lastBtn.backgroundColor=BACKGROUND_COLOR;
        [_lastBtn addTarget:self action:@selector(jumpToVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastBtn;
}

- (UILabel *)lastLabel {
    if (!_lastLabel) {
        _lastLabel=[[UILabel alloc] init];
        _lastLabel.textAlignment=NSTextAlignmentLeft;
        _lastLabel.text=@"传感器与测量";
    }
    return _lastLabel;
}

- (UIButton *)moveBtn {
    if (!_moveBtn) {
        _moveBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _moveBtn.frame=CGRectMake(0, 92, SCREEN_WIDTH, 41);
        _moveBtn.backgroundColor=BACKGROUND_COLOR;
        [_moveBtn addTarget:self action:@selector(moveEquipment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moveBtn;
}

- (UILabel *)moveLabel {
    if (!_moveLabel) {
        _moveLabel=[[UILabel alloc] init];
        _moveLabel.textAlignment=NSTextAlignmentLeft;
        _moveLabel.text=@"移动设备";
    }
    return _moveLabel;
}

- (UILabel *)moveTolabel {
    if (!_moveTolabel) {
        _moveTolabel=[[UILabel alloc] init];
        _moveTolabel.textAlignment=NSTextAlignmentRight;
        _moveTolabel.font=[UIFont systemFontOfSize:14];
    }
    return _moveTolabel;
}

- (UIImageView *)lastImgView {
    if (!_lastImgView) {
        _lastImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    }
    return _lastImgView;
}

- (UIImageView *)moveImgView {
    if (!_moveImgView) {
        _moveImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    }
    return _moveImgView;
}

- (UIButton *)deletBtn {
    if (!_deletBtn) {
        _deletBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _deletBtn.backgroundColor=DELETEBTN_COLOR;
        [_deletBtn setTitle:@"删除设备" forState:UIControlStateNormal];
        [_deletBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _deletBtn.layer.cornerRadius=22;
        [_deletBtn addTarget:self action:@selector(deleteEquipmentRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deletBtn;
}



- (NSArray *)arrZero {
        NSString  *str=[NSString stringWithFormat:@"%ld",self.listArr.count];
        if ([str isEqualToString:@"0"]) {
            _arrZero=@[@"--",@"--",@"--",@"--",@"--",@"--"];

        }else {
            _arrZero=@[self.listArr[0][@"sensorName"], self.listArr[1][@"sensorName"], self.listArr[1][@"sensorName"], self.listArr[3][@"sensorName"], self.listArr[4][@"sensorName"], self.listArr[5][@"sensorName"]];
        }
    return _arrZero;
}

- (NSArray *)arrOne {
    if (!_arrOne) {
        _arrOne=@[@"产品名称", @"产品型号", @"尺寸", @"重量", @"无限局域地址", @"蓝牙", @"采集频率", @"软件版本", @"制造商", @"生产商"];
    }
    return _arrOne;
}

- (NSArray *)arrTwo {
    if (!_arrTwo) {
        _arrTwo=@[@"无限规格", @"语音播报", @"指示灯", @"显示屏", @"电池"];
    }
    return _arrTwo;
}

- (NSArray *)arrThree {
    if (!_arrThree) {
        _arrThree=@[@"材料(包装盒)", @"尺寸(包装盒)", @"接口(配件)", @"特性(配件)"];
    }
    return _arrThree;
}



- (NSArray *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle=@[@"传感器寿命", @"基本信息", @"其他规格", @"包装和配件"];
    }
    return _sectionTitle;
}

- (NSString *)deletePara {
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @1,
                         @"uuid": @"188111",
                         @"cmd": @30013,
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{@"deviceList": @[@{@"deviceCode":self.deviceCode}]};
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _deletePara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return _deletePara;
}

- (NSString *)placePara {
    if (!_placePara) {
        NSInteger userId=[UserId integerValue];
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
        NSDictionary *con=@{@"userId": @(userId)};
        NSDictionary  *dict=@{@"head":head, @"con":con};
        
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _placePara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _placePara;
}

- (NSString *)movePara {
    NSInteger userId=[UserId integerValue];
    
    NSDictionary *head=@{
                         @"aid": @"1and6uu",
                         @"ver": @"1.0",
                         @"ln": @"cn",
                         @"mod": @"ios",
                         @"de": @"2017-07-13 00:00:00",
                         @"sync": @1,
                         @"uuid": @"188111",
                         @"cmd": @30010,
                         @"chcode": @" ef19843298ae8f2134f "
                         };
    NSDictionary *con=@{
                        @"deviceCode": self.deviceCode,
                        @"areaId": @(self.areaId),
                        @"userId": @(userId),
                        @"operataionType": @(2),
                        @"wifiAdderss": self.wifiAdderss
                        };
    NSDictionary *dict=@{@"head":head, @"con":con};
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    _movePara=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return _movePara;
}

//释放内存
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"moveEquipment" object:nil];
}






@end
