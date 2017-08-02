//
//  XMySanBiaoInvestDetailApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 散标投资纪录详情接口
 *
 *****************************************/
@interface XMySanBiaoInvestDetailApi : XRequestApi

/*
 * token: 用户令牌
 * investId: 用户投资记录id
 * pageNum: 页数
 * pageSize: 每页条数
 */
- (instancetype)initWithToken: (NSString *)token investId: (NSString *)investId;

@end
