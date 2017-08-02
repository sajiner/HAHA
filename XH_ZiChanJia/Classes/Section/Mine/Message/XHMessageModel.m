//
//  XHMessageModel.m
//  XinHe_JinRong
//
//  Created by sajiner on 16/7/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHMessageModel.h"

@implementation XHMessageModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"messageId" : @"id"
             };
}

- (NSString *)sendTime {
    
    NSTimeInterval timeInterval = [_time[@"time"] doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000];
    
    return [formatter stringFromDate:date];
}

@end
