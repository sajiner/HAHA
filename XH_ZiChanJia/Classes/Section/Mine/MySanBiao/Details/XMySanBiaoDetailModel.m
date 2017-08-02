//
//  XMySanBiaoDetailModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoDetailModel.h"
#import "XMySanBiaoReturnPlanModel.h"

@implementation XMySanBiaoDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"list":[XMySanBiaoReturnPlanModel class]
             };
}

- (NSString *)paymentAcount0 {
    return [_paymentAcount decimalString];
}

- (NSString *)paymentPrincipal0 {
    return [_paymentPrincipal decimalString];
}

- (NSString *)paymentInterest0 {
    return [_paymentInterest decimalString];
}

- (NSString *)endPaymentInterest0 {
    return [_endPaymentInterest decimalString];
}

@end
