//
//  XCapitalManageApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XCapitalManageApi.h"


/*****************************************
 *
 * 资金管理接口
 *
 *****************************************/
@interface  XCapitalManageApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XCapitalManageApi {
    NSString *_token;
    NSString *_pageNum;
    NSString *_pageSize;
}

- (instancetype)initWithToken:(NSString *)token pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize {
    
    self = [super init];
    if (self) {
        _token = token;
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
        _params = [NSMutableString stringWithString:Request_UserCenter_UserAccountLog];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageNum ? _pageNum : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageSize ? _pageSize : @"")];
    }
    return _params;
}

@end
