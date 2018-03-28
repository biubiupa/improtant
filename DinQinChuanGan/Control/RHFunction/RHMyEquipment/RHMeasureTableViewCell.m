//
//  RHMeasureTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/21.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMeasureTableViewCell.h"
#import "Header.h"
#import "Masonry.h"

@implementation RHMeasureTableViewCell

//初始化子视图
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.supportLabel];
//        self.userInteractionEnabled=NO;
        
    }
    
    return self;
}

//布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.supportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 15));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-20);
    }];
}

- (UILabel *)supportLabel {
    if (!_supportLabel) {
        _supportLabel=[[UILabel alloc] init];
        _supportLabel.font=[UIFont systemFontOfSize:14];
        _supportLabel.textAlignment=NSTextAlignmentRight;
        _supportLabel.text=@"不支持";
    }
    return _supportLabel;
}

@end
