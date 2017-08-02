//
//  XVerifiRealNameApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//实名认证API
@interface XVerifiRealNameApi : XRequestApi

- (instancetype)initWithToken:(NSString *)token realName:(NSString *)realName identity:(NSString *)identity realNameSource:(NSString *)realNameSource;

@end
