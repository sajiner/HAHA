//
//  XMySanBiaoModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoModel.h"

@implementation XMySanBiaoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"investId": @"id"
             };
}

- (NSString *)investAmount0 {
    return [_investAmount decimalString];
}

- (NSString *)predictMoney0 {
    return [_predictMoney decimalString];
}

- (NSString *)repayMoney0 {
    return [_repayMoney decimalString];
}

- (NSString *)lastDate0 {
    if (_lastDate) {
        NSMutableString *strM = [[NSMutableString alloc] initWithString:_lastDate];
        [strM replaceCharactersInRange:NSMakeRange(10, strM.length - 10) withString:@""];
        _lastDate0 = strM;
    }
    return _lastDate0;
}

@end
