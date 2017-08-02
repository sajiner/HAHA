//
//  XSanBiaoGetInvestmentListApi.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

@interface XSanBiaoGetInvestmentListApi : XRequestApi
- (instancetype)initWithPId:(NSInteger)pid pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum;

@end
