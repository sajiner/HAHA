//
//  XMyJiaYingHeaderModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMyJiaYingHeaderModel : NSObject

// 待收本金
@property (nonatomic, copy) NSString *investamonut;
// 累计收益
@property (nonatomic, copy) NSString *endPredictMoney;
// 待收收益
@property (nonatomic, copy) NSString *predictMoney;

// 待收本金
@property (nonatomic, copy, readonly) NSString *investamonut0;
// 累计收益
@property (nonatomic, copy, readonly) NSString *endPredictMoney0;
// 待收收益
@property (nonatomic, copy, readonly) NSString *predictMoney0;

@end
