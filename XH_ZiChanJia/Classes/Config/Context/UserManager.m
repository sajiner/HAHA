//
//  UserManager.m
//  XinHe_JinRong
//
//  Created by 资产家 on 15/10/15.
//  Copyright (c) 2015年 资产家. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

//static UserManager *userDefaultManager = nil;
//
//+ (UserManager *)defaultManager
//{
//    static dispatch_once_t doneTime;
//    
//    dispatch_once(&doneTime, ^{
//        userDefaultManager = [[UserManager alloc] init];
//    });
//    
//    return userDefaultManager;
//}


// 存储User 信息
+ (void)saveWithUser:(XUserModel *)User
{
    [NSKeyedArchiver archiveRootObject:User toFile:XUserCachePath];
}
// 获取User 信息
+ (XUserModel *)User{
    
    XUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:XUserCachePath];
    return user;
}
// 删除User 信息
+ (BOOL)clearUser{
    NSFileManager *mgr = [NSFileManager defaultManager];
    return [mgr removeItemAtPath:XUserCachePath error:nil];
}
@end
