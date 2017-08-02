//
//  XSanBiaoGetRepaymentPlanApi.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

@interface XSanBiaoGetRepaymentPlanApi : XRequestApi

/*
 *pagesize 每页数据
 *pageNum 哪一页
 */

- (instancetype)initWitToken:(NSString *)token pId:(NSInteger)pid pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum;

@end
