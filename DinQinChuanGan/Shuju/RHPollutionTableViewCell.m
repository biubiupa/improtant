//
//  RHPollutionTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHPollutionTableViewCell.h"
#import "Header.h"
#import "Masonry.h"

@interface RHPollutionTableViewCell()
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *pollutionLabel;
@property (nonatomic, strong) UIImageView *physicsImgView;
@property (nonatomic, strong) UIImageView *chemistryImgView;
@property (nonatomic, strong) UILabel *physicsLabel;
@property (nonatomic, strong) UILabel *chemistryLabel;
@property (nonatomic, strong) UILabel *levelLabelP;
@property (nonatomic, strong) UILabel *levelLabelC;
@property (nonatomic, strong) UIView *midView;


@end

@implementation RHPollutionTableViewCell

#pragma mark - 初始化，布局
//初始化cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.markView];
        [self.contentView addSubview:self.pollutionLabel];
        [self.contentView addSubview:self.physicsImgView];
        [self.contentView addSubview:self.physicsLabel];
        [self.contentView addSubview:self.levelLabelP];
        [self.contentView addSubview:self.chemistryImgView];
        [self.contentView addSubview:self.chemistryLabel];
        [self.contentView addSubview:self.levelLabelC];
        [self.contentView addSubview:self.midView];
    }
    
    return self;
}

//布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2, 14));
        make.top.equalTo(self.contentView).with.offset(21);
        make.left.equalTo(self.contentView).with.offset(20);
    }];
    [self.pollutionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85, 14));
        make.top.equalTo(self.contentView).with.offset(21);
        make.left.equalTo(self.contentView).with.offset(30);
    }];
    [self.physicsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 22));
        make.top.equalTo(self.contentView).with.offset(71);
        make.left.equalTo(self.contentView).with.offset(25);
    }];
    [self.physicsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 14));
        make.top.equalTo(self.contentView).with.offset(71);
        make.left.equalTo(self.contentView).with.offset(54);
    }];
    [self.levelLabelP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 14));
        make.top.equalTo(self.contentView).with.offset(93);
        make.left.equalTo(self.contentView).with.offset(55);
    }];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 1));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(120);
    }];
    [self.chemistryImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.top.equalTo(self.contentView).with.offset(147);
        make.left.equalTo(self.contentView).with.offset(25);
    }];
    [self.chemistryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 14));
        make.top.equalTo(self.contentView).with.offset(147);
        make.left.equalTo(self.contentView).with.offset(54);
    }];
    [self.levelLabelC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 14));
        make.top.equalTo(self.contentView).with.offset(171);
        make.left.equalTo(self.contentView).with.offset(55);
    }];
}

#pragma mark - lazyload
- (UIView *)markView {
    if (!_markView) {
        _markView=[UIView new];
        _markView.backgroundColor=CONTROL_COLOR;
    }
    return _markView;
}

- (UILabel *)pollutionLabel {
    if (!_pollutionLabel) {
        _pollutionLabel=[[UILabel alloc] init];
        _pollutionLabel.textAlignment=NSTextAlignmentLeft;
        _pollutionLabel.font=[UIFont systemFontOfSize:15.0f];
        _pollutionLabel.text=@"主要污染物";
    }
    return _pollutionLabel;
}

- (UIImageView *)physicsImgView {
    if (!_physicsImgView) {
        _physicsImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"physics"]];
    }
    return _physicsImgView;
}

- (UIImageView *)chemistryImgView {
    if (!_chemistryImgView) {
        _chemistryImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chemistry"]];
    }
    return _chemistryImgView;
}

- (UILabel *)physicsLabel {
    if (!_physicsLabel) {
        _physicsLabel=[[UILabel alloc] init];
        _physicsLabel.textAlignment=NSTextAlignmentLeft;
        _physicsLabel.font=[UIFont systemFontOfSize:14];
        _physicsLabel.text=@"物理污染";
    }
    return _physicsLabel;
}

- (UILabel *)chemistryLabel {
    if (!_chemistryLabel) {
        _chemistryLabel=[[UILabel alloc] init];
        _chemistryLabel.textAlignment=NSTextAlignmentLeft;
        _chemistryLabel.font=[UIFont systemFontOfSize:14];
        _chemistryLabel.text=@"化学污染";
    }
    return _chemistryLabel;
}

- (UILabel *)levelLabelP {
    if (!_levelLabelP) {
        _levelLabelP=[[UILabel alloc] init];
        _levelLabelP.font=[UIFont systemFontOfSize:12];
        _levelLabelP.textAlignment=NSTextAlignmentLeft;
        _levelLabelP.text=@"良";
    }
    return _levelLabelP;
}

- (UILabel *)levelLabelC {
    if (!_levelLabelC) {
        _levelLabelC=[[UILabel alloc] init];
        _levelLabelC.font=[UIFont systemFontOfSize:12];
        _levelLabelC.textAlignment=NSTextAlignmentLeft;
        _levelLabelC.text=@"严重";
    }
    return _levelLabelC;
}

- (UIView *)midView {
    if (!_midView) {
        _midView=[UIView new];
        _midView.backgroundColor=BACKGROUND_COLOR;
    }
    return _midView;
}

@end
