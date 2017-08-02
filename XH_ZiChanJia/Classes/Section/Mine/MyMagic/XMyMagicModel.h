//
//  XMyMagicModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMyMagicModel : NSObject
/**
 账户总额
 */
@property (nonatomic, copy) NSString *signUserTotal;

/**
 已赚取利息
 */
@property (nonatomic, copy) NSString *signUserInvestA;

/**
 总计待收利息
 */
@property (nonatomic, copy) NSString *signUserInterestTotalW;

/**
 可用余额
 */
@property (nonatomic, copy) NSString *signUserBalance;

/************ 处理后的数据 ******************/
/**
 账户总额
 */
@property (nonatomic, copy, readonly) NSString *signUserTotal0;

/**
 已赚取利息
 */
@property (nonatomic, copy, readonly) NSString *signUserInvestA0;

/**
 总计待收利息
 */
@property (nonatomic, copy, readonly) NSString *signUserInterestTotalW0;

/**
 可用余额
 */
@property (nonatomic, copy, readonly) NSString *signUserBalance0;

@end
