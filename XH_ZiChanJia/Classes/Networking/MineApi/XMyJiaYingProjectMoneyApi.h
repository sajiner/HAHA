//
//  XMyJiaYingProjectMoneyApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 我的嘉盈接口（获取待收本金、待收收益、累计收益）
 *
 *****************************************/
@interface XMyJiaYingProjectMoneyApi : XRequestApi

- (instancetype)initWithToken: (NSString *)token;

@end
