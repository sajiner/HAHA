//
//  XSanBiaoDetailsApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/26.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoDetailsApi.h"

@interface XSanBiaoDetailsApi()
@property (nonatomic, copy) NSMutableString *params;
@end

@implementation XSanBiaoDetailsApi{
    NSInteger _pid;
}


- (instancetype)initWithPId:(NSInteger)pid{
    self = [self init];
    if (self) {
        _pid = pid;
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
        _params = [NSMutableString stringWithString:Request_Details];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pid ? _pid : 0)];
    }
    return _params;
}


@end
