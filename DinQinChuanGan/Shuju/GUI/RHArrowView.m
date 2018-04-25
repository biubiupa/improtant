//
//  RHArrowView.m
//  DinQinChuanGan
//
//  Created by malf on 2018/4/13.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHArrowView.h"
#import "Header.h"

#define Arrow_Height    6

@implementation RHArrowView

- (void)drawRect:(CGRect)rect {
    CGRect frame = rect;
    
    frame.origin.y=rect.origin.y + Arrow_Height;
    
    //调用绘制带箭头的
    
    [self drawArrowRectangle:frame];

}

//绘制带箭头的矩形

-(void)drawArrowRectangle:(CGRect)frame

{
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    // 创建一个新的空图形路径。
    
    CGContextBeginPath(ctx);
    
    //启始位置坐标x，y
    
    CGFloat origin_x = frame.origin.x;
    
    CGFloat origin_y = frame.origin.y;
    
    //第一条线的位置坐标
    
    CGFloat line_1_x = frame.size.width - 12;
    
    CGFloat line_1_y = origin_y;
    
    //尖角的顶点位置坐标
    
    CGFloat line_2_x = line_1_x + Arrow_Height/2;
    
    CGFloat line_2_y = origin_y - Arrow_Height;
    
    //第三条线的位置坐标
    
    CGFloat line_3_x = frame.size.width - Arrow_Height;
    
    CGFloat line_3_y = origin_y;
    
    //第四条线的位置坐标
    
    CGFloat line_4_x = frame.size.width;
    
    CGFloat line_4_y = origin_y;
    
    //第五条线位置坐标
    
    CGFloat line_5_x = line_4_x;
    
    CGFloat line_5_y = frame.size.height;
    
    //第六条线位置坐标
    
    CGFloat line_6_x = origin_x;
    
    CGFloat line_6_y = line_5_y;
    
    // 开始画
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    
    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
    
    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
    
    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
    
    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
    
    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
    
    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
    
    CGContextClosePath(ctx);
    
    CGContextSetFillColorWithColor(ctx, WhiteColor.CGColor);
    
    CGContextFillPath(ctx);
}



@end
