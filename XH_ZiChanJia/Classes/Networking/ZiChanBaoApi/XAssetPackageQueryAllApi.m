//
//  XAssetPackageQueryAllApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAssetPackageQueryAllApi.h"

@interface XAssetPackageQueryAllApi()
@property (nonatomic, copy) NSMutableString *params;
@end

@implementation XAssetPackageQueryAllApi{
    NSInteger _status;
    NSInteger _term;
    NSInteger _profit;
    NSInteger _pageNumber;
    NSInteger _pageSize;
    
}


- (instancetype)initWithStatus:(NSInteger)status term:(NSInteger)term profit:(NSInteger)profit pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize{
    self = [super init];
    if (self) {
        _status = status;
        _term = term;
        _profit = profit;
        _pageNumber = pageNum;
        _pageSize = pageSize;
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
        _params = [NSMutableString stringWithString:Request_AssetpackageQueryALl];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_status ? _status : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_term ? _term :0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_profit ?_profit : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageNumber?_pageNumber : 1)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pageSize ?_pageSize : 5)];
    }
    return _params;
}


@end
