//
//  XLoginApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XLoginApi.h"
@interface XLoginApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XLoginApi {
    NSString *_uUserName;
    NSString *_uPassword;
    NSString *_signUuid;
    NSString *_signCode;
    NSString *_modifyIp;
    NSString *_origin;
    NSString *_emailAddress;

}

- (instancetype)initWithuUserName:(NSString *)uUserName uPassword:(NSString *)uPassword signUuid:(NSString *)signUuid signCode:(NSString *)signCode modifyIp:(NSString *)modifyIp origin:(NSString *)origin emailAddress:(NSString *)emailAddress {
    self = [super init];
    if (self) {
        _uUserName = uUserName;
        _uPassword = uPassword;
        _signUuid = signUuid;
        _signCode = signCode;
        _modifyIp = modifyIp;
        _origin = origin;
        _emailAddress = emailAddress;

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
        _params = [NSMutableString stringWithString:Request_Login];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"uUserName=%@", (_uUserName ? _uUserName : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"uPassword=%@", (_uPassword ? _uPassword : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"signUuid=%@", (_signUuid ? _signUuid : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"signCode=%@", (_signCode ? _signCode : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"modifyIp=%@", (_modifyIp ? _modifyIp : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"origin=%@", (_origin ? _origin : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"emailAddress=%@", (_emailAddress ? _emailAddress : @"")];
    }
    return _params;
}

@end
