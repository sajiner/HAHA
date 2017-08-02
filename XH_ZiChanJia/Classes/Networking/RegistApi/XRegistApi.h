//
//  XRegistApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//提交注册API
@interface XRegistApi : XRequestApi

- (instancetype)initWithUserName:(NSString *)userName userPhone:(NSString *)userPhone password:(NSString *)password invitationCode:(NSString *)invitationCode signUuid:(NSString *)signUuid signCode:(NSString *)signCode phoneCode:(NSString *)phoneCode modifyIp:(NSString *)modifyIp origin:(NSString *)origin;

@end
