//
//  XVerifiPhoneNumberApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XVerifiPhoneNumberApi.h"

@interface XVerifiPhoneNumberApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XVerifiPhoneNumberApi {
    NSString *_phone;
}

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber {
    
    self = [super init];
    if (self) {
        _phone = phoneNumber;
    }
    return self;
}

- (NSString *)requestUrl {
    return  self.params;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSMutableString *)params {
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_Regist_VerifiPhoneNumber];
        [_params appendFormat:@"%@", @"/"];
        [_params appendFormat:@"%@", (_phone ? _phone : @"")];
    }
    return _params;
}
@end
