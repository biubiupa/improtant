//
//  SliderTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/19.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "SliderTableViewCell.h"
#import "Header.h"
#import "Masonry.h"

@interface SliderTableViewCell ()

@property (nonatomic, strong) UIImageView *imageVC;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIProgressView *progressVC;
@property (nonatomic, strong) UILabel *begin;
@property (nonatomic, strong) UILabel *end;

@end

@implementation SliderTableViewCell
// 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


#pragma mark - 需求，布局

- (void)layoutSubviews {
    [super layoutSubviews];
    self.userInteractionEnabled=NO;
    self.curtainView.frame=self.contentView.frame;
    [self.contentView addSubview:self.curtainView];
    [self.curtainView addSubview:self.imageVC];
    [self.imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 36));
        make.left.equalTo(self.curtainView).with.offset(22);
        make.top.equalTo(self.curtainView).with.offset(8);
    }];
    [self.curtainView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 14));
        make.left.equalTo(self.curtainView).with.offset(22);
        make.bottom.equalTo(self.curtainView).with.offset(-8);
    }];
    [self.curtainView addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 72));
        make.centerY.equalTo(self.curtainView);
        make.left.equalTo(self.curtainView).with.offset(69);
    }];
    [self.curtainView addSubview:self.progressVC];
    [self.progressVC mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(315, 5));
        make.size.width.mas_equalTo(5);
        make.centerY.equalTo(self.curtainView);
        make.left.equalTo(self.curtainView).with.offset(86);
        make.right.equalTo(self.curtainView).with.offset(-16);
    }];
    [self.curtainView addSubview:self.begin];
    [self.begin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 9));
        make.left.equalTo(self.curtainView).with.offset(87);
        make.bottom.equalTo(self.curtainView).with.offset(-14);
    }];
    [self.curtainView addSubview:self.end];
    [self.end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 9));
        make.right.equalTo(self.curtainView).with.offset(-20);
        make.bottom.equalTo(self.curtainView).with.offset(-14);
    }];
    self.backgroundColor=[UIColor colorWithRed:247.0/255.0 green:248.0/255.0 blue:250.0/255.0 alpha:1.0];
    [self.contentView addSubview:self.signLabel];
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190, 31));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(28);
    }];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - 初始化属性
- (UIView *)curtainView {
    if (!_curtainView) {
        _curtainView=[[UIView alloc] init];
//        _curtainView.center=self.contentView.center;
//        _curtainView.bounds=self.contentView.bounds;
    }
    return _curtainView;
}

- (UIImageView *)imageVC {
    if (!_imageVC) {
        _imageVC=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xunzhang"]];
    }
    return _imageVC;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc] init];
        _nameLabel.text=@"达人";
        _nameLabel.font=[UIFont systemFontOfSize:12];
    }
    return _nameLabel;
}

- (UIView *)grayView {
    if (!_grayView) {
        _grayView=[[UIView alloc] init];
        _grayView.backgroundColor=[UIColor lightGrayColor];
    }
    return _grayView;
}

- (UIProgressView *)progressVC {
    if (!_progressVC) {
        _progressVC=[[UIProgressView alloc] init];
        _progressVC.progress=0.5;
        _progressVC.progressTintColor=CONTROL_COLOR;
        _progressVC.trackTintColor=[UIColor lightGrayColor];
    }
    return _progressVC;
    
}

- (UILabel *)begin {
    if (!_begin) {
        _begin=[[UILabel alloc] init];
        _begin.text=@"V1";
        _begin.font=[UIFont systemFontOfSize:12];
    }
    return _begin;
}

- (UILabel *)end {
    if (!_end) {
        _end=[[UILabel alloc] init];
        _end.text=@"V6";
        _end.font=[UIFont systemFontOfSize:12];
    }
    return _end;
}

- (UILabel *)signLabel {
    if (!_signLabel) {
        _signLabel=[[UILabel alloc] init];
        _signLabel.textAlignment=NSTextAlignmentCenter;
        _signLabel.text=@"登录后才能查看等级哦~";
    }
    return _signLabel;
}


@end
