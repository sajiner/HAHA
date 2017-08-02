//
//  XUpdateNoticeApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 站内消息全部已读接口
 *
 *****************************************/
@interface XUpdateNoticeApi : XRequestApi

/*
 * token: 用户令牌
 * messageId: 页数
 */
- (instancetype)initWithToken: (NSString *)token messageId: (NSString *)messageId;

@end
