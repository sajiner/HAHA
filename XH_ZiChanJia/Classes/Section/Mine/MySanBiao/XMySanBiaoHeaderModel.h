//
//  XMySanBiaoHeaderModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMySanBiaoHeaderModel : NSObject
// 待收本金
@property (nonatomic, copy) NSString *waitPaymentAmount;
// 累计收益
@property (nonatomic, copy) NSString *endPaymentInterest;
// 待收收益
@property (nonatomic, copy) NSString *waitPaymentInterest;

// 待收本金
@property (nonatomic, copy) NSString *waitPaymentAmount0;
// 累计收益
@property (nonatomic, copy) NSString *endPaymentInterest0;
// 待收收益
@property (nonatomic, copy) NSString *waitPaymentInterest0;

@end
