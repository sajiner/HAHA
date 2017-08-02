//
//  XGetNoticeApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XGetNoticeApi.h"

/*****************************************
 *
 * 站内消息接口
 *
 *****************************************/
@interface  XGetNoticeApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XGetNoticeApi {
    NSString *_token;
    NSString *_status;
    NSString *_pageNum;
    NSString *_pageSize;
}

- (instancetype)initWithToken:(NSString *)token status:(NSString *)status pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize {
    
    self = [super init];
    if (self) {
        _token = token;
        _status = status;
        _pageNum = pageNum;
        _pageSize = pageSize;
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
        _params = [NSMutableString stringWithString:Request_GetNotices];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_status ? _status : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageNum ? _pageNum : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_pageSize ? _pageSize : @"")];
    }
    return _params;
}

@end
