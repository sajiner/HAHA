//
//  XDepositoryAccountModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDepositoryAccountModel : NSObject
// 用户名
@property (nonatomic, copy) NSString *u_real_name;
// 用户手机号
@property (nonatomic, copy) NSString *u_user_phone;
// 富友账号
@property (nonatomic, copy) NSString *g_fuiou_login_id;

@end
