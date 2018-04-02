//
//  RHIndexCollectionViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/4/2.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHIndexCollectionViewCell.h"
#import "Header.h"
#import "Masonry.h"


@implementation RHIndexCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.indexLabel];
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(15, 10, 65, 10));
    }];
}

#pragma mark - lazyload
- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel=[[UILabel alloc] init];
        _indexLabel.textAlignment=NSTextAlignmentLeft;
        _indexLabel.font=[UIFont systemFontOfSize:14.0f];
        _indexLabel.text=@"保湿指数";
    }
    return _indexLabel;
}

@end
