//
//  XSendAccountApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 获取最新的用户信息api(发送给后台)
 *
 *****************************************/
@interface XSendAccountApi : XRequestApi

- (instancetype)initWithToken: (NSString *)token;

@end
