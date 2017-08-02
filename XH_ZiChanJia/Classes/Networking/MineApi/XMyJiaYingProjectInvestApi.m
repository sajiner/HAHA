//
//  XMyJiaYingProjectInvestApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingProjectInvestApi.h"

/*****************************************
 *
 * 嘉盈投资纪录接口
 *
 *****************************************/
@interface  XMyJiaYingProjectInvestApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XMyJiaYingProjectInvestApi {
    NSString *_token;
    NSString *_pageNum;
    NSString *_pageSize;
    NSString *_investStatus;
}

- (instancetype)initWithToken:(NSString *)token pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize investStatus:(NSString *)investStatus {
    
    self = [super init];
    if (self) {
        _token = token;
        _pageNum = pageNum;
        _pageSize = pageSize;
        _investStatus = investStatus;
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
        _params = [NSMutableString stringWithString:Request_UserCenter_UserProjectInvest];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageNum ? _pageNum : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageSize ? _pageSize : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_investStatus ? _investStatus : @"")];
    }
    return _params;
}

@end
