//
//  XVerifiRealNameApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XVerifiRealNameApi.h"
@interface  XVerifiRealNameApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XVerifiRealNameApi{
    NSString *_token;
    NSString *_realName;
    NSString *_identity;
    NSString *_realNameSource;
}

- (instancetype)initWithToken:(NSString *)token realName:(NSString *)realName identity:(NSString *)identity realNameSource:(NSString *)realNameSource {
    self = [super init];
    if (self) {
        _token = token;
        _realName = realName;
        _identity = identity;
        _realNameSource = realNameSource;

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
        _params = [NSMutableString stringWithString:Request_Regist_VerifiRealName];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"token=%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"realName=%@", (_realName ? _realName : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"identity=%@", (_identity ? _identity : @"")];
        [_params appendFormat:@"%@", @"&"];
        [_params appendFormat:@"realNameSource=%@", (_realNameSource ? _realNameSource : @"")];
    }
    return _params;
}
@end
