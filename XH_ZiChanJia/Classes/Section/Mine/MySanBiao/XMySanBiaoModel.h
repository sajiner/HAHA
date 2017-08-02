//
//  XMySanBiaoModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMySanBiaoModel : NSObject
// 项目名称
@property (nonatomic, copy) NSString *projectName;
// 投资项目ID
@property (nonatomic, copy) NSString *projectId;
// 投资资金
@property (nonatomic, copy) NSString *investAmount;
// 预计收益
@property (nonatomic, copy) NSString *predictMoney;
// 已回款
@property (nonatomic, copy) NSString *repayMoney;
// 到期日期
@property (nonatomic, copy) NSString *lastDate;
// 投资状态 (1-投资中，2-回款中，3-已结束, -1表示全部)
@property (nonatomic, copy) NSString *investStatus;
// 用户投资记录id
@property (nonatomic, copy) NSString *investId;
//
@property (nonatomic, copy) NSString *markNumber;
// 为10是已流标状态
@property (nonatomic, copy) NSString *projectStatus;

@property (nonatomic, copy) NSString *projectDeadline;

/* 处理后的数据 */
// 投资资金
@property (nonatomic, copy) NSString *investAmount0;
// 预计收益
@property (nonatomic, copy) NSString *predictMoney0;
// 已回款
@property (nonatomic, copy) NSString *repayMoney0;
// 到期日期
@property (nonatomic, copy) NSString *lastDate0;

@end
