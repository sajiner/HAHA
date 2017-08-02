//
//  XGetBankCardApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//


#import "XRequestApi.h"

/*****************************************
 *
 * 获取银行卡信息api
 *
 *****************************************/
@interface XGetBankCardApi : XRequestApi

- (instancetype)initWithToken: (NSString *)token;

@end
