//
//  XMySanBiaoDetailModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMySanBiaoDetailModel : NSObject
// 总期数
@property (nonatomic, copy) NSString *countPeriod;
// 当前期
@property (nonatomic, copy) NSString *returnPeriod;
// 待收金额
@property (nonatomic, copy) NSString *paymentAcount;
// 待收本金
@property (nonatomic, copy) NSString *paymentPrincipal;
// 待收利息
@property (nonatomic, copy) NSString *paymentInterest;
// 已收收益
@property (nonatomic, copy) NSString *endPaymentInterest;
// 回款计划
@property (nonatomic, strong) NSArray *list;
// 借款协议
@property (nonatomic, copy) NSString *contractUrl;

/* 处理后的数据 */
// 待收金额
@property (nonatomic, copy) NSString *paymentAcount0;
// 待收本金
@property (nonatomic, copy) NSString *paymentPrincipal0;
// 待收利息
@property (nonatomic, copy) NSString *paymentInterest0;
// 已收收益
@property (nonatomic, copy) NSString *endPaymentInterest0;

@end
