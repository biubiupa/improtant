//
//  RHIHAITableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHIHAITableViewCell.h"
#import "Header.h"
#import "Masonry.h"
#import "RHWaveView.h"

@interface RHIHAITableViewCell()
@property (nonatomic, strong) UILabel *roominLabel;
@property (nonatomic, strong) UILabel *roomoutLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) RHWaveView *waveView;
@property (nonatomic, strong) UIButton *displayBtn;

@end

@implementation RHIHAITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.dayLabel];
        [self.contentView addSubview:self.corLabel];
        [self.contentView addSubview:self.ihaiLabel];
        [self.contentView addSubview:self.sPMLabel];
        [self.contentView addSubview:self.hPMLabel];
        [self.contentView addSubview:self.roominLabel];
        [self.contentView addSubview:self.roomoutLabel];
        [self.contentView addSubview:self.lineView];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 22));
        make.top.equalTo(self.contentView).with.offset(17);
        make.left.equalTo(self.contentView).with.offset(10);
    }];
    [self.corLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 22));
        make.top.equalTo(self.contentView).with.offset(17);
        make.right.equalTo(self.contentView).with.offset(-10);
    }];
    [self.ihaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 27));
        make.center.equalTo(self.contentView);
    }];
    [self.sPMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 12));
        make.top.equalTo(self.contentView).with.offset(258);
        make.left.equalTo(self.contentView).with.offset(75);
    }];
    [self.hPMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 12));
        make.top.equalTo(self.contentView).with.offset(258);
        make.right.equalTo(self.contentView).with.offset(-75);
    }];
    [self.roominLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 12));
        make.top.equalTo(self.contentView).with.offset(280);
        make.left.equalTo(self.contentView).with.offset(75);
    }];
    [self.roomoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 12));
        make.top.equalTo(self.contentView).with.offset(280);
        make.right.equalTo(self.contentView).with.offset(-75);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 32));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(258);
    }];
    [self.contentView.layer addSublayer:self.bacShapeLayer];
    [self.contentView.layer addSublayer:self.frontShapeLayer];
    self.waveView=[[RHWaveView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    [self.contentView addSubview:self.waveView];
    self.waveView.layer.masksToBounds=YES;
    self.waveView.layer.cornerRadius=65;
    self.waveView.center=self.contentView.center;
    
    [self.waveView addSubview:self.displayBtn];
    [self.displayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.centerX.equalTo(self.waveView);
        make.top.equalTo(self.waveView).with.offset(25);
    }];
    
    if (self.dataDict != nil) {
        NSString *str=[NSString stringWithFormat:@"%@",self.dataDict[@"dayvalues"]];
        self.dayLabel.text=[@"日均值:" stringByAppendingString:str];
        
        NSString *beat=[NSString stringWithFormat:@"%@",self.dataDict[@"beat"]];
//        NSMutableAttributedString *beat=[[NSMutableAttributedString alloc] initWithString:bai];
//        [beat addAttribute:NSForegroundColorAttributeName value:CONTROL_COLOR range:NSMakeRange(0, beat.length)];
        
        self.corLabel.text=[NSString stringWithFormat:@"打败%@企业",beat];
        self.ihaiLabel.text=[NSString stringWithFormat:@"%@", self.dataDict[@"IHAI"]];
        self.sPMLabel.text=[NSString stringWithFormat:@"%@", self.dataDict[@"SPM25"]];
        self.hPMLabel.text=[NSString stringWithFormat:@"%@", self.dataDict[@"HPM25"]];
        
        CGFloat ihai=[self.dataDict[@"IHAI"] floatValue];
        CGFloat strokeEnd=ihai/100;
        [UIView animateWithDuration:0.3 animations:^{
//            self.frontShapeLayer.strokeStart=0;
            self.frontShapeLayer.strokeEnd=strokeEnd;
        }];
    }
}

#pragma mark - lazyload
- (UIButton *)displayBtn {
    if (!_displayBtn) {
        _displayBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_displayBtn setTitle:@"IHAI>" forState:UIControlStateNormal];
        _displayBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        _displayBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [_displayBtn setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
    }
    return _displayBtn;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel=[[UILabel alloc] init];
        _dayLabel.text=@"--";
        _dayLabel.textColor=WhiteColor;
        _dayLabel.textAlignment=NSTextAlignmentCenter;
        _dayLabel.backgroundColor=CONTROL_COLOR;
        _dayLabel.font=[UIFont systemFontOfSize:13];
        _dayLabel.layer.masksToBounds=YES;
        _dayLabel.layer.cornerRadius=11;
    }
    return _dayLabel;
}

- (UILabel *)corLabel {
    if (!_corLabel) {
        _corLabel=[[UILabel alloc] init];
        
        _corLabel.text=@"--";
        _corLabel.textColor=RGBCOLOR(50, 50, 50);
        _corLabel.textAlignment=NSTextAlignmentRight;
        _corLabel.font=[UIFont systemFontOfSize:15];
    }
    return _corLabel;
}

- (UILabel *)ihaiLabel {
    if (!_ihaiLabel) {
        _ihaiLabel=[[UILabel alloc] init];
        _ihaiLabel.text=@"--";
        _ihaiLabel.textAlignment=NSTextAlignmentCenter;
        _ihaiLabel.font=[UIFont systemFontOfSize:36];
    }
    return _ihaiLabel;
}
- (UILabel *)sPMLabel {
    if (!_sPMLabel) {
        _sPMLabel=[[UILabel alloc] init];
        _sPMLabel.text=@"--";
        _sPMLabel.textAlignment=NSTextAlignmentCenter;
        _sPMLabel.font=[UIFont systemFontOfSize:15];
    }
    return _sPMLabel;
}

- (UILabel *)hPMLabel {
    if (!_hPMLabel) {
        _hPMLabel=[[UILabel alloc] init];
        _hPMLabel.text=@"--";
        _hPMLabel.textAlignment=NSTextAlignmentCenter;
        _hPMLabel.font=[UIFont systemFontOfSize:15];
    }
    return _hPMLabel;
}

- (UILabel *)roominLabel {
    if (!_roominLabel) {
        _roominLabel=[[UILabel alloc] init];
        _roominLabel.text=@"室内PM2.5";
        _roominLabel.textAlignment=NSTextAlignmentCenter;
        _roominLabel.font=[UIFont systemFontOfSize:12];
        _roominLabel.textColor=LightGrayColor;
    }
    return _roominLabel;
}

- (UILabel *)roomoutLabel {
    if (!_roomoutLabel) {
        _roomoutLabel=[[UILabel alloc] init];
        _roomoutLabel.text=@"室外PM2.5";
        _roomoutLabel.textAlignment=NSTextAlignmentCenter;
        _roomoutLabel.font=[UIFont systemFontOfSize:12];
        _roomoutLabel.textColor=LightGrayColor;
    }
    return _roomoutLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView=[UIView new];
        _lineView.backgroundColor=LightGrayColor;
    }
    return _lineView;
}

- (CAShapeLayer *)bacShapeLayer {
    if (!_bacShapeLayer) {
        UIBezierPath *bezierpath=[UIBezierPath bezierPathWithArcCenter:self.contentView.center radius:65 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        _bacShapeLayer=[CAShapeLayer layer];
        _bacShapeLayer.path=bezierpath.CGPath;
        _bacShapeLayer.lineWidth=5;
        _bacShapeLayer.strokeColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:237/255.0 alpha:1.0f].CGColor;
        _bacShapeLayer.fillColor=nil;
    }
    return _bacShapeLayer;
}

- (CAShapeLayer *)frontShapeLayer {
    if (!_frontShapeLayer) {
        
        
        UIBezierPath *bezierpath=[UIBezierPath bezierPathWithArcCenter:self.contentView.center radius:65 startAngle:M_PI*1.5 endAngle:M_PI*3.5 clockwise:YES];
        _frontShapeLayer=[CAShapeLayer layer];
        _frontShapeLayer.path=bezierpath.CGPath;
        _frontShapeLayer.lineWidth=5;
        _frontShapeLayer.strokeColor=CONTROL_COLOR.CGColor;
        _frontShapeLayer.fillColor=nil;
        _frontShapeLayer.strokeStart=0;
        _frontShapeLayer.strokeEnd=0;
    }
    return _frontShapeLayer;
}




@end
