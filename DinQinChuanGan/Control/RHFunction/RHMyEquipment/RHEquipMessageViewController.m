//
//  RHEquipMessageViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/2.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHEquipMessageViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "Header.h"

@interface RHEquipMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *equipText;
@property (nonatomic, strong) UILabel *equipNum;
@property (nonatomic, strong) UILabel *statu;
@property (nonatomic, strong) UILabel *describe;
@property (nonatomic, copy) NSArray *arrZero;
@property (nonatomic, copy) NSArray *arrOne;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, copy) NSArray *basicarr;


@end

@implementation RHEquipMessageViewController

static NSString *identifier=@"cell";


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - 处理GUI
- (void)layoutViews {
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"设备";
    [self.view addSubview:self.tableView];
    [self.bacView addSubview:self.imageView];
    self.tableView.tableHeaderView=self.bacView;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bacView).with.insets(UIEdgeInsetsMake(7, 8, 7, 8));
    }];
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
    if (section==0) {
        return @"传感器寿命";
    }else {
        return @"基本信息";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 6:4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text=self.arrZero[indexPath.row];
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
    }else {
        cell.textLabel.text=self.arrOne[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:15];
//        添加控件
        UILabel *label=[[UILabel alloc] init];
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:14];
        label.text=self.basicarr[indexPath.row];
        label.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 21));
            make.right.equalTo(cell.contentView).with.offset(-19);
            make.centerY.equalTo(cell.contentView);
        }];
    }
    cell.userInteractionEnabled=NO;
    return cell;
}

#pragma mark - 事件处理
//控件slider
- (void)createSlider {
    UISlider *slider=[[UISlider alloc] init];
    slider.minimumValue=0;
    slider.maximumValue=100;
    slider.value=50;
//    slider.minimumTrackTintColor=[UIColor colorWithRed:12/255.0 green:167/255.0 blue:60/255.0 alpha:1.0f];
//    slider.maximumTrackTintColor=[UIColor lightGrayColor];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"greenimg"] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[UIImage imageNamed:@"grayimg"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"thumbimg"] forState:UIControlStateNormal];
    self.slider=slider;
}

//cell右视图
- (void)createRightView {
    UIView *view=[UIView new];
    UILabel *dayLabel=[[UILabel alloc] init];
    dayLabel.font=[UIFont systemFontOfSize:15];
    dayLabel.text=@"190";
    dayLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:dayLabel];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 11));
        make.top.equalTo(view).with.offset(15);
        make.right.equalTo(view).with.offset(-14);
    }];

    UILabel *otherLabel=[[UILabel alloc]  init];
    otherLabel.font=[UIFont systemFontOfSize:12];
    otherLabel.text=@"剩余时间(天)";
    otherLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:otherLabel];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 11));
        make.top.equalTo(view).with.offset(35);
        make.right.equalTo(view).with.offset(-14);
    }];
    self.rightView=view;
}




#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=WhiteColor;
        _tableView.sectionHeaderHeight=35;
        
        _tableView.tableFooterView=[UIView new];
//        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 200, 0);
    }
    return _tableView;
}
- (UIView *)bacView {
    if (!_bacView) {
        _bacView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 116)];
        _bacView.backgroundColor=WhiteColor;
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
        _equipNum.text=@"0989474738";
        _equipNum.textColor=WhiteColor;
        _equipNum.font=[UIFont systemFontOfSize:15];
    }
    return _equipNum;
}

- (UILabel *)statu {
    if (!_statu) {
        _statu=[[UILabel alloc] init];
        _statu.text=@"在线";
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
        _describe.text=@"已为您续航900天";
        _describe.textColor=WhiteColor;
        _describe.font=[UIFont systemFontOfSize:14];
    }
    return _describe;
}



- (NSArray *)arrZero {
    if (!_arrZero) {
        _arrZero=@[@"PM2.5", @"CO2", @"Temp", @"RH", @"HCHO", @"TVOC"];
    }
    return _arrZero;
}

- (NSArray *)arrOne {
    if (!_arrOne) {
        _arrOne=@[@"产品名称", @"产品型号", @"尺寸", @"重量"];
    }
    return _arrOne;
}

- (NSArray *)basicarr {
    if (!_basicarr) {
//        _basicarr=@[@"室内智能空气检测仪", @"MBM200000000", @"155*155*34mm", @"300g"];
        _basicarr=@[@"室内智能空气检测仪", @"MBM200000000", @"155*155*34mm", @"300g"];

    }
    return _basicarr;
}






@end