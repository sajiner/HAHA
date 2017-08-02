//
//  XVerifiSmsCodeApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//验证短信验证码是否正确API
@interface XVerifiSmsCodeApi : XRequestApi

- (instancetype)initWithPhone:(NSString *)phone phoneCode:(NSString *)phoneCode;
@end
