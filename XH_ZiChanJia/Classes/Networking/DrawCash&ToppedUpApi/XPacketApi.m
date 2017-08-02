//
//  XPacketApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XPacketApi.h"

/*****************************************
 *
 * 用户行为请求接口(发送给后台)
 *
 *****************************************/

@interface  XPacketApi()

@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation XPacketApi {
    NSString *_json;
}

- (instancetype)initWithJson:(NSString *)json {
    
    self = [super init];
    if (self) {
        _json = json;
    }
    return self;
}

- (NSString *)requestUrl {
    return  Request_Packet;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return self.params;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
        [_params setObject:(_json ? _json : @"") forKey:@"json"];
    }
    return _params;
}

@end
