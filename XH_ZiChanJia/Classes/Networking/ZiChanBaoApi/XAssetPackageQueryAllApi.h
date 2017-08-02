//
//  XAssetPackageQueryAllApi.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

@interface XAssetPackageQueryAllApi : XRequestApi
/**
 *  status 项目状态 (按顺序传1、2、3、4,全部传0)
 *  term项目期限(按顺序传1、2、3全部传0)
 *  profit项目收益(按顺序传1、2、3,全部传0)
 *  pageNum
 *  pageSize
 **/

- (instancetype)initWithStatus:(NSInteger)status term:(NSInteger)term profit:(NSInteger)profit pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize;

@end
