//
//  XVerifiPhoneNumberApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//注册-验证手机号码是否合法API
@interface XVerifiPhoneNumberApi : XRequestApi

- (instancetype)initWithPhoneNumber: (NSString *)phoneNumber;

@end
