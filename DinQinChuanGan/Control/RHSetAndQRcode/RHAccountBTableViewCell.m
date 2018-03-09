//
//  RHAccountBTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/8.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAccountBTableViewCell.h"
#import "Header.h"
#import "Masonry.h"

@implementation RHAccountBTableViewCell


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.imgview];
    [self.imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.contentView).with.offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 21));
        make.left.equalTo(self.contentView).with.offset(45);
        make.centerY.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(155, 21));
        make.right.equalTo(self.contentView).with.offset(0);
        make.centerY.equalTo(self.contentView);
    }];
}

- (UIImageView *)imgview {
    if (!_imgview) {
        _imgview=[[UIImageView alloc] init];
        _imgview.clipsToBounds=YES;
        _imgview.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _imgview;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel=[[UILabel alloc] init];
        _desLabel.font=[UIFont systemFontOfSize:15];
        _desLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _desLabel;
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel=[[UILabel alloc] init];
        _accountLabel.font=[UIFont systemFontOfSize:15];
        _accountLabel.textAlignment=NSTextAlignmentRight;
    }
    return _accountLabel;
}

@end
