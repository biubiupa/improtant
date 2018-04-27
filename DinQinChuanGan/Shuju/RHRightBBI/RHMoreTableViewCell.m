//
//  RHMoreTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/4/24.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMoreTableViewCell.h"
#import "Header.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#define Label_Space     (SCREEN_WIDTH - 201)/7
#define Lable_Width     30
#define Star_Width      17

@interface RHMoreTableViewCell()
@property (nonatomic, strong) UILabel *areaNaLab;
@property (nonatomic, strong) UIImageView *bacImgView;
@property (nonatomic, strong) UIView *alView;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *ihaiLabel;
@property (nonatomic, strong) UILabel *ihData;
@property (nonatomic, strong) UILabel * pollut0;
@property (nonatomic, strong) UILabel * pollut1;
@property (nonatomic, strong) UILabel * pollut2;
@property (nonatomic, strong) UILabel * pollut3;
@property (nonatomic, strong) UILabel * pollut4;
@property (nonatomic, strong) UILabel * pollut5;
@property (nonatomic, strong) UILabel * data0;
@property (nonatomic, strong) UILabel * data1;
@property (nonatomic, strong) UILabel * data2;
@property (nonatomic, strong) UILabel * data3;
@property (nonatomic, strong) UILabel * data4;
@property (nonatomic, strong) UILabel * data5;


@end

@implementation RHMoreTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bacImgView];
        [self.bacImgView addSubview:self.alView];
        [self.bacImgView addSubview:self.areaNaLab];
        [self.bacImgView addSubview:self.ihaiLabel];
        [self.bacImgView addSubview:self.ihData];
        [self.bacImgView addSubview:self.bacView];
//        污染物名称
        [self.bacImgView addSubview:self.pollut0];
        [self.bacImgView addSubview:self.pollut1];
        [self.bacImgView addSubview:self.pollut2];
        [self.bacImgView addSubview:self.pollut3];
        [self.bacImgView addSubview:self.pollut4];
        [self.bacImgView addSubview:self.pollut5];
//        污染物数据
        [self.bacImgView addSubview:self.data0];
        [self.bacImgView addSubview:self.data1];
        [self.bacImgView addSubview:self.data2];
        [self.bacImgView addSubview:self.data3];
        [self.bacImgView addSubview:self.data4];
        [self.bacImgView addSubview:self.data5];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    背景图片
    [self.bacImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 6, 0, 6));
    }];
//    灰度(模拟)
    [self.alView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bacImgView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
//    区域名称\ihai
    [self.areaNaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 23));
        make.centerX.equalTo(self.bacImgView);
        make.top.equalTo(self.bacImgView).with.offset(50);
    }];
    [self.bacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 42));
        make.centerX.equalTo(self.bacImgView);
        make.bottom.equalTo(self.bacImgView).with.offset(0);
    }];
    
    
    [self.ihaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 12));
        make.left.equalTo(self.bacImgView).with.offset(18);
        make.top.equalTo(self.bacImgView).with.offset(58);
    }];
    [self.ihData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 20));
        make.left.equalTo(self.bacImgView).with.offset(40);
        make.top.equalTo(self.bacImgView).with.offset(49);
    }];
    
//    六个污染物名称
    [self.pollut0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38, 12));
        make.left.equalTo(self.bacImgView).with.offset(Label_Space);
        make.bottom.equalTo(self.bacImgView).with.offset(-24);
    }];
    [self.pollut1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 12));
        make.left.equalTo(self.bacImgView).with.offset(Label_Space * 2 + 38);
        make.bottom.equalTo(self.bacImgView).with.offset(-24);
    }];
    [self.pollut2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 12));
        make.left.equalTo(self.bacImgView).with.offset(Label_Space * 3 + 88);
        make.bottom.equalTo(self.bacImgView).with.offset(-24);
    }];
    [self.pollut3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 12));
        make.left.equalTo(self.bacImgView).with.offset((Label_Space * 4 + 113));
        make.bottom.equalTo(self.bacImgView).with.offset(-24);
    }];
    [self.pollut4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 12));
        make.left.equalTo(self.bacImgView).with.offset((Label_Space * 5 + 138));
        make.bottom.equalTo(self.bacImgView).with.offset(-24);
    }];
    [self.pollut5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38, 12));
        make.left.equalTo(self.bacImgView).with.offset(Label_Space * 6 + 163);
        make.bottom.equalTo(self.bacImgView).with.offset(-24);
    }];
    
//    污染物数据
    [self.data0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Lable_Width, 12));
        make.centerX.equalTo(self.pollut0);
        make.top.equalTo(self.pollut0).with.offset(18);
    }];
    [self.data1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Lable_Width, 12));
        make.centerX.equalTo(self.pollut1);
        make.top.equalTo(self.pollut1).with.offset(18);
    }];
    [self.data2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Lable_Width, 12));
        make.centerX.equalTo(self.pollut2);
        make.top.equalTo(self.pollut2).with.offset(18);
    }];
    [self.data3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Lable_Width, 12));
        make.centerX.equalTo(self.pollut3);
        make.top.equalTo(self.pollut3).with.offset(18);
    }];
    [self.data4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Lable_Width, 12));
        make.centerX.equalTo(self.pollut4);
        make.top.equalTo(self.pollut4).with.offset(18);
    }];
    [self.data5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Lable_Width, 12));
        make.centerX.equalTo(self.pollut5);
        make.top.equalTo(self.pollut5).with.offset(18);
    }];
    
//    刷新后赋值
    if (self.lists) {
        self.areaNaLab.text=[NSString stringWithFormat:@"%@",self.lists[self.aindex][@"areaName"]];
        NSString *urlString=[NSString stringWithFormat:@"%@",self.lists[self.aindex][@"picture"]];
        [self.bacImgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
//        根据排名计算星星个数
        if (self.aindex < 3) {
            NSInteger count;
            switch (self.aindex) {
                case 0:
                    count = 3;
                    break;
                case 1:
                    count = 2;
                    break;
                default:
                    count = 1;
                    break;
                    }
            for (int i = 0; i < count; ++i) {
                UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star"]];
                [self.bacImgView addSubview:imgView];
                [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(17, 17));
                    make.top.equalTo(self.bacImgView).with.offset(15);
                    make.left.equalTo(self.bacImgView).with.offset(17 + Star_Width * i);
                }];
            }
        }
    }
    
}



#pragma mark - lazyload
//区域名称
- (UILabel *)areaNaLab {
    if (!_areaNaLab) {
        _areaNaLab=[[UILabel alloc] init];
        _areaNaLab.textAlignment=NSTextAlignmentCenter;
        _areaNaLab.font=SYSTEMFONT(24);
        _areaNaLab.textColor=WhiteColor;
        _areaNaLab.text=@"--";
    }
    return _areaNaLab;
}

//ihai名称
- (UILabel *)ihaiLabel {
    if (!_ihaiLabel) {
        _ihaiLabel=[[UILabel alloc] init];
        _ihaiLabel.textColor=BACKGROUND_COLOR;
        _ihaiLabel.font=SYSTEMFONT(12);
        _ihaiLabel.textAlignment=NSTextAlignmentLeft;
        _ihaiLabel.text=@"IHAI";
    }
    return _ihaiLabel;
}

- (UILabel *)ihData {
    if (!_ihData) {
        _ihData=[[UILabel alloc] init];
        _ihData.textColor=WhiteColor;
        _ihData.font=SYSTEMFONT(24);
        _ihData.textAlignment=NSTextAlignmentLeft;
        _ihData.text=@"--";
    }
    return _ihData;
}

//图片背景imgview
- (UIImageView *)bacImgView {
    if (!_bacImgView) {
        _bacImgView=[[UIImageView alloc] init];
        _bacImgView.clipsToBounds=YES;
        _bacImgView.layer.cornerRadius=7;
        _bacImgView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _bacImgView;
}

- (UIView *)alView {
    if (!_alView) {
        _alView=[UIView new];
        _alView.backgroundColor=[UIColor blackColor];
        _alView.alpha=0.1;
    }
    return _alView;
}

- (UIView *)bacView {
    if (!_bacView) {
        _bacView=[UIView new];
        _bacView.backgroundColor=[UIColor blackColor];
        _bacView.alpha=0.2;
    }
    return _bacView;
}

//六个污染物名称
- (UILabel *)pollut0 {
    if (!_pollut0) {
        _pollut0=[[UILabel alloc] init];
        _pollut0.textColor=WhiteColor;
        _pollut0.font=SYSTEMFONT(12.0f);
        _pollut0.textAlignment=NSTextAlignmentCenter;
        _pollut0.text=@"PM2.5";
    }
    return _pollut0;
}

- (UILabel *)pollut1 {
    if (!_pollut1) {
        _pollut1=[[UILabel alloc] init];
        _pollut1.textColor=WhiteColor;
        _pollut1.font=SYSTEMFONT(12.0f);
        _pollut1.textAlignment=NSTextAlignmentCenter;
        _pollut1.text=@"二氧化碳";
    }
    return _pollut1;
}

- (UILabel *)pollut2 {
    if (!_pollut2) {
        _pollut2=[[UILabel alloc] init];
        _pollut2.textColor=WhiteColor;
        _pollut2.font=SYSTEMFONT(12.0f);
        _pollut2.textAlignment=NSTextAlignmentCenter;
        _pollut2.text=@"温度";
    }
    return _pollut2;
}

- (UILabel *)pollut3 {
    if (!_pollut3) {
        _pollut3=[[UILabel alloc] init];
        _pollut3.textColor=WhiteColor;
        _pollut3.font=SYSTEMFONT(12.0f);
        _pollut3.textAlignment=NSTextAlignmentCenter;
        _pollut3.text=@"湿度";
    }
    return _pollut3;
}

- (UILabel *)pollut4 {
    if (!_pollut4) {
        _pollut4=[[UILabel alloc] init];
        _pollut4.textColor=WhiteColor;
        _pollut4.font=SYSTEMFONT(12.0f);
        _pollut4.textAlignment=NSTextAlignmentCenter;
        _pollut4.text=@"甲醛";
    }
    return _pollut4;
}

- (UILabel *)pollut5 {
    if (!_pollut5) {
        _pollut5=[[UILabel alloc] init];
        _pollut5.textColor=WhiteColor;
        _pollut5.font=SYSTEMFONT(12.0f);
        _pollut5.textAlignment=NSTextAlignmentCenter;
        _pollut5.text=@"TVOC";
    }
    return _pollut5;
}

//六个污染物对应的实时数据
- (UILabel *)data0 {
    if (!_data0) {
        _data0=[[UILabel alloc] init];
        _data0.font=SYSTEMFONT(14);
        _data0.textColor=WhiteColor;
        _data0.textAlignment=NSTextAlignmentCenter;
        _data0.text=@"--";
    }
    return _data0;
}

- (UILabel *)data1 {
    if (!_data1) {
        _data1=[[UILabel alloc] init];
        _data1.font=SYSTEMFONT(14);
        _data1.textColor=WhiteColor;
        _data1.textAlignment=NSTextAlignmentCenter;
        _data1.text=@"--";
    }
    return _data1;
}

- (UILabel *)data2 {
    if (!_data2) {
        _data2=[[UILabel alloc] init];
        _data2.font=SYSTEMFONT(14);
        _data2.textColor=WhiteColor;
        _data2.textAlignment=NSTextAlignmentCenter;
        _data2.text=@"--";
    }
    return _data2;
}

- (UILabel *)data3 {
    if (!_data3) {
        _data3=[[UILabel alloc] init];
        _data3.font=SYSTEMFONT(14);
        _data3.textColor=WhiteColor;
        _data3.textAlignment=NSTextAlignmentCenter;
        _data3.text=@"--";
    }
    return _data3;
}

- (UILabel *)data4 {
    if (!_data4) {
        _data4=[[UILabel alloc] init];
        _data4.font=SYSTEMFONT(14);
        _data4.textColor=WhiteColor;
        _data4.textAlignment=NSTextAlignmentCenter;
        _data4.text=@"--";
    }
    return _data4;
}

- (UILabel *)data5 {
    if (!_data5) {
        _data5=[[UILabel alloc] init];
        _data5.font=SYSTEMFONT(14);
        _data5.textColor=WhiteColor;
        _data5.textAlignment=NSTextAlignmentCenter;
        _data5.text=@"--";
    }
    return _data5;
}

@end
