//
//  XAssetpackageInvestApi.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/23.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

@interface XAssetpackageInvestApi : XRequestApi
/*
 token：用户令牌
 amount：投资金额
 income：预期收益
 projectId：项目ID
 ip：ip地址
 terminal：投资终端(1PC、2APP_ios、3APP_andriod、4WX)
 */
- (instancetype)initWithToken:(NSString *)token amount:(CGFloat)amount income:(CGFloat)income projectId:(NSInteger)pid ip:(NSString *)ip terminal:(NSInteger)terminal;
@end
