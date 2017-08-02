//
//  XMySanBiaoInvestDetailApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoInvestDetailApi.h"

/*****************************************
 *
 * 散标投资纪录详情接口
 *
 *****************************************/
@interface  XMySanBiaoInvestDetailApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XMySanBiaoInvestDetailApi {
    NSString *_token;
    NSString *_investId;
}

- (instancetype)initWithToken:(NSString *)token investId:(NSString *)investId {
    
    self = [super init];
    if (self) {
        _token = token;
        _investId = investId;
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
        _params = [NSMutableString stringWithString:Request_UserCenter_UserReMoney];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_investId ? _investId : @"")];
    }
    return _params;
}

@end
