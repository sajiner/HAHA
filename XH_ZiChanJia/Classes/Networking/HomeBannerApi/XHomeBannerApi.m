//
//  XHomeBannerApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/12/26.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeBannerApi.h"

@interface  XHomeBannerApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XHomeBannerApi {
    
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
        _params = [NSMutableString stringWithString:Request_HomeBanner];
        
    }
    return _params;
}
@end
