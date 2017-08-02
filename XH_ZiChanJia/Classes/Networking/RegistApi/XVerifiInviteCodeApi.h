//
//  XVerifiInviteCodeApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//验证邀请码API
@interface XVerifiInviteCodeApi : XRequestApi

- (instancetype)initWithInvitedCode:(NSString *)invitedCode;

@end
