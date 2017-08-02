//
//  XCheckVersionApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2017/1/3.
//  Copyright © 2017年 资产家. All rights reserved.
//

#import "XCheckVersionApi.h"

@interface  XCheckVersionApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XCheckVersionApi {
    NSString *_system;
}

- (instancetype)initWithSystem:(NSString *)system {
    self = [super init];
    if (self) {
        _system = system;
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
        _params = [NSMutableString stringWithString:Request_CheckVersion];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_system ? _system : @"")];
    }
    return _params;
}
@end

