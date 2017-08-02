//
//  XCapitalManageCellModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XCapitalManageCellModel.h"

@implementation XCapitalManageCellModel

- (NSString *)date0 {
    NSMutableString *strM = [[NSMutableString alloc] initWithString:_date];
    [strM replaceCharactersInRange:NSMakeRange(0, 5) withString:@""];
    [strM replaceCharactersInRange:NSMakeRange(strM.length - 3, 3) withString:@""];
    return strM;
}

- (NSString *)amount0 {
    NSString *str;
    switch ([_receivePay integerValue]) {
        case 0:
            str = [NSString stringWithFormat:@"+%@", [_amount decimalString]];
            break;
            
        case 1:
            str = [NSString stringWithFormat:@"-%@", [_amount decimalString]];
            break;
    }
    return str;
}

@end
