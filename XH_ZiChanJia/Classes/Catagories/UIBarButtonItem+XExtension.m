//
//  UIBarButtonItem+XExtension.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/30.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "UIBarButtonItem+XExtension.h"

@implementation UIBarButtonItem (XExtension)

+ (instancetype)itemWithNorImageName:(NSString *)norImageName selImageName:(NSString *)selImageName target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
