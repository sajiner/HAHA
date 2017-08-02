//
//  XSanBiaoQueryALLApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoQueryALLApi.h"

@interface XSanBiaoQueryALLApi()
@property (nonatomic, copy) NSMutableString *params;
@end

@implementation XSanBiaoQueryALLApi{
    NSInteger _status;
    NSInteger _term;
    NSInteger _profit;
    NSInteger _type;
    NSInteger _pageSize;
    NSInteger _pageNumber;
}


- (instancetype)initWithStatus:(NSInteger)status term:(NSInteger)term profit:(NSInteger)profit type:(NSInteger)type pageSize:(NSInteger)pageSize pageNumber:(NSInteger)pageNumber{
    self = [super init];
    if (self) {
        _status = status;
        _term = term;
        _profit = profit;
        _type = type;
        _pageSize = pageSize;
        _pageNumber = pageNumber;
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
        _params = [NSMutableString stringWithString:Request_QueryAll];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_status ? _status : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_term ? _term :0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_profit ?_profit : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_type?_type : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageSize ?_pageSize : 1)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageNumber?_pageNumber : 5)];
    }
    return _params;
}

@end
