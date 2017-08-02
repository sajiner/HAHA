//
//  XDrawCashApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XDrawCashApi.h"

/*****************************************
 *
 * 体现api
 *
 *****************************************/

@interface  XDrawCashApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XDrawCashApi {
    NSString *_token;
    NSString *_money;
    NSString *_client;
}

- (instancetype)initWithToken:(NSString *)token money:(NSString *)money client:(NSString *)client {
    
    self = [super init];
    if (self) {
        _token = token;
        _money = money;
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
        _params = [NSMutableString stringWithString:Request_DrawCash];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_money ? _money : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_client ? _client : @"")];
    }
    return _params;
}

@end
