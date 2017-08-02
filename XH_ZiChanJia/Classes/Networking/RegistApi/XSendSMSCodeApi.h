//
//  XSendSMSCodeApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//注册-发送短信验证码API
@interface XSendSMSCodeApi : XRequestApi

- (instancetype)initWithType: (NSString *)type phone:(NSString *)phoneNumber uuid:(NSString *)uuid signCode:(NSString *)signCode;

@end
