//
//  XMyJiaYingProjectMoneyApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingProjectMoneyApi.h"

/*****************************************
 *
 * 我的嘉盈接口（获取待收本金、待收收益、累计收益）
 *
 *****************************************/
@interface  XMyJiaYingProjectMoneyApi ()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XMyJiaYingProjectMoneyApi {
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
        _params = [NSMutableString stringWithString:Request_UserCenter_UserProject];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
    }
    return _params;
}

@end
