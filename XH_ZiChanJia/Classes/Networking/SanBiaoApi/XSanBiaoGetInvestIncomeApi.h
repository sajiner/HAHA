//
//  XSanBiaoGetInvestIncomeApi.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/31.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

//amount：投资金额
//projectId：项目ID

@interface XSanBiaoGetInvestIncomeApi : XRequestApi

- (instancetype)initWithAmout:(CGFloat)amount pId:(NSInteger)pid;

@end
