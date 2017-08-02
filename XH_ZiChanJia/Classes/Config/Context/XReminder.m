//
//  XReminder.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/11/24.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XReminder.h"

@implementation XReminder
static XReminder *_instance;

#pragma mark - 单例
+ (instancetype)sharedReminder {
    static dispatch_once_t doneTime;
    dispatch_once(&doneTime, ^{
        _instance = [[XReminder alloc] init];
    });
    return _instance;
}
@end
