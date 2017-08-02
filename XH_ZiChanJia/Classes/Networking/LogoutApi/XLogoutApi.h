//
//  XLogoutApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//退出登录API
@interface XLogoutApi : XRequestApi

- (instancetype)initWithToken:(NSString *)token;

@end
