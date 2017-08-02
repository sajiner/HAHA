//
//  XResetPWdVerifiSmsCodeApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XResetPWdVerifiSmsCodeApi.h"
@interface XResetPWdVerifiSmsCodeApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XResetPWdVerifiSmsCodeApi {
    NSString *_phone;
    NSString *_signUuid;
    NSString *_signCode;
    NSString *_phoneCode;
}

- (instancetype)initWithPhone:(NSString *)phone signUuid:(NSString *)signUuid signCode:(NSString *)signCode phoneCode:(NSString *)phoneCode {
    self = [super init];
    if (self) {
        _phone = phone;
        _signUuid = signUuid;
        _signCode = signCode;
        _phoneCode = phoneCode;
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
        _params = [NSMutableString stringWithString:Request_ResetPwd_VerifiSmsCode];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"phone=%@", (_phone ? _phone : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"signUuid=%@", (_signUuid ? _signUuid : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"signCode=%@", (_signCode ? _signCode : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"phoneCode=%@", (_phoneCode ? _phoneCode : @"")];
        
    }
    return _params;
}
@end
