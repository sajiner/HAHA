//
//  XHomeApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeApi.h"

@interface  XHomeApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XHomeApi {
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
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
        _params = [NSMutableString stringWithString:Request_HomeInfor];

    }
    return _params;
}
@end
