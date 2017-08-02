//
//  XSendSMSCodeApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSendSMSCodeApi.h"
@interface XSendSMSCodeApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XSendSMSCodeApi {
    NSString *_type;
    NSString *_phone;
    NSString *_uuid;
    NSString *_signCode;
}

- (instancetype)initWithType: (NSString *)type phone:(NSString *)phoneNumber uuid:(NSString *)uuid signCode:(NSString *)signCode{
    self = [super init];
    if (self) {
        _type = type;
        _phone = phoneNumber;
        _uuid = uuid;
        _signCode = signCode;
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
        _params = [NSMutableString stringWithString:Request_Regist_SendSMSCode];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"type=%@", (_type ? _type : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"phone=%@", (_phone ? _phone : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"uuid=%@", (_uuid ? _uuid : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"signCode=%@", (_signCode ? _signCode : @"")];
    }
    return _params;
}
@end
