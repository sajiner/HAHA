//
//  XMySanBiaoHeaderModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoHeaderModel.h"

@implementation XMySanBiaoHeaderModel

- (NSString *)waitPaymentInterest0 {
    return [_waitPaymentInterest decimalString];
}

- (NSString *)waitPaymentAmount0 {
    return [_waitPaymentAmount decimalString];
}

- (NSString *)endPaymentInterest0 {
    return [_endPaymentInterest decimalString];
}

@end
