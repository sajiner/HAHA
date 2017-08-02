//
//  XSanBiaoDetailProgress.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSanBiaoDetailProgress : UIView

/**
 *  圆环进度值0-1之间
 */
@property(nonatomic,assign)CGFloat progressValue;
/**
 *  圆环边宽
 */
@property(nonatomic,assign)CGFloat progressStrokeWidth;
/**
 *  进度条颜色(前景)
 */
@property(nonatomic,strong)UIColor *progressColor;
/**
 *  进度条轨道颜色（背景）
 */
@property(nonatomic,strong)UIColor *progressTrackColor;
/**
 *  背景图层
 */
@property(nonatomic,strong)CAShapeLayer *backgroundLayer;
/**
 *  用来填充的图层
 */
@property(nonatomic,strong)CAShapeLayer *frontFillLayer;
/**
 *  背景贝塞尔曲线
 */
@property(nonatomic,strong)UIBezierPath *backgroundBezierPath;
/**
 *  填充的贝塞尔曲线
 */
@property(nonatomic,strong)UIBezierPath *frontFillBezierPath;


@end
