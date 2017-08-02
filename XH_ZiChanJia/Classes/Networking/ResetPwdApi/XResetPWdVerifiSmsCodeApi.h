//
//  XResetPWdVerifiSmsCodeApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//重置密码的校验短信验证码
@interface XResetPWdVerifiSmsCodeApi : XRequestApi

- (instancetype)initWithPhone:(NSString *)type signUuid:(NSString *)signUuid signCode:(NSString *)signCode phoneCode:(NSString *)phoneCode ;

@end
