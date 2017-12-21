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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - 需求，布局

- (void)layoutSubviews {
    [super layoutSubviews];
    self.userInteractionEnabled=NO;
    [self.contentView addSubview:self.imageVC];
    [self.imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 36));
        make.left.equalTo(self.contentView).with.offset(22);
        make.top.equalTo(self.contentView).with.offset(8);
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 14));
        make.left.equalTo(self.contentView).with.offset(22);
        make.bottom.equalTo(self.contentView).with.offset(-8);
    }];
    [self.contentView addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 72));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(69);
    }];
    [self.contentView addSubview:self.progressVC];
    [self.progressVC mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(315, 5));
        make.size.width.mas_equalTo(5);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(86);
        make.right.equalTo(self.contentView).with.offset(-16);
    }];
    [self.contentView addSubview:self.begin];
    [self.begin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 9));
        make.left.equalTo(self.contentView).with.offset(87);
        make.bottom.equalTo(self.contentView).with.offset(-14);
    }];
    [self.contentView addSubview:self.end];
    [self.end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 9));
        make.right.equalTo(self.contentView).with.offset(-20);
        make.bottom.equalTo(self.contentView).with.offset(-14);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - 初始化属性
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


@end
