//
//  XMyJiaYingHeaderModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingHeaderModel.h"

@implementation XMyJiaYingHeaderModel

- (NSString *)investamonut0 {
    return [_investamonut decimalString];
}

- (NSString *)endPredictMoney0 {
    return [_endPredictMoney decimalString];
}

- (NSString *)predictMoney0 {
    return [_predictMoney decimalString];
}

@end
