//
//  RHWaveView.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/30.
//  Copyright © 2018年 DST. All rights reserved.
//

/**
 正弦曲线公式可表示为y=Asin(ωx+φ)+k：
 A，振幅，最高和最低的距离
 W，角速度，用于控制周期大小，单位x中的起伏个数
 K，偏距，曲线整体上下偏移量
 φ，初相，左右移动的值
 
 这个效果主要的思路是添加两条曲线 一条正玄曲线、一条余弦曲线 然后在曲线下添加深浅不同的背景颜色，从而达到波浪显示的效果
 */

#import "RHWaveView.h"
#import "Header.h"

@interface RHWaveView()
@property (nonatomic, strong) CAShapeLayer *wavelay1;
@property (nonatomic, strong) CAShapeLayer *wavelay2;
@property (nonatomic, strong) CADisplayLink *disPlayLink;
//曲线振幅
@property (nonatomic, assign) CGFloat waveAmplitude;
//曲线角速度
@property (nonatomic, assign) CGFloat wavePalstance;
//曲线初相
@property (nonatomic, assign) CGFloat waveX;
//曲线偏距
@property (nonatomic, assign) CGFloat waveY;
//曲线移动速度
@property (nonatomic, assign) CGFloat waveMoveSpeed;


@end

@implementation RHWaveView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        [self buildData];
    }
    return self;
}

//初始化ui
- (void)buildUI {
//    底层
    self.wavelay1=[CAShapeLayer layer];
    self.wavelay1.fillColor=[UIColor colorWithRed:114/255.0 green:132/255.0 blue:235/255.0 alpha:0.3].CGColor;
    [self.layer addSublayer:self.wavelay1];
//    上层
    self.wavelay2=[CAShapeLayer layer];
    self.wavelay2.fillColor=[UIColor colorWithRed:114/255.0 green:132/255.0 blue:235/255.0 alpha:0.3].CGColor;
    [self.layer addSublayer:self.wavelay2];
}

//初始化数据
- (void)buildData {
    //振幅
    self.waveAmplitude = 10;
    //角速度
   self.wavePalstance = M_PI/self.frame.size.width;
    //偏距
    self.waveY = self.frame.size.height;
    //初相
    self.waveX = 0;
    //x轴移动速度
    self.waveMoveSpeed = _wavePalstance * 2.5;
    self.disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [self.disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
-(void)updateWave:(CADisplayLink *)link
{
    _waveX += _waveMoveSpeed;
    [self updateWaveY];
    [self updateWave1];
    [self updateWave2];
}

//更新偏距的大小 直到达到目标偏距 让wave有一个匀速增长的效果
-(void)updateWaveY
{
    CGFloat targetY = self.bounds.size.height -  self.bounds.size.height/3;
    if (_waveY < targetY) {
        _waveY += 2;
    }
    if (_waveY > targetY ) {
        _waveY -= 2;
    }
}

-(void)updateWave1
{
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, _waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = _waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * sin(_wavePalstance * x + _waveX) + _waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    _wavelay1.path = path;
    CGPathRelease(path);
}

-(void)updateWave2
{
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, _waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = _waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * sin(_wavePalstance * x + _waveX + M_PI) + _waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //添加终点路径、填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    _wavelay2.path = path;
    CGPathRelease(path);
    
}

-(void)stop
{
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
}

-(void)dealloc
{
    [self stop];
    if (_wavelay1) {
        [_wavelay1 removeFromSuperlayer];
        _wavelay1 = nil;
    }
    if (_wavelay2) {
        [_wavelay2 removeFromSuperlayer];
        _wavelay2 = nil;
    }
    
}

@end
