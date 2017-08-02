//
//  UILabel+XCustomMethod.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XCustomMethod)

/** 通用 */
+ (instancetype)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor;

+ (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;
@end
