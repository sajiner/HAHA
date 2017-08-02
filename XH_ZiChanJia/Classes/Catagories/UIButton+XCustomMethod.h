//
//  UIButton+XCustomMethod.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XCustomMethod)

+ (instancetype)buttonWithTitle: (NSString *)title target: (id)target action: (SEL)action;

+ (instancetype)buttonWithFrame: (CGRect)frame title:(NSString *)title titleColor: (UIColor *)titleColor titleFont: (UIFont *)titleFont image: (UIImage *)image;

@end
