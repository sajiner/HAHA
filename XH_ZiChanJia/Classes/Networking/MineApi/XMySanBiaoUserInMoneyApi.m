//
//  XMySanBiaoUserInMoneyApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoUserInMoneyApi.h"

/*****************************************
 *
 * 我的散标接口（获取待收本金、待收收益、累计收益）
 *
 *****************************************/
@interface  XMySanBiaoUserInMoneyApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XMySanBiaoUserInMoneyApi {
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
        _params = [NSMutableString stringWithString:Request_UserCenter_UserInMoney];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
    }
    return _params;
}

@end
