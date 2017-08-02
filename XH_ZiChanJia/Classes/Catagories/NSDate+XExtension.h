//
//  NSDate+XExtension.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/12/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XExtension)

+ (NSDateFormatter *)dateFormatter;

+ (NSDateComponents *)computeTimeWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end
