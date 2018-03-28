//
//  RHSenTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/21.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHSenTableViewCell.h"
#import "Header.h"
#import "Masonry.h"

@implementation RHSenTableViewCell

//初始化子视图
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.rangeLabel];
        [self.contentView addSubview:self.precisionLabel];
        [self.contentView addSubview:self.resolutionLabel];
//        self.userInteractionEnabled=NO;
    }
    return self;
}

//布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 15));
        make.top.equalTo(self.contentView).with.offset(20);
        make.right.equalTo(self.contentView).with.offset(-20);
    }];
    [self.precisionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 15));
        make.top.equalTo(self.contentView).with.offset(55);
        make.right.equalTo(self.contentView).with.offset(-20);
    }];
    [self.resolutionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 15));
        make.top.equalTo(self.contentView).with.offset(90);
        make.right.equalTo(self.contentView).with.offset(-20);
    }];
    
}

#pragma mark - lazyload
- (UILabel *)rangeLabel {
    if (!_rangeLabel) {
        _rangeLabel=[[UILabel alloc] init];
        _rangeLabel.font=[UIFont systemFontOfSize:14];
        _rangeLabel.textAlignment=NSTextAlignmentRight;
        _rangeLabel.text=@"量程：";
    }
    return _rangeLabel;
}

- (UILabel *)precisionLabel  {
    if (!_precisionLabel) {
        _precisionLabel=[[UILabel alloc] init];
        _precisionLabel.font=[UIFont systemFontOfSize:14];
        _precisionLabel.textAlignment=NSTextAlignmentRight;
        _precisionLabel.text=@"精度：";
    }
    return _precisionLabel;
}

- (UILabel *)resolutionLabel {
    if (!_resolutionLabel) {
        _resolutionLabel=[[UILabel alloc] init];
        _resolutionLabel.font=[UIFont systemFontOfSize:14];
        _resolutionLabel.textAlignment=NSTextAlignmentRight;
        _resolutionLabel.text=@"单位：";
    }
    return _resolutionLabel;
}

@end
