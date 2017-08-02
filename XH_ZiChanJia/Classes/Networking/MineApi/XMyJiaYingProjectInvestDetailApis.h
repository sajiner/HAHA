//
//  XMyJiaYingProjectInvestDetailApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 嘉盈投资纪录详情接口（可复投）
 *
 *****************************************/
@interface XMyJiaYingProjectInvestDetailApis : XRequestApi

/*
 * token: 用户令牌
 * investId: 用户投资记录id
 * investType: 投资类型0新投资，1回款复投,-1全部
 */
- (instancetype)initWithToken: (NSString *)token investId: (NSString *)investId investType: (NSString *)investType pageNum: (NSString *)pageNum pageSize: (NSString *)pageSize;

@end
