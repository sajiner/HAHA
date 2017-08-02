//
//  UserManager.h
//  XinHe_JinRong
//
//  Created by 资产家 on 15/10/15.
//  Copyright (c) 2015年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XUserModel;
@interface UserManager : NSObject

+ (void)saveWithUser:(XUserModel *)User;
+ (XUserModel *)User;
+ (BOOL)clearUser;
@end
