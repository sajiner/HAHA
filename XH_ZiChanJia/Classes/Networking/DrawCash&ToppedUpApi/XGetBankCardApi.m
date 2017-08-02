//
//  XGetBankCardApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XGetBankCardApi.h"

/*****************************************
 *
 * 获取银行卡信息api
 *
 *****************************************/

@interface  XGetBankCardApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XGetBankCardApi {
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
        _params = [NSMutableString stringWithString:Request_DrawCash_BankCard];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
    }
    return _params;
}

@end
