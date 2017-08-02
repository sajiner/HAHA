//
//  NSNumber+XDecimalString.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "NSNumber+XDecimalString.h"

/******************************************
 *
 *  数字转换为以逗号分隔的字符串
 *
 *****************************************/
@implementation NSNumber (XDecimalString)

#pragma mark - 转换为以逗号分隔的字符串
-(NSString *)decimalString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *string = [formatter stringFromNumber:self];
    string = [string substringFromIndex:1];
    return string;
}

@end
