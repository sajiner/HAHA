//
//  UILabel+XCustomMethod.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "UILabel+XCustomMethod.h"

@implementation UILabel (XCustomMethod)

+ (instancetype)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.text = text;
    label.textColor = textColor;
    if ([label.text containsString:@"（元）"]) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:label.text];
        [attributedStr addAttributes:@{
                                      NSFontAttributeName: [XAppContext appFonts].font_12,
                                      NSForegroundColorAttributeName: [XAppContext appColors].lightGrayColor
                                      }range:NSMakeRange(label.text.length - 3, 3)];
        label.attributedText = attributedStr;
    }
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    return label;
}

+ (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment{
    UILabel *labeel = [UILabel labelWithFont:font text:text textColor:color];
    labeel.frame = frame;
    labeel.textAlignment = textAlignment;
    return labeel;
}

@end
