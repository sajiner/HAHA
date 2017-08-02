//
//  XLoginApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//登录API
@interface XLoginApi : XRequestApi

- (instancetype)initWithuUserName:(NSString *)uUserName uPassword:(NSString *)uPassword signUuid:(NSString *)signUuid signCode:(NSString *)signCode modifyIp:(NSString *)modifyIp origin:(NSString *)origin emailAddress:(NSString *)emailAddress;

@end
