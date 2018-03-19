//
//  RHEquipCollectionViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/15.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHEquipCollectionViewCell.h"
#import "Masonry.h"
#import "Header.h"

@implementation RHEquipCollectionViewCell


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(26, 26));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(17);
    }];
    [self.contentView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(95, 11));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(54);
    }];
    
}

#pragma mark - lazyload
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel=[[UILabel alloc] init];
        _codeLabel.font=[UIFont systemFontOfSize:14];
        _codeLabel.text=@"09081090221";
        _codeLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _codeLabel;
}

@end
