//
//  XReminderApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/11/23.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XReminderApi.h"

@interface  XReminderApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XReminderApi {
    NSString *_key;
}

- (instancetype)initWithKey:(NSString *)key {
    self = [super init];
    if (self) {
        _key = key;
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
        _params = [NSMutableString stringWithString:Request_Reminder];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_key ? _key : @"")];
    }
    return _params;
}


@end
