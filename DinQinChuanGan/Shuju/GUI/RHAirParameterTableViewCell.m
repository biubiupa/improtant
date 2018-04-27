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
#import "Charts-bridging.h"
#import "RHArrowView.h"

@interface RHAirParameterTableViewCell()<ChartViewDelegate, IChartAxisValueFormatter, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *paraLabel;
@property (nonatomic, strong) BarChartView *barChartView;
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIImageView *allImgView;
@property (nonatomic, strong) UIButton *dateBtn;
@property (nonatomic, strong) UIButton *kindBtn;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *kindLabel;
@property (nonatomic, strong) UIImageView *dateImgView;
@property (nonatomic, strong) UIImageView *kindImgView;
@property (nonatomic, strong) RHArrowView *kindView;
@property (nonatomic, strong) RHArrowView *dateView;
@property (nonatomic, copy) NSArray *dateArr;
@property (nonatomic, copy) NSArray *kindArr;
@property (nonatomic, assign) BOOL listState;
@property (nonatomic, assign) NSInteger tager;
@property (nonatomic, strong) UIView *maskView;


@end

@implementation RHAirParameterTableViewCell

#pragma mark - 初始化，布局
//初始化cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.markView];
        [self.contentView addSubview:self.paraLabel];
        [self.contentView addSubview:self.dateBtn];
        [self.contentView addSubview:self.kindBtn];
        [self.dateBtn addSubview:self.dateLabel];
        [self.dateBtn addSubview:self.dateImgView];
        [self.kindBtn addSubview:self.kindLabel];
        [self.kindBtn addSubview:self.kindImgView];
        self.listState=YES;

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
    
    [self buildChartView];
    
    [self.contentView addSubview:self.allBtn];
    [self.allBtn addSubview:self.allLabel];
    [self.allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 15));
        make.centerY.equalTo(self.allBtn);
        make.left.equalTo(self.allBtn).with.offset(20);
    }];
    
    [self.allBtn addSubview:self.allImgView];
    [self.allImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(5, 9));
        make.centerY.equalTo(self.allBtn);
        make.right.equalTo(self.allBtn).with.offset(-20);
    }];
    
//    日期和种类
    [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
        make.top.equalTo(self.contentView).with.offset(21);
        make.right.equalTo(self.contentView).with.offset(-82);
    }];
    
    [self.kindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
        make.top.equalTo(self.contentView).with.offset(21);
        make.right.equalTo(self.contentView).with.offset(-8);
    }];
    
//    带尖头的view
    self.dateView=[[RHArrowView alloc] initWithFrame:CGRectMake(0, 0, 94, 6)];
    self.dateView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.dateView];
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(94, 6));
        make.top.equalTo(self.dateBtn).with.offset(21);
        make.right.equalTo(self.dateBtn).with.offset(0);
    }];
    
    self.kindView=[[RHArrowView alloc] init];
    self.kindView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.kindView];
    [self.kindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(94, 6));
        make.top.equalTo(self.kindBtn).with.offset(21);
        make.right.equalTo(self.kindBtn).with.offset(0);
    }];
    
    
    
    //    添加视图
    [self.contentView addSubview:self.dateTableView];
    [self.dateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(94, 0));
        make.top.equalTo(self.dateBtn).with.offset(27);
        make.right.equalTo(self.dateBtn).with.offset(0);
    }];
    [self.contentView addSubview:self.kindTableView];
    [self.kindTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(94, 0));
        make.top.equalTo(self.kindBtn).with.offset(27);
        make.right.equalTo(self.kindBtn).with.offset(0);
    }];
    

    //    日期和污染种类按钮子视图布局
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 20));
        make.centerY.equalTo(self.dateBtn);
        make.left.equalTo(self.dateBtn).with.offset(25);
    }];
    [self.dateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(5, 4));
        make.centerY.equalTo(self.dateLabel);
        make.left.equalTo(self.dateLabel).with.offset(18);
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 20));
        make.centerY.equalTo(self.kindBtn);
        make.left.equalTo(self.kindBtn).with.offset(10);
    }];
    [self.kindImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(5, 4));
        make.centerY.equalTo(self.kindLabel);
        make.right.equalTo(self.kindLabel).with.offset(8);
    }];

}



//柱状图
- (void)buildChartView {
    //      添加柱状图
    BarChartView *barChartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
    barChartView.delegate=self;
    [self.contentView addSubview:barChartView];
    self.barChartView = barChartView;
    //    self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.barChartView.backgroundColor=WhiteColor;
    self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
    self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
    self.barChartView.scaleYEnabled = NO;//缩放
    self.barChartView.scaleXEnabled=NO;
    self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.barChartView.dragEnabled = YES;//启用拖拽图表
    self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
    //   X轴样式
    ChartXAxis *xAxis = barChartView.xAxis;
    xAxis.axisLineWidth = 1;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//是否绘制网格线
    xAxis.forceLabelsEnabled = YES;
    xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
    
    
    ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
    leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 0.5;//Y轴线宽
    //    leftAxis.forceLabelsEnabled = YES;
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    leftAxis.axisMinimum = 0;
    
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    
    barChartView.rightAxis.enabled = NO;
    
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
    limitLine.lineWidth = 2;
    limitLine.lineColor = [UIColor greenColor];
    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
    [leftAxis addLimitLine:limitLine];//添加到Y轴上
    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
    
    self.barChartView.legend.enabled = NO;//不显示图例说明
    self.barChartView.chartDescription.text = @"";//不显示，就设为空字符串
//    设置marker
    
    
   
    
    BalloonMarker *marker=[[BalloonMarker alloc] initWithColor:CONTROL_COLOR font:[UIFont systemFontOfSize:12] textColor:WhiteColor insets:UIEdgeInsetsMake(8, 8, 20, 8)];

    marker.chartView=self.barChartView;
    marker.minimumSize=CGSizeMake(50, 15);

    self.barChartView.marker=marker;
    
    //---------------------------------------------------------------------------
//        x轴数据
//        NSMutableArray *xValues=[NSMutableArray array];
//        for (int i = 0; i < 288; ++i) {
//            int time=i/12;
//            [xValues addObject:[NSString stringWithFormat:@"%d",time]];
//        }
////    xAxis.axisMaximum=(double)xValues.count+0+0.0;
//    xAxis.valueFormatter=[[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];
    
    xAxis.labelCount=3;
    
    self.barChartView.xAxis.valueFormatter=self;
    // y轴数据
    NSMutableArray *yValues=[NSMutableArray array];
    NSMutableArray *colorarr=[NSMutableArray array];
    for (int i = 0; i < 288; i ++) {
        
        double y = (arc4random_uniform(40));
        
        BarChartDataEntry *yEntry = [[BarChartDataEntry alloc] initWithX:i y:y];
        [yValues addObject:yEntry];
        //        BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yEntry label:@"data set"];
        if (y > 35) {
            [colorarr addObject:CONTROL_COLOR];
        }else if(y < 15){
            [colorarr addObject:[UIColor redColor]];
        }else {
            [colorarr addObject:[UIColor greenColor]];
        }
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yValues label:@"data set"];
    
    
//    [set1 setColor:CONTROL_COLOR];// 柱状图颜色
    [set1 setColors:colorarr];
    //是否面板上直接显示数值
    //    set1.version
    set1.drawValuesEnabled = NO;
    
    // 赋值数据
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];

    //    data.barWidth=0.5;
    self.barChartView.data = data;
    //    [self.barChartView setAutoScaleMinMaxEnabled:YES];
    
    //      设置柱状图的个数,以下两种方法均可，当用缩放比例时，比例系数为：总数/需要显示的个数
        [self.barChartView setVisibleXRangeMaximum:48.0f];
//    [self.barChartView zoomWithScaleX:6.0 scaleY:1.0f x:0.f y:0.f];

}

//代理
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    NSArray *arrTwo=@[@"无限规格", @"语音播报", @"指示灯", @"显示屏", @"电池"];
    return arrTwo[3];
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight {
}

- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
//    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
}

- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.dateTableView) {
        return self.dateArr.count;
    }else {
        return self.envirLists.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.dateTableView) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=self.dateArr[indexPath.row];
        cell.textLabel.font=SYSTEMFONT(14);
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=RGBCOLOR(50, 50, 50);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=[NSString stringWithFormat:@"%@",self.envirLists[indexPath.row][@"parameter"]];
        cell.textLabel.font=SYSTEMFONT(14);
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=RGBCOLOR(50, 50, 50);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.dateTableView) {
        self.dateLabel.text=cell.textLabel.text;
    }else {
        self.kindLabel.text=cell.textLabel.text;
    }
    [self pullList];
    self.listState=!self.listState;
}



#pragma mark - all of kinds actions
- (void)dropList {
    CGRect frame;
    
    if (self.tager == 100) {
        frame=self.dateTableView.frame;
        frame.size.height=self.dateArr.count * 28;

        
        [UIView animateWithDuration:0.2 animations:^{
            self.dateTableView.frame=frame;
        }];
    }else {
        frame=self.kindTableView.frame;
        frame.size.height=self.envirLists.count * 28;
        
        
        [UIView animateWithDuration:0.2 animations:^{
            self.kindTableView.frame=frame;
        }];
    }
    
}

- (void)pullList {
    CGRect frame;
    if (self.tager == 100) {
        frame=self.dateTableView.frame;
        frame.size.height=0;
        
       
        
        [UIView animateWithDuration:0.2 animations:^{
            self.dateTableView.frame=frame;
        }];
    }else {
        frame=self.kindTableView.frame;
        frame.size.height=0;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.kindTableView.frame=frame;
        }];
    }
}

- (void)dropAndPullAction:(UIButton *)sender {
    self.tager=sender.tag;
    self.listState ? [self dropList] :[self pullList];
    self.listState=!self.listState;
}

#pragma mark - lazyload
- (UITableView *)dateTableView {
    if (!_dateTableView) {
        _dateTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 6, 94, 0) style:UITableViewStylePlain];
        _dateTableView.delegate=self;
        _dateTableView.dataSource=self;
        _dateTableView.rowHeight=28;
    }
    return _dateTableView;
}

- (UITableView *)kindTableView {
    if (!_kindTableView) {
        _kindTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 6, 94, 0) style:UITableViewStylePlain];
        _kindTableView.delegate=self;
        _kindTableView.dataSource=self;
        _kindTableView.rowHeight=28;
    }
    return _kindTableView;
}

- (NSArray *)dateArr {
    if (!_dateArr) {
        _dateArr=@[@"日",@"周",@"月",@"年"];
    }
    return _dateArr;
}

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

- (UIButton *)allBtn {
    if (!_allBtn) {
        _allBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _allBtn.frame=CGRectMake(0, 335, SCREEN_WIDTH, 25);
        _allBtn.backgroundColor=BACKGROUND_COLOR;
//        [_allBtn addTarget:self action:@selector(moveEquipment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allBtn;
}

- (UILabel *)allLabel {
    if (!_allLabel) {
        _allLabel=[[UILabel alloc] init];
        _allLabel.textAlignment=NSTextAlignmentLeft;
        _allLabel.font=[UIFont systemFontOfSize:12];
        _allLabel.text=@"所有数据";
    }
    return _allLabel;
}

- (UIImageView *)allImgView {
    if (!_allImgView) {
        _allImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    }
    return _allImgView;
}

- (UIButton *)dateBtn {
    if (!_dateBtn) {
        _dateBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _dateBtn.tag=100;
        _dateBtn.layer.cornerRadius=10;
        _dateBtn.layer.borderWidth=1;
        _dateBtn.layer.borderColor=RGBCOLOR(211, 211, 211).CGColor;
        [_dateBtn addTarget:self action:@selector(dropAndPullAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateBtn;
}

- (UIButton *)kindBtn {
    if (!_kindBtn) {
        _kindBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _kindBtn.tag=200;
        _kindBtn.layer.cornerRadius=10;
        _kindBtn.layer.borderWidth=1;
        _kindBtn.layer.borderColor=RGBCOLOR(211, 211, 211).CGColor;
        [_kindBtn addTarget:self action:@selector(dropAndPullAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kindBtn;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel=[[UILabel alloc] init];
        _dateLabel.font=[UIFont systemFontOfSize:14];
        _dateLabel.textAlignment=NSTextAlignmentCenter;
        _dateLabel.textColor=RGBCOLOR(50, 50, 50);
        _dateLabel.text=@"日";
    }
    return _dateLabel;
}

- (UILabel *)kindLabel {
    if (!_kindLabel) {
        _kindLabel=[[UILabel alloc] init];
        _kindLabel.font=[UIFont systemFontOfSize:14];
        _kindLabel.textAlignment=NSTextAlignmentCenter;
        _kindLabel.text=@"PM2.5";
        _kindLabel.textColor=RGBCOLOR(50, 50, 50);
    }
    return _kindLabel;
}

- (UIImageView *)dateImgView {
    if (!_dateImgView) {
        _dateImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop"]];
    }
    return _dateImgView;
}

- (UIImageView *)kindImgView {
    if (!_kindImgView) {
        _kindImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop"]];
    }
    return _kindImgView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView=[[UIView alloc] initWithFrame:self.bounds];
        _maskView.alpha=0;
    }
    return _maskView;
}



@end
