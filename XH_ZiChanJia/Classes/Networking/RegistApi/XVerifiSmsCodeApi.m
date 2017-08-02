//
//  XVerifiSmsCodeApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XVerifiSmsCodeApi.h"
@interface XVerifiSmsCodeApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XVerifiSmsCodeApi {
    NSString *_phone;
    NSString *_phoneCode;
}

- (instancetype)initWithPhone:(NSString *)phone phoneCode:(NSString *)phoneCode{
    self = [super init];
    if (self) {
        _phone = phone;
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
        _params = [NSMutableString stringWithString:Request_Regist_VerifiSmsCode];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"phone=%@", (_phone ? _phone : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"phoneCode=%@", (_phoneCode ? _phoneCode : @"")];
    }
    return _params;
}

@end
