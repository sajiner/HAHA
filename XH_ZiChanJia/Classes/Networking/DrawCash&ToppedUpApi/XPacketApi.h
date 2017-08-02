//
//  XPacketApi.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

/*****************************************
 *
 * 用户行为请求接口(发送给后台)
 *
 *****************************************/
@interface XPacketApi : XRequestApi

- (instancetype)initWithJson: (NSString *)json;

@end
