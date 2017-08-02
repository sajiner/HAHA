//
//  XSanBiaoInvestMarkApi.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/31.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoInvestMarkApi.h"

@interface XSanBiaoInvestMarkApi()
@property (nonatomic,copy)NSMutableString *params;

@end

@implementation XSanBiaoInvestMarkApi{
    NSString * _token;
    CGFloat _amount;
    CGFloat _income;
    NSInteger _pid;
    NSString * _ip;
    NSInteger _terminal;
}

- (instancetype)initWithToken:(NSString *)token amount:(CGFloat)amount income:(CGFloat)income projectId:(NSInteger)pid ip:(NSString *)ip terminal:(NSInteger)terminal{
    self = [super init];
    if (self) {
        _token = token;
        _amount = amount;
        _income = income;
        _pid = pid;
        _ip = ip;
        _terminal = terminal;
    }
    return self;
}

- (NSString *)requestUrl{
    return self.params;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (NSMutableString *)params{
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_InvestMark];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%@", _token ?_token : @"-1"];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%lf", (_amount ? _amount : 0.0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%lf", (_income ?_income : 0.0)];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld",_pid ? _pid :0];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%@",_ip ?_ip :@""];
        [_params appendFormat:@"/"];
        [_params appendFormat:@"%ld",_terminal ?_terminal:2];
    }
    return _params;
}


@end
