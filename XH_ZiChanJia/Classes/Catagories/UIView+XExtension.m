//
//  UIView+XExtension.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "UIView+XExtension.h"

@implementation UIView (XExtension)

- (void)label: (UILabel *)label withTitle: (NSString *)title content: (NSString *)content contentFont: (UIFont *)contentFont contentColor: (UIColor *)contentColor {
    label.text = [NSString stringWithFormat:@"%@\n%@", content, title];
    label.attributedText = [label.text stringWithContent:content title:title contentFont:contentFont contentColor:contentColor];
    label.textAlignment = NSTextAlignmentCenter;
}


@end
