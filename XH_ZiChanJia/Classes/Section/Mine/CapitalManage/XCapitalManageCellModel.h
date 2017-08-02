//
//  XCapitalManageCellModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCapitalManageCellModel : NSObject
// 交易流水号
@property (nonatomic, copy) NSString *serialNo;
// 交易金额
@property (nonatomic, copy) NSString *amount;
// 交易类型(1.投资 2.充值 3.提现 4回收本金 5回收利息 6提现手续费 7充值手续费 8加急费 9罚息 10滞纳金 11外访费服务费 12催收服务费 13前期服务费	14分期服务费 15违约金 16转入手续费 17融资放款 18退款 )
@property (nonatomic, copy) NSString *type;
// 交易状态(1.交易冻结 2.交易成功 3.交易失败 4.放款已处理 5解冻已处理 )
@property (nonatomic, copy) NSString *status;
// 交易时间
@property (nonatomic, copy) NSString *date;
// 收 0， 付 1；
@property (nonatomic, copy) NSString *receivePay;


/*  是否展开 */
@property (assign, nonatomic) BOOL fold;

/* 处理后的数据 */
@property (nonatomic, copy) NSString *date0;
// 交易金额
@property (nonatomic, copy) NSString *amount0;

@end
