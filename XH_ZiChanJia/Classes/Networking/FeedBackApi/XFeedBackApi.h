//
//  XFeedBackApi.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/11/7.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRequestApi.h"
//意见反馈API
@interface XFeedBackApi : XRequestApi

- (instancetype)initWithContent:(NSString *)content Token:(NSString *)token;

@end
