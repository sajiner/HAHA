//
//  XGoldAccountApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XGoldAccountApi.h"

/*****************************************
 *
 * 存管账户api
 *
 *****************************************/

@interface  XGoldAccountApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XGoldAccountApi {
    NSString *_token;
    NSString *_type;
    NSString *_client;
}

- (instancetype)initWithToken:(NSString *)token type:(NSString *)type client:(NSString *)client {
    
    self = [super init];
    if (self) {
        _token = token;
        _type = type;
        _client = client;
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
        _params = [NSMutableString stringWithString:Request_GoldAccount_Open];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_type ? _type : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_client ? _client : @"")];
    }
    return _params;
}

@end
