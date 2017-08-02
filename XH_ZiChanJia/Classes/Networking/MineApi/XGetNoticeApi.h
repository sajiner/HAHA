//
//  XGetNoticeApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 站内消息接口
 *
 *****************************************/
@interface XGetNoticeApi : XRequestApi

/*
 * token: 用户令牌
 * pageNum: 页数
 * status: 读取状态（0未读、1已读、-1全部）
 * pageSize: 每页条数
 */
- (instancetype)initWithToken: (NSString *)token status: (NSString *)status pageNum: (NSString *)pageNum pageSize: (NSString *)pageSize;

@end
