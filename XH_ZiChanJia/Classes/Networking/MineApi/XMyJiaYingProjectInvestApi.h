//
//  XMyJiaYingProjectInvestApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 嘉盈投资纪录接口
 *
 *****************************************/
@interface XMyJiaYingProjectInvestApi : XRequestApi

/*
 * token: 用户令牌
 * pageNum: 页数
 * pageSize: 每页条数
 * investStatus: (1-投资中，2-回款中，3-已结束, -1表示全部)
 */
- (instancetype)initWithToken: (NSString *)token pageNum: (NSString *)pageNum pageSize: (NSString *)pageSize investStatus: (NSString *)investStatus;

@end
