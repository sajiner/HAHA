//
//  XLeftAndRightLabelView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLeftAndRightLabelView : UIView
// 内容
@property (nonatomic, copy) NSString *content;
// 内容字体颜色
@property (nonatomic, strong) UIColor *contentColor;

+ (instancetype)viewWithTitleColor: (UIColor *)titleColor titleFont: (UIFont *)titleFont contentColor: (UIColor *)contentColor contentFont: (UIFont *)contentFont title: (NSString *)title;

@end
