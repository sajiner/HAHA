//
//  XCommonUtils.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

/***************************************
 *
 * 通用工具类
 *
 ***************************************/
@interface XCommonUtils : NSObject

/** 单例的实现方式 */
+(XCommonUtils *) context;

/** 检查是不是手机号 */
+ (BOOL)checkTel:(NSString *)string;

/** 正则匹配用户密码6-18位数字和字母组合 */
+ (BOOL)checkPassword:(NSString *) password;

/** 正则匹配用户身份证号15或18位  */
+ (BOOL)checkUserIdCard: (NSString *) idCard;

/** 正则匹配是不是纯数字  */
+ (BOOL)checkNumber: (NSString *) number;

@end
