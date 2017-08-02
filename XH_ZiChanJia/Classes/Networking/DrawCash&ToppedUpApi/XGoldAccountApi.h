//
//  XGoldAccountApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 存管账户api
 *
 *****************************************/
@interface XGoldAccountApi : XRequestApi

- (instancetype)initWithToken: (NSString *)token type: (NSString *)type client: (NSString *)client;

@end
