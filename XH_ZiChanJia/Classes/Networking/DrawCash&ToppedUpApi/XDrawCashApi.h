//
//  XDrawCashApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 体现api
 *
 *****************************************/
@interface XDrawCashApi : XRequestApi

// client:终端类型 0: PC 1: APP
- (instancetype)initWithToken: (NSString *)token money: (NSString *)money client: (NSString *)client;

@end
