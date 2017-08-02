//
//  XNetConnection.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XNetConnection.h"
#import <Reachability/Reachability.h>

/******************************************
 *
 *  检测网络连接类(单例)。
 *
 ******************************************/
@implementation XNetConnection

Reachability *_wifi;
Reachability *_connect;

static XNetConnection *_instance;

#pragma mark - 单例
+ (instancetype)sharedNetConnection {
    static dispatch_once_t doneTime;
    dispatch_once(&doneTime, ^{
        _instance = [[XNetConnection alloc] init];
    });
    return _instance;
}

#pragma mark - 是否连上了wifi
+ (BOOL)wifi {
    if (!_wifi) {
        _wifi = [Reachability reachabilityForLocalWiFi];
        [_wifi startNotifier];
    }
    if (_wifi.currentReachabilityStatus == ReachableViaWiFi) {
        return YES;
    }
    return NO;
}

#pragma mark - 是否有网络连接
+ (BOOL)connect {
    if (!_connect) {
        _connect = [Reachability reachabilityForInternetConnection];
        [_connect startNotifier];
    }
    if (_connect.currentReachabilityStatus != NotReachable) {
        return YES;
    }
    return NO;
}

#pragma mark - 监听网络状态的改变
- (void)netConnectionChanged:(NSNotification *)note {
    Reachability *reach = [note object];
    
    if ([reach isReachable]) {
        // 可以联网
        if (self.netWorkChangedBlock) {
            self.netWorkChangedBlock(YES);
        }
    } else {
        // 不可以联网
        if (self.netWorkChangedBlock) {
            self.netWorkChangedBlock(NO);
        }
    }
}

@end
