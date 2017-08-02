//
//  XSanBiaoDetailProgress.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoDetailProgress.h"

@implementation XSanBiaoDetailProgress



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    //初始化背景图层
    self.backgroundLayer = [CAShapeLayer layer];
    self.backgroundLayer.fillColor = nil;
    self.backgroundLayer.frame = self.bounds;
    //初始化前景图层
    self.frontFillLayer = [CAShapeLayer layer];
    self.frontFillLayer.fillColor = nil;
    self.frontFillLayer.frame = self.bounds;
    
    [self.layer addSublayer:self.backgroundLayer];
    [self.layer addSublayer:self.frontFillLayer];
}

-(void)setProgressColor:(UIColor *)progressColor{
    _frontFillLayer.strokeColor = progressColor.CGColor;
}

-(void)setProgressTrackColor:(UIColor *)progressTrackColor{
    _backgroundLayer.strokeColor = progressTrackColor.CGColor;
    _backgroundBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.height / 2.0, self.frame.size.height / 2.0) radius:(CGRectGetWidth(self.bounds) - self.progressStrokeWidth) / 2.0 startAngle:0.42 * 2 * M_PI endAngle:1.08 * M_PI * 2 clockwise:YES];
    _backgroundLayer.lineCap = @"round";
    _backgroundLayer.lineJoin = @"round";
    _backgroundLayer.path = self.backgroundBezierPath.CGPath;
}

-(void)setProgressValue:(CGFloat)progressValue{
    _frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.height / 2.0, self.frame.size.height / 2.0) radius:(CGRectGetWidth(self.bounds) - self.progressStrokeWidth) / 2.0 + 4
                                                      startAngle:0.42 * 2 * M_PI endAngle:(0.66 * 2 * M_PI * progressValue + 0.42 * 2 * M_PI) clockwise:YES];
    _frontFillLayer.lineCap = @"round";
    _frontFillLayer.lineJoin = @"round";
    _frontFillLayer.path = self.frontFillBezierPath.CGPath;
}


-(void)setProgressStrokeWidth:(CGFloat)progressStrokeWidth{
    _frontFillLayer.lineWidth = progressStrokeWidth;
    _backgroundLayer.lineWidth = progressStrokeWidth;
}

@end
