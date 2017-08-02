//
//  XMyJiaYingDetailModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMyJiaYingDetailModel : NSObject
/// 投资金额
@property (nonatomic, copy) NSString *amount;
/// 合同地址
@property (nonatomic, copy) NSString *contracturl;
/// 标的名称
@property (nonatomic, copy) NSString *markname;
/// 标的期限
@property (nonatomic, copy) NSString *markdeadline;
/// 标的标号
@property (nonatomic, copy) NSString *marknum;
///  标的利率
@property (nonatomic, copy) NSString *markrate;

/************* 处理数据 ****************/
/// 投资金额
@property (nonatomic, copy) NSString *amount0;

@end
