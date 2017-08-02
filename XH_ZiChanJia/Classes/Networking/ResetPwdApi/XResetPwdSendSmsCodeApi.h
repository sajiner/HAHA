//
//  XResetPwdSendSmsCodeApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//给指定手机号发送手机验证码API（接口和注册时的不一样）
@interface XResetPwdSendSmsCodeApi : XRequestApi
//type：当用于注册发送短信验证码时，此参数传递  “1” ，
//当用于修改登录密码发送短信验证码时，此参数传递 “2”
//当用于找回登录密码短信验证码时，此参数传递  “3”
//当用于修改手机号发送短信验证码时，此参数传递  “4”
- (instancetype)initWithType:(NSString *)type phone:(NSString *)phone uuid:(NSString *)uuid signCode:(NSString *)signCode ;

@end
