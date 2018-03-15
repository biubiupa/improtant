//
//  ViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/14.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "ShujuViewController.h"
#import "Masonry.h"
#import "Header.h"
#import "PNChart.h"

@interface ShujuViewController ()

@end

@implementation ShujuViewController

#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - layoutViews
- (void)layoutViews {
    self.view.backgroundColor=WhiteColor;
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    //设置x的值
    [barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    //设置y的值
    [barChart setYValues:@[@1,  @10, @2, @6, @3]];
    //设置是否显示坐标轴
    barChart.showChartBorder = YES;
    //设置柱子的圆角
    barChart.barRadius = 5;
    //设置柱子的宽度
    barChart.barWidth = 10;
    //设置渲染颜色
    barChart.strokeColor = [UIColor colorWithRed:51/255. green:121/255. blue:242/255. alpha:1];
    //设置是否立体显示（有一个渐变色的效果）
    barChart.isGradientShow = NO;
    //设置是否显示数值
    barChart.isShowNumbers = YES;
    //开始绘制图标
    [barChart strokeChart];
    [self.view addSubview:barChart];
    
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:20 color:[UIColor redColor] description:@"颜华"],[PNPieChartDataItem dataItemWithValue:40 color:[UIColor greenColor] description:@"佳佳"],[PNPieChartDataItem dataItemWithValue:40 color:[UIColor blueColor] description:@"小徐"]];
    //初始化
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 300, 200, 200) items:items];
    pieChart.center = self.view.center;
    //获得图例
    UIView *legend = [pieChart getLegendWithMaxWidth:100];
    legend.frame = CGRectMake(50, self.view.frame.size.height / 2, legend.bounds.size.width, legend.bounds.size.height);
    [self.view addSubview:legend];
    //设置是否显示图例
    pieChart.hasLegend = YES;
    //设置图例样式
    pieChart.legendStyle = PNLegendItemStyleSerial;
    //设置图例位置
    pieChart.legendPosition = PNLegendPositionTop;
    //绘制饼状图
    [pieChart strokeChart];
    
    [self.view addSubview:pieChart];
}


//修改状态栏（也就是手机运营商和电池所在的那栏）的风格，以下为亮色，系统默认的是暗色；
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}




@end
