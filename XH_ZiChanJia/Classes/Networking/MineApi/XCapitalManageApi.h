//
//  XCapitalManageApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 资金管理接口
 *
 *****************************************/
@interface XCapitalManageApi : XRequestApi

/*
 * token: 用户令牌
 * pageNum: 页数
 * pageSize: 每页条数
 */
- (instancetype)initWithToken: (NSString *)token pageNum: (NSString *)pageNum pageSize: (NSString *)pageSize;

@end
