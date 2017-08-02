//
//  UIButton+XCustomMethod.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "UIButton+XCustomMethod.h"

@implementation UIButton (XCustomMethod)

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (instancetype)buttonWithFrame: (CGRect)frame title:(NSString *)title titleColor: (UIColor *)titleColor titleFont: (UIFont *)titleFont image: (UIImage *)image {
    
    UIButton *btn = [[UIButton alloc] initWithFrame: frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    [btn setImage:image forState:UIControlStateNormal];
    return btn;
}

@end
