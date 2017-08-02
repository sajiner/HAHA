//
//  XSanBiaoDetailTopView.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSanBiaoDetailProgress.h"

@interface XSanBiaoDetailTopView : UIView
//百分比
@property(nonatomic,copy)NSString *percent;
//文字
@property(nonatomic,copy)NSString *text;
//view背景色
@property(nonatomic,strong)UIColor *viewBackgroundColor;
//track背景色
@property(nonatomic,strong)UIColor *progressTrackColor;
//progress颜色
@property(nonatomic,strong)UIColor *progressColor;
//progress宽度
@property(nonatomic,assign)CGFloat progressStrokeWidth;

@property(nonatomic,assign)CGFloat progressValue;

//圆环View
@property(nonatomic,strong)XSanBiaoDetailProgress *progressView;
//star
@property(nonatomic,strong)UIImageView *starImg;

//百分比Label
@property(nonatomic,strong)UILabel *percentLabel;
//文字Label
@property(nonatomic,strong)UILabel *textlabel;

@end
