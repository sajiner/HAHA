//
//  XUserModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/8/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XUserModel.h"
#import <objc/runtime.h>

/*
 * user存储key
 */
//
//static NSString * const xUserNameKey = @"userName";
//static NSString * const xUserPhoneKey = @"userPhone";
//static NSString * const xTokenKey = @"token";
//static NSString * const xUserIdKey = @"userId";
//static NSString * const xModifyIpKey = @"modifyIp";
//static NSString * const xNameCheckedKey = @"nameChecked";
//static NSString * const xMagicUserKey = @"magicUser";
//static NSString * const xBalanceKey = @"balance";
//static NSString * const xBeforeLoginTimeKey = @"beforeLoginTime";

@implementation XUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
//             @"userId": @"id"
             };
}

// 什么时候,自定义对象归档的时候调用
// 告诉系统这个对象里面哪些属性需要归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
//    [aCoder encodeObject:_userName forKey:xUserNameKey];
//    [aCoder encodeObject:_userPhone forKey:xUserPhoneKey];
//    [aCoder encodeObject:_token forKey:xTokenKey];
//    [aCoder encodeObject:_modifyIp forKey:xModifyIpKey];
//    [aCoder encodeObject:_nameChecked forKey:xNameCheckedKey];
//    [aCoder encodeObject:_magicUser forKey:xMagicUserKey];
//    [aCoder encodeObject:_balance forKey:xBalanceKey];
//    [aCoder encodeObject:_beforeLoginTime forKey:xBeforeLoginTimeKey];
}
// 什么时候,自定义对象解档的时候调用
// 告诉系统这个对象里面哪些属性需要解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
//        _userName =  [aDecoder decodeObjectForKey:xUserNameKey];
//        _userPhone = [aDecoder decodeObjectForKey:xUserPhoneKey];
//        _token = [aDecoder decodeObjectForKey:xTokenKey];
//        _modifyIp = [aDecoder decodeObjectForKey:xModifyIpKey];
//        _nameChecked = [aDecoder decodeObjectForKey:xNameCheckedKey];
//        _magicUser = [aDecoder decodeObjectForKey:xMagicUserKey];
//        _balance = [aDecoder decodeObjectForKey:xBalanceKey];
//        _beforeLoginTime = [aDecoder decodeObjectForKey:xBeforeLoginTimeKey];
    }
    return self;
}

@end
