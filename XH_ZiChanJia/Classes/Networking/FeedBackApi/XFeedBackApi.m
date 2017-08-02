//
//  XFeedBackApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/11/7.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XFeedBackApi.h"

@interface  XFeedBackApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XFeedBackApi {
    NSString *_content;
    NSString *_token;
}

- (instancetype)initWithContent:(NSString *)content Token:(NSString *)token {
    self = [super init];
    if (self) {
        _content = content;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    NSString *tempStr = [self.params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return  tempStr;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSMutableString *)params {
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_FeedBack];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_content ? _content : @"")];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_token ? _token : @"")];
    }
    return _params;
}


@end

