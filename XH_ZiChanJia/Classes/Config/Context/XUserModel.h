//
//  XUserModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/8/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XUserModel : NSObject
// 用户名
@property (nonatomic, copy) NSString *userName;
//用户手机号
@property (nonatomic, copy) NSString *userPhone;
//用户登录标识
@property (nonatomic, copy) NSString *token;
//注册ip
@property (nonatomic, copy) NSString *modifyIp;
//是否实名(1代表实名认证，0代表未实名认证)
@property(nonatomic,strong)NSString *nameChecked;
//是否开通金账户（1已开通，0未开通）
@property(nonatomic,copy)NSString *magicUser;
//账户余额
@property(nonatomic,copy)NSString *balance;
//上次登录时间
@property(nonatomic,copy)NSString *beforeLoginTime;
@end
