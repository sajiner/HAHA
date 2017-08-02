//
//  XLogoutApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XLogoutApi.h"
@interface  XLogoutApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XLogoutApi {
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
    return YTKRequestMethodPOST;
}

- (NSMutableString *)params {
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_Logout];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"token=%@", (_token ? _token : @"")];
    }
    return _params;
}


@end
