//
//  XCheckVersionApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2017/1/3.
//  Copyright © 2017年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//检查版本更新API
@interface XCheckVersionApi : XRequestApi

- (instancetype)initWithSystem:(NSString *)system;

@end
