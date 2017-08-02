//
//  XResetPwdApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//重置密码API
@interface XResetPwdApi : XRequestApi

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password identity:(NSString *)identity origin:(NSString *)origin modifyIp:(NSString *)modifyIp phoneCode:(NSString *)phoneCode type:(NSString *)type realName:(NSString *)realName;

@end
