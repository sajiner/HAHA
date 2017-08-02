//
//  XMySanBiaoUserInMoneyApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 我的散标接口（获取待收本金、待收收益、累计收益）
 *
 *****************************************/
@interface XMySanBiaoUserInMoneyApi : XRequestApi

- (instancetype)initWithToken: (NSString *)token;

@end
