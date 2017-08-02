//
//  XMineModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMineModel : NSObject
// 是否开金账户 （0是未开金账户，1是开金账户）
@property (nonatomic, copy) NSString *u_is_magic_user;
// 金账户id
@property (nonatomic, copy) NSString *g_fuiou_login_id;
// 是否实名认证（0代表未验证，1表示已验证）
@property (nonatomic, copy) NSString *u_is_real_name_checked;
// 用户名
@property (nonatomic, copy) NSString *u_user_name;
// 用户手机号
@property (nonatomic, copy) NSString *u_user_phone;
// 银行卡号
@property (nonatomic, copy) NSString *g_card_no;
// 可用余额
@property (nonatomic, copy) NSString *a_balance;
// 资产总额
@property (nonatomic, copy) NSString *a_total;
// 累计收益
@property (nonatomic, copy) NSString *a_interest_a;
// 待收收益
@property (nonatomic, copy) NSString *a_interest_total_w;
//实名认证的姓名
@property(nonatomic,copy)NSString *u_real_name;
//实名认证的身份证号
@property(nonatomic,copy)NSString *u_id_number;

/* 处理后的数据 */
// 可用余额
@property (nonatomic, copy) NSString *a_balance0;
// 资产总额
@property (nonatomic, copy) NSString *a_total0;
// 累计收益
@property (nonatomic, copy) NSString *a_interest_a0;
// 待收收益
@property (nonatomic, copy) NSString *a_interest_total_w0;

@end
