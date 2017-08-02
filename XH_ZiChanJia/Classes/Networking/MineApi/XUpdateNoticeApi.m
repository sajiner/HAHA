//
//  XUpdateNoticeApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XUpdateNoticeApi.h"

@interface  XUpdateNoticeApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XUpdateNoticeApi {
    NSString *_token;
    NSString *_messageId;
}

- (instancetype)initWithToken:(NSString *)token messageId:(NSString *)messageId {
    
    self = [super init];
    if (self) {
        _token = token;
        _messageId = messageId;
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
        _params = [NSMutableString stringWithString:Request_UpdateNotice];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_messageId ? _messageId : @"")];
    }
    return _params;
}

@end
