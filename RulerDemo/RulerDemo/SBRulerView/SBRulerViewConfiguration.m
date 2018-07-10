//
//  SBRulerViewConfiguration.m
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "SBRulerViewConfiguration.h"

static SBRulerViewConfiguration *sharedRVC = nil;
@implementation SBRulerViewConfiguration

+ (SBRulerViewConfiguration *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRVC = [[super allocWithZone:NULL] init];
        [SBRulerViewConfiguration defaultSetup];
    });
    
    return sharedRVC;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copy {
    return self;
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

///默认配置
+ (void)defaultSetup{
    sharedRVC.triangle_Color = [UIColor whiteColor];
    sharedRVC.rulerView_BGColor = [UIColor colorWithRed: 254 / 255.0 green: 210 / 255.0 blue: 10 / 255.0 alpha:1.0];
    sharedRVC.rulerTitle_Color = [UIColor whiteColor];
    sharedRVC.rulerView_H = 100.f;
    sharedRVC.rulerLong = 80.f;
    sharedRVC.rulerShort = 60.f;
    sharedRVC.trangle_W = 25.f;
    sharedRVC.rulerTitle_H = 30.f;
    sharedRVC.rulerFont = 18.f;
    sharedRVC.rulerTitle_Padding = 30.f;
    sharedRVC.rulerShort_W = 2;
    sharedRVC.rulerLong_W = 1;
    sharedRVC.red = 255;
    sharedRVC.green = 255;
    sharedRVC.blue = 255;
    sharedRVC.alpha = 1;
    sharedRVC.rulerGap = 50.f;
}



///颜色设置 健壮性处理
- (void)setRed:(CGFloat)red{
    if (red > 255) {
        red = 255;
    }
    if (red < 0) {
        red = 0;
    }
    _red = red;
}

- (void)setGreen:(CGFloat)green{
    if (green > 255) {
        green = 255;
    }
    if (green < 0) {
        green = 0;
    }
    _green = green;
}

- (void)setBlue:(CGFloat)blue{
    if (blue > 255) {
        blue = 255;
    }
    if (blue < 0) {
        blue = 0;
    }
    _blue = blue;
}

- (void)setAlpha:(CGFloat)alpha{
    if (alpha > 1) {
        alpha = 1;
    }
    if (alpha < 0) {
        alpha = 0;
    }
    _alpha = alpha;
}
@end
