//
//  XMySanBiaoReturnPlanModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoReturnPlanModel.h"

@implementation XMySanBiaoReturnPlanModel

- (NSString *)paymentTime0 {
    if (_paymentTime) {
        NSMutableString *strM = [[NSMutableString alloc] initWithString:_paymentTime];
        [strM replaceCharactersInRange:NSMakeRange(10, strM.length - 10) withString:@""];
        _paymentTime0 = strM;
    }
    return _paymentTime0;
}

- (NSString *)paymentPrincipal0 {
    return [_paymentPrincipal decimalString];
}

- (NSString *)paymenterest0 {
    return [_paymentInterest decimalString];
}

- (NSString *)paymentTotalAmount0 {
    return [_paymentTotalAmount decimalString];
}

@end
