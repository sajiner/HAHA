//
//  XMyJiaYingProjectInvestDetailApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingProjectInvestDetailApis.h"

/*****************************************
 *
 * 嘉盈投资纪录详情接口
 *
 *****************************************/
@interface  XMyJiaYingProjectInvestDetailApis()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XMyJiaYingProjectInvestDetailApis {
    NSString *_token;
    NSString *_investId;
    NSString *_investType;
    NSString *_pageNum;
    NSString *_pageSize;
}

- (instancetype)initWithToken:(NSString *)token investId:(NSString *)investId investType:(NSString *)investType pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize {
    
    self = [super init];
    if (self) {
        _token = token;
        _investId = investId;
        _investType = investType;
        _pageNum = pageNum;
        _pageSize = pageSize;
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
        _params = [NSMutableString stringWithString:Request_UserCenter_UserProjectMark];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_investId ? _investId : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_investType ? _investType : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageNum ? _pageNum : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageSize ? _pageSize : @"")];
    }
    return _params;
}

@end
