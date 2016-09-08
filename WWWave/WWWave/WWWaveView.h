//
//  WWWaveView.h
//  WWWave
//
//  Created by wangwei on 16/9/8.
//  Copyright © 2016年 wangwei-WW. All rights reserved.
//  Github  Demo  : https://github.com/wwpeter/WW-wave

#import <UIKit/UIKit.h>

#define XNColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

typedef void(^WWWaveBlock)(CGFloat currentY);

@interface WWWaveView : UIView
/**
 *  浪弯曲度
 */
@property (nonatomic, assign) CGFloat waveCurvature;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  实浪颜色
 */
@property (nonatomic, strong) UIColor *realWaveColor;
/**
 *  遮罩浪颜色
 */
@property (nonatomic, strong) UIColor *maskWaveColor;

@property (nonatomic, copy) WWWaveBlock waveBlock;

//外面配置的方法
- (void)setCurvature:(CGFloat)curvature speet:(CGFloat)speed height:(CGFloat)height;
- (void)setRealWaveColor:(UIColor *)realColor maskWaceColor:(UIColor *)maskColor;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;
@end
