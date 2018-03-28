//
//  RHDefaultCollectionViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/27.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHDefaultCollectionViewCell.h"
#import "Header.h"

@implementation RHDefaultCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.imgView];
}



- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 40)/3, 178)];
        _imgView.clipsToBounds=YES;
        _imgView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}



@end
