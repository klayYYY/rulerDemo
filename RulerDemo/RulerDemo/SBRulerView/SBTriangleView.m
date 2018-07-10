//
//  SBTriangleView.m
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "SBTriangleView.h"
#import "SBRulerViewConfiguration.h"

@implementation SBTriangleView

///绘制三角形标记
- (void)drawRect:(CGRect)rect{
    //设置背景颜色
    [[UIColor clearColor] set];
    UIRectFill([self bounds]);
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path路径进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, RVCShareIns.trangle_W, 0);
    CGContextAddLineToPoint(context, RVCShareIns.trangle_W / 2.0, RVCShareIns.trangle_W / 2.0);
    CGContextSetLineCap(context, kCGLineCapButt);//线结束时是否绘制端点，该属性不设置。有方形，圆形，自然结束3中设置
    CGContextSetLineJoin(context, kCGLineJoinBevel);//线交叉时设置缺角。有圆角，尖角，缺角3中设置
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [_triangleColor setFill];//设置填充色
    [_triangleColor setStroke];//设置边框色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path，后属性表示填充
}

@end
