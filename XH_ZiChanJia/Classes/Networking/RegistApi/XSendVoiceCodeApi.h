//
//  XSendVoiceCodeApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//给手机发送语音验证码API
@interface XSendVoiceCodeApi : XRequestApi

- (instancetype)initWithPhone:(NSString *)phone uuid:(NSString *)uuid signCode:(NSString *)signCode;

@end
