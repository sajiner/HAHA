//
//  XVerifiInviteCodeApi.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XVerifiInviteCodeApi.h"
@interface XVerifiInviteCodeApi()

@property (nonatomic, copy) NSMutableString *params;

@end

@implementation XVerifiInviteCodeApi {
    NSString *_invitedCode;
}

- (instancetype)initWithInvitedCode:(NSString *)invitedCode {
    self = [super init];
    if (self) {
        _invitedCode = invitedCode;
    }
    return self;
}

- (NSString *)requestUrl {
    NSString *tempStr = [self.params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return  tempStr;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSMutableString *)params {
    if (!_params) {
        _params = [NSMutableString stringWithString:Request_Regist_VerifiInviteCode];
        [_params appendFormat:@"%@", @"?"];
        [_params appendFormat:@"invitedCode=%@", (_invitedCode ? _invitedCode : @"")];
    }
    return _params;
}

@end
