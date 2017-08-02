//
//  XMySanBiaoReturnPlanModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMySanBiaoReturnPlanModel : NSObject
// 回款状态（0未回、1已回）
@property (nonatomic, copy) NSString *paymentStues;
// 计划回款时间
@property (nonatomic, copy) NSString *paymentTime;
// 应回款本金
@property (nonatomic, copy) NSString *paymentPrincipal;
// 应回款利息
@property (nonatomic, copy) NSString *paymentInterest;
// 应回款总金额
@property (nonatomic, copy) NSString *paymentTotalAmount;

/* 处理后的数据 */
// 计划回款时间
@property (nonatomic, copy) NSString *paymentTime0;
// 应回款本金
@property (nonatomic, copy) NSString *paymentPrincipal0;
// 应回款利息
@property (nonatomic, copy) NSString *paymenterest0;
// 应回款总金额
@property (nonatomic, copy) NSString *paymentTotalAmount0;

@end
