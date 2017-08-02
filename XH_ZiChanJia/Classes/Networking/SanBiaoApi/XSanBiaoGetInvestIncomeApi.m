//
//  XSanBiaoGetInvestIncomeApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/31.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoGetInvestIncomeApi.h"

@interface XSanBiaoGetInvestIncomeApi()
@property (nonatomic, copy) NSMutableString *params;
@end

@implementation XSanBiaoGetInvestIncomeApi{
    CGFloat _amount;
    NSInteger _pid;
}

- (instancetype)initWithAmout:(CGFloat)amount pId:(NSInteger)pid{
    self = [super init];
    if (self) {
        _amount = amount;
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
        _params = [NSMutableString stringWithString:Request_GetInvestIncome];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_amount ? _amount : 0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld", (long)(_pid ? _pid : 0)];
    }
    return _params;
}

@end
