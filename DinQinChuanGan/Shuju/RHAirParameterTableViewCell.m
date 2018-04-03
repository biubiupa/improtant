//
//  RHAirParameterTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAirParameterTableViewCell.h"
#import "Header.h"
#import "Masonry.h"
#import "PNChart.h"

@interface RHAirParameterTableViewCell()
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *paraLabel;

@end

@implementation RHAirParameterTableViewCell

#pragma mark - 初始化，布局
//初始化cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.markView];
        [self.contentView addSubview:self.paraLabel];
    }
    
    return self;
}

//布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2, 14));
        make.top.equalTo(self.contentView).with.offset(21);
        make.left.equalTo(self.contentView).with.offset(20);
    }];
    [self.paraLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85, 14));
        make.top.equalTo(self.contentView).with.offset(21);
        make.left.equalTo(self.contentView).with.offset(30);
    }];
    
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    // 是否显示xy 轴的数字
    barChart.showLabel = YES;
    // 是否显示水平线 但把柱子压低上移了
//        barChart.showLevelLine = YES;
    //是否显示xy 轴
    barChart.showChartBorder = YES;
    // 是否显示柿子的数值
    barChart.isShowNumbers = YES;
    // 立体显示
    barChart.isGradientShow = YES;
    // 设置柱子的圆角
    barChart.barRadius = 5;
    // 设置bar color
    barChart.strokeColor = [UIColor redColor];
    
    barChart.xLabels = @[@"1",@"2",@"3",@"4",@"5"];
    
    barChart.yValues = @[@"2",@"4",@"1",@"10",@"9"];
    
    barChart.yLabelFormatter = ^ (CGFloat yLabelValue) {
        
        return [NSString stringWithFormat:@"%f",yLabelValue];
    };
    
    [barChart strokeChart];
    
    [self.contentView addSubview:barChart];
    
    
    
    
}

#pragma mark - lazyload
- (UIView *)markView {
    if (!_markView) {
        _markView=[UIView new];
        _markView.backgroundColor=CONTROL_COLOR;
    }
    return _markView;
}

- (UILabel *)paraLabel {
    if (!_paraLabel) {
        _paraLabel=[[UILabel alloc] init];
        _paraLabel.textAlignment=NSTextAlignmentLeft;
        _paraLabel.font=[UIFont systemFontOfSize:15.0f];
        _paraLabel.text=@"空气参数";
    }
    return _paraLabel;
}

@end
