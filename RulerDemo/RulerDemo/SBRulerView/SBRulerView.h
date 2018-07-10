//
//  SBRulerView.h
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//  标尺刻度view

#import <UIKit/UIKit.h>

@interface SBRulerView : UIView

///标记是否是占位cell绘制
///最大值占位
@property (nonatomic, assign) BOOL isPlaholderCell_Max;
///最小值占位
@property (nonatomic, assign) BOOL isPlaholderCell_Min;

@property (nonatomic, assign) NSInteger betweenNumber;
@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, assign) NSInteger maxValue;
///单位 后期预置设置
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) CGFloat step;

@end
