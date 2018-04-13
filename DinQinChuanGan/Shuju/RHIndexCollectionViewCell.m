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
    self.layer.shadowRadius=1;
    self.layer.shadowOffset=CGSizeMake(0, 1);
    self.layer.shadowOpacity=1;
    self.layer.shadowColor=RGBACOLOR(0, 0, 0, 0.08).CGColor;
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
        _indexLabel.textColor=RGBCOLOR(50, 50, 50);
        _indexLabel.text=@"保湿指数";
    }
    return _indexLabel;
}

@end
