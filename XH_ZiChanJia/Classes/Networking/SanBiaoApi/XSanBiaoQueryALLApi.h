//
//  XSanBiaoQueryALLApi.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"

@interface XSanBiaoQueryALLApi : XRequestApi

- (instancetype)initWithStatus:(NSInteger)status term:(NSInteger)term profit:(NSInteger)profit type:(NSInteger)type pageSize:(NSInteger)pageSize pageNumber:(NSInteger)pageNumber;

@end
