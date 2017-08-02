//
//  XSendAccountApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSendAccountApi.h"

/*****************************************
 *
 * 获取最新的用户信息api(发送给后台)
 *
 *****************************************/

@interface  XSendAccountApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XSendAccountApi {
    NSString *_token;
}

- (instancetype)initWithToken:(NSString *)token {
    
    self = [super init];
    if (self) {
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return  self.params;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSMutableString *)params {
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_Recent_Account];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
    }
    return _params;
}

@end
