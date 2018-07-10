//
//  SBScrollRulerView.h
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//  标尺collectionView展示数据

#import <UIKit/UIKit.h>
#import "SBRulerViewConfiguration.h"

@class SBScrollRulerView;
@protocol SBScrollRulerViewDelegate <NSObject>
/*
 *  游标卡尺滑动，对应value回调
 *  滑动视图
 *  当前滑动的值
 */
- (void)sbScrollRulerView:(SBScrollRulerView *)rulerView valueChange:(float)value;
@end


@interface SBScrollRulerView : UIView
/// 代理
@property(nonatomic, weak) id<SBScrollRulerViewDelegate> delegate;
/// 三角形颜色
@property(nonatomic, strong) UIColor *triangleColor;
/// 背景颜色
@property(nonatomic, strong) UIColor *bgColor;
/// 滑动时是否改变textfield值<textField备用 后期可支持直接输入>
@property(nonatomic, assign)BOOL scrollByHand;


/// 初始化对象方法
- (instancetype)initWithFrame:(CGRect)frame theMinValue:(float)minValue theMaxValue:(float)maxValue theStep:(float)step theUnit:(NSString *)unit theNum:(NSInteger)betweenNum;
/// 设置真实值
- (void)setRealValue:(float)realValue animated:(BOOL)animated;
/// 设置默认值<不带动画>
- (void)setDefaultValue:(float)defaultValue animated:(BOOL)animated;

///重新绘制标尺数据
- (void)reDrawRectRulerView:(SBRulerViewConfiguration *)config;
@end
