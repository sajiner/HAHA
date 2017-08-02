//
//  XRegistApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRegistApi.h"
@interface XRegistApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XRegistApi {
    NSString *_userName;
    NSString *_userPhone;
    NSString *_password;
    NSString *_invitationCode;
    NSString *_signUuid;
    NSString *_signCode;
    NSString *_phoneCode;
    NSString *_modifyIp;
    NSString *_origin;
}

- (instancetype)initWithUserName:(NSString *)userName userPhone:(NSString *)userPhone password:(NSString *)password invitationCode:(NSString *)invitationCode signUuid:(NSString *)signUuid signCode:(NSString *)signCode phoneCode:(NSString *)phoneCode modifyIp:(NSString *)modifyIp origin:(NSString *)origin {
    
    self = [super init];
    if (self) {
        _userName = userName;
        _userPhone = userPhone;
        _password = password;
        _invitationCode = invitationCode;
        _signUuid = signUuid;
        _signCode = signCode;
        _phoneCode = phoneCode;
        _modifyIp = modifyIp;
        _origin = origin;
    }
    return self;
}

- (NSString *)requestUrl {
    NSString *tempStr = [self.params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return  tempStr ;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSMutableString *)params {
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_Regist_Register];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"userName=%@", (_userName ? _userName : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"userPhone=%@", (_userPhone ? _userPhone : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"password=%@", (_password ? _password : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"invitationCode=%@", (_invitationCode ? _invitationCode : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"signUuid=%@", (_signUuid ? _signUuid : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"signCode=%@", (_signCode ? _signCode : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"phoneCode=%@", (_phoneCode ? _phoneCode : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"modifyIp=%@", (_modifyIp ? _modifyIp : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"origin=%@", (_origin ? _origin : @"")];
    }
    return _params;
}

@end
