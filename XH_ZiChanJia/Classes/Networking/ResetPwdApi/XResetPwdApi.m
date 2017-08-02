//
//  XResetPwdApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XResetPwdApi.h"
@interface XResetPwdApi()

@property (nonatomic, copy) NSMutableString *params;

@end
@implementation XResetPwdApi {
    NSString *_phone;
    NSString *_password;
    NSString *_identity;
    NSString *_origin;
    NSString *_modifyIp;
    NSString *_phoneCode;
    NSString *_type;
    NSString *_realName;
}

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password identity:(NSString *)identity origin:(NSString *)origin modifyIp:(NSString *)modifyIp phoneCode:(NSString *)phoneCode type:(NSString *)type realName:(NSString *)realName {
    self = [super init];
    if (self) {
        _phone = phone;
        _password = password;
        _identity = identity;
        _origin = origin;
        _modifyIp = modifyIp;
        _phoneCode = phoneCode;
        _type = type;
        _realName = realName;
    }
    return self;
}

- (NSString *)requestUrl {
    NSString *tempStr = [self.params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return  tempStr;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSMutableString *)params {
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_ResetPwd];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"phone=%@", (_phone ? _phone : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"password=%@", (_password ? _password : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"identity=%@", (_identity ? _identity : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"origin=%@", (_origin ? _origin : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"modifyIp=%@", (_modifyIp ? _modifyIp : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"phoneCode=%@", (_phoneCode ? _phoneCode : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"type=%@", (_type ? _type : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"realName=%@", (_realName ? _realName : @"")];
    }
    return _params;
}

@end
