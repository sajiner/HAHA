//
//  XSanBiaoGetInvestmentListApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoGetInvestmentListApi.h"

@interface XSanBiaoGetInvestmentListApi()
@property (nonatomic, copy) NSMutableString *params;
@end

@implementation XSanBiaoGetInvestmentListApi{
    NSInteger _pid;
    NSInteger _pageSize;
    NSInteger _pageNum;
}

- (instancetype)initWithPId:(NSInteger)pid pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum{
    self = [self init];
    if (self) {
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
        _params = [NSMutableString stringWithString:Request_GetInvestmentList];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pid ? _pid : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageSize ? _pageSize : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageNum ? _pageNum : 0)];
    }
    return _params;
}

@end
