//
//  SBRulerViewConfiguration.h
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//  尺子属性配置类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RVCShareIns  [SBRulerViewConfiguration shareInstance]

@interface SBRulerViewConfiguration : NSObject

+ (SBRulerViewConfiguration *)shareInstance;

/// 小刻度单位距离 <默认 10  10等分> = <50 2等分>
@property (nonatomic, assign) CGFloat rulerGap;///比如每个小刻度5 width 。分10等分。1~10 为一个分区总长度50
/// 短刻度细线 距离标尺bottom 距离<默认 80>
@property (nonatomic, assign) CGFloat rulerLong;///比如标尺height 100,那么短线height 100 - rulerLong;
/// 长刻度粗线 距离标尺bottom 距离<默认 60>
@property (nonatomic, assign) CGFloat rulerShort;///比如标尺height 100,那么长线height 100 - rulerShort;

/// 短刻度细线 W
@property (nonatomic, assign) CGFloat rulerLong_W;
/// 长刻度粗线 W
@property (nonatomic, assign) CGFloat rulerShort_W;

/// 标尺指示三角形 边长<默认 25>
@property (nonatomic, assign) CGFloat trangle_W;
/// 标尺高度<默认 100>
@property (nonatomic, assign) CGFloat rulerView_H;
/// 刻度文字 字体
@property (nonatomic, assign) CGFloat rulerFont;///注：字体与字体绘制高度一定匹配，高度不够字体大会错乱
/// 刻度文字 绘制高度<默认 30>
@property (nonatomic, assign) CGFloat rulerTitle_H;
/// 刻度文字 与 分割线间距
@property (nonatomic, assign) CGFloat rulerTitle_Padding;

/// 标尺指示三角形 颜色 <默认 白色>
@property(nonatomic, strong) UIColor *triangle_Color;
/// 标尺 背景颜色 <默认 254,210,10>
@property(nonatomic, strong) UIColor *rulerView_BGColor;
/// 标尺 文本颜色
@property(nonatomic, strong) UIColor *rulerTitle_Color;

/// 刻度线颜色设置
//红<0~255>
@property (nonatomic, assign) CGFloat red;
//绿<0~255>
@property (nonatomic, assign) CGFloat green;
//蓝<0~255>
@property (nonatomic, assign) CGFloat blue;
//颜色alpha<0~1>
@property (nonatomic, assign) CGFloat alpha;

// ================================== 标尺collectionView设置  =====================
/// 间隔值 每两条刻度线相隔多少值
@property(nonatomic, assign) CGFloat step;
/// 每个区间分为几个小刻度
@property(nonatomic, assign) NSInteger betweenNum;
/// 最大值
@property(nonatomic, assign) CGFloat maxValue;
/// 最小值
@property(nonatomic, assign) CGFloat minValue;
/// 单位
@property(nonatomic, copy) NSString *unit;
// =============================

@end
