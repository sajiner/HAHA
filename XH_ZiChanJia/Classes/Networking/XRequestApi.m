//
//  XRequestApi.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
#import "XSanBiaoDetailsApi.h"
#import "XSanBiaoGetInvestmentListApi.h"
#import "XSanBiaoGetRepaymentPlanApi.h"

@implementation XRequestApi

#pragma mark -  配置信息
- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}

- (NSString *)baseUrl {
    
    return RequestBaseUrl;
}

- (NSTimeInterval)requestTimeoutInterval {
    
    return 20;
}

- (void)start {
    if (![XNetConnection connect]) {
        [[UIApplication sharedApplication].keyWindow.rootViewController showAlertViewWithTitle:nil message:@"亲,你目前的网络状态不好，请查看后重试" letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        return;
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController showActivityViewWithTitle:@"加载中..."];
    [super start];
}



#pragma mark - 请求成功的回调
- (void)requestCompleteFilter {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController completeLoadWithTitle:nil];
    NSDictionary *result = self.responseJSONObject;
    NSInteger state = [[result objectForKey:@"status"] integerValue];
    if (state == 15 || state == 13) { // 15:用户未登录 13:token为空
        [UserManager clearUser];
        if ([self isKindOfClass:[XSanBiaoGetRepaymentPlanApi class]] || [self isKindOfClass:[XSanBiaoGetInvestmentListApi class]] || [self isKindOfClass:[XSanBiaoDetailsApi class]]) {
            return;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN_NOTIFICATION object:nil];
    }
    
}

#pragma mark - 请求失败的回调
- (void)requestFailedFilter {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController completeLoadWithTitle:nil];
//    NSError *error = self.requestOperationError;
//    
//    if (error.code == -1009) { // 网络断开
//        [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN_NOTWORK object:nil];
//    } else if (error.code == -1001) { // 请求超时
//        [[NSNotificationCenter defaultCenter] postNotificationName:REQUEST_TIMEOUT_NOTWORK object:nil];
//    } else if (error.code == -1004) { // 未能连接到服务器
//        [[NSNotificationCenter defaultCenter] postNotificationName:REQUEST_NOTSEVERCE object:nil];
//    }
}

#pragma mark - 打印请求地址
- (void)printRequestInfo {
    
    NSMutableString *requestString = [NSMutableString string];
    [requestString appendString:self.baseUrl];
    [requestString appendString:self.requestUrl];
    [requestString appendString:@"?"];
    NSArray *sortArray = [self.requestArgument allKeys];
    for (NSString *key in sortArray) {
        [requestString appendString:key];
        [requestString appendString:@"="];
        [requestString appendString:self.requestArgument[key]];
        if (key != sortArray[sortArray.count - 1]) {
            [requestString appendString:@"&"];
        }
    }
    NSLog(@"请求地址:---------%@", requestString);
}

@end
