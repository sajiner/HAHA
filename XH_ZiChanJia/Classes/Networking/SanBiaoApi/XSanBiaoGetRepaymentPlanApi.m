//
//  XSanBiaoGetRepaymentPlanApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoGetRepaymentPlanApi.h"

@interface XSanBiaoGetRepaymentPlanApi()
@property (nonatomic, copy) NSMutableString *params;
@end


@implementation XSanBiaoGetRepaymentPlanApi{
    NSString *_token;
    NSInteger _pid;
    NSInteger _pageSize;
    NSInteger _pageNum;
}


- (instancetype)initWitToken:(NSString *)token pId:(NSInteger)pid pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum{
    self = [self init];
    if (self) {
        _token = token;
        _pid = pid;
        _pageSize = pageSize;
        _pageNum = pageNum;
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
        _params = [NSMutableString stringWithString:Request_GetRepaymentPlan];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pid ? _pid : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%@", _token ?_token : @"-1"];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageSize ? _pageSize : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageNum ? _pageNum : 0)];
    }
    return _params;
}

@end
