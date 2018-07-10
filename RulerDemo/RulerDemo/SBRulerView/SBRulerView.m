//
//  SBRulerView.m
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "SBRulerView.h"
#import "SBRulerViewConfiguration.h"

@implementation SBRulerView

///绘制刻度
- (void)drawRect:(CGRect)rect{
    CGFloat startX = 0;
    CGFloat lineCenterX = RVCShareIns.rulerGap;
    CGFloat shortLineY  = rect.size.height - RVCShareIns.rulerLong;
    CGFloat longLineY = rect.size.height - RVCShareIns.rulerShort;
    CGFloat topY = 0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context,kCGLineCapButt);
    CGContextSetRGBStrokeColor(context, RVCShareIns.red / 255.0, RVCShareIns.green / 255.0, RVCShareIns.blue / 255.0, RVCShareIns.alpha);//设置线的颜色，默认是白色
    for (int i = 0; i <= _betweenNumber; i ++){///长线绘制
        BOOL isGrawLine = YES;///标记占位cell是否需要绘制 刻度与 区间值
        if (self.isPlaholderCell_Max) {
            if (i != 0) {
                isGrawLine = NO;
            }
            CGContextMoveToPoint(context, startX+lineCenterX*i, topY);
        }else if(self.isPlaholderCell_Min){
            if (i != _betweenNumber) {
                isGrawLine = NO;
            }else{
                CGContextMoveToPoint(context, rect.size.width, 0);
            }
        }else{
            CGContextMoveToPoint(context, startX+lineCenterX*i, topY);
        }
        if (i % _betweenNumber == 0){
            CGContextSetLineWidth(context, RVCShareIns.rulerShort_W);//设置线的宽度，
            NSString *num = [NSString stringWithFormat:@"%.f%@",i * _step + _minValue , _unit];
            if ([num floatValue] > 1000000){///过长文本处理
                num = [NSString stringWithFormat:@"%.f万%@",[num floatValue]/10000.f,_unit];
            }
            if (isGrawLine) {
                NSDictionary *attribute = @{ NSFontAttributeName : [UIFont systemFontOfSize:RVCShareIns.rulerFont], NSForegroundColorAttributeName : RVCShareIns.rulerTitle_Color};
                CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
                CGContextSetRGBStrokeColor(context, RVCShareIns.red / 255.0, RVCShareIns.green / 255.0, RVCShareIns.blue / 255.0, RVCShareIns.alpha);
                if (self.isPlaholderCell_Min) {
                    CGContextAddLineToPoint(context,rect.size.width, longLineY);
                    [num drawInRect:CGRectMake(rect.size.width - width / 2, longLineY + RVCShareIns.rulerTitle_Padding, width, RVCShareIns.rulerTitle_H) withAttributes:attribute];
                }else{
                   CGContextAddLineToPoint(context, startX + lineCenterX * i, longLineY);
                    [num drawInRect:CGRectMake(startX + lineCenterX * i - width / 2, longLineY + RVCShareIns.rulerTitle_Padding, width, RVCShareIns.rulerTitle_H) withAttributes:attribute];
                }
            }
        }else{///短线绘制
            if (!self.isPlaholderCell_Max && !self.isPlaholderCell_Min) {
                CGContextSetLineWidth(context, RVCShareIns.rulerLong_W);//设置线的宽度，
                CGContextSetRGBStrokeColor(context, RVCShareIns.red / 255.0, RVCShareIns.green / 255.0, RVCShareIns.blue / 255.0, RVCShareIns.alpha);
                CGContextAddLineToPoint(context, startX+lineCenterX*i, shortLineY);
            }
        }
        CGContextStrokePath(context);//开始绘制
    }
}


@end
