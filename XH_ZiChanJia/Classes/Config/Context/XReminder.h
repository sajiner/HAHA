//
//  XReminder.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/11/24.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>
//温馨提示模型
@interface XReminder : NSObject
//注册第二页
@property(nonatomic,copy)NSString *registReminder;
//实名认证页
@property(nonatomic,copy)NSString *nameVerifi;
//风险偏好结果页
@property(nonatomic,copy)NSString *riskUserDefault;
//充值
@property(nonatomic,copy)NSString *recharge;
//体现
@property(nonatomic,copy)NSString *withdraw;
//注册用户名
@property(nonatomic,copy)NSString *userName;
+ (instancetype)sharedReminder;
@end
