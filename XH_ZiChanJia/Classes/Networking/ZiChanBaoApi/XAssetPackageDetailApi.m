//
//  XAssetPackageDetailApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAssetPackageDetailApi.h"

@interface XAssetPackageDetailApi()
@property (nonatomic, copy) NSMutableString *params;
@end

@implementation XAssetPackageDetailApi{
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
        _params = [NSMutableString stringWithString:Request_AssetpackageDetail];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pid ? _pid : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"0"];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"0"];
    }
    return _params;
}

@end
