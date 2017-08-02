//
//  NSDate+XExtension.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/12/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "NSDate+XExtension.h"

@implementation NSDate (XExtension)

+ (NSDateFormatter *)dateFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return formatter;
}

+ (NSDateComponents *)computeTimeWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    NSCalendar *chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    chineseCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                                      fromDate:startDate
                                                        toDate:endDate
                                                       options:NSCalendarWrapComponents];
    return components;
}

@end
