//
//  ControlCollectionViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/21.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "ControlCollectionViewCell.h"
#import "Masonry.h"
@interface ControlCollectionViewCell ()
@end
@implementation ControlCollectionViewCell


- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(29, 29));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(14);
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 14));
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-14);
    }];
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView=[[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel=[[UILabel alloc] init];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font=[UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

@end
