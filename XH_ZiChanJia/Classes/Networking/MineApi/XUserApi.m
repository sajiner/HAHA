//
//  XUserApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XUserApi.h"

/*****************************************
 *
 * 我的页面api
 *
 *****************************************/

@interface  XUserApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XUserApi {
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
        _params = [NSMutableString stringWithString:Request_UserCenter_UserAsset];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
    }
    return _params;
}

@end
