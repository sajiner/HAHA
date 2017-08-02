//
//  XSanBiaoPayListModel.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/28.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSanBiaoPayListModel : NSObject
//期次
@property (nonatomic,assign)NSInteger d_months;
//预计划款时间
@property (nonatomic,copy)NSString *d_pay_dayx;
//应收本金
@property (nonatomic,assign)CGFloat d_pay_amount;
//应收利息
@property (nonatomic,assign)CGFloat d_interest_backshould;

@end
