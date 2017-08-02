//
//  XMyJiaYingModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingModel.h"

@implementation XMyJiaYingModel

- (NSString *)amount0 {
    return [_amount decimalString];
}

- (NSString *)rate0 {
    return [NSString stringWithFormat:@"%.2f%%", [_rate doubleValue]];
}

//- (NSString *)lastdate0 {
//    if (_lastdate) {
//        NSMutableString *strM = [[NSMutableString alloc] initWithString:_lastdate];
//        [strM replaceCharactersInRange:NSMakeRange(10, strM.length - 10) withString:@""];
//        _lastdate0 = strM;
//    }
//    return _lastdate0;
//}

- (NSString *)projecyline0 {
    return [NSString stringWithFormat:@"%@个月", _projectline];
}

- (NSString *)marknum0 {
    return [NSString stringWithFormat:@"%@笔", _marknum];
}

- (NSString *)backway0 {
    NSString *way;
    switch ([_backway integerValue]) {
        case 0: //
            way = @"收益不复投";
            break;
        case 1:
            way = @"收益复投";
            break;
        default:
            break;
    }
    return way;
}

- (NSString *)predict0 {
    return [_predict decimalString];
}

@end
