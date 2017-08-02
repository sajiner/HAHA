//
//  NSNumber+XDecimalString.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************
 *
 *  数字转换为以逗号分隔的字符串
 *
 *****************************************/
@interface NSNumber (XDecimalString)

/**
 *  转换为以逗号分隔的字符串
 */
-(NSString *)decimalString;


@end
