//
//  XUserApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 我的页面api
 *
 *****************************************/
@interface XUserApi : XRequestApi

- (instancetype)initWithToken: (NSString *)token;

@end
