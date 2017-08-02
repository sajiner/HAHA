//
//  XSanBiaoInvestModel.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/28.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XSanBiaoInvestSubModel;


@interface XSanBiaoInvestModel : NSObject
//总金额
@property (nonatomic,assign)CGFloat money;
//人数
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,strong)NSArray<XSanBiaoInvestSubModel *> *listArr;
@end


@interface XSanBiaoInvestSubModel : NSObject
//投资时间
@property (nonatomic,copy)NSString *i_invest_time;
//投资人
@property (nonatomic,copy)NSString *u_user_name;
//投资金额
@property (nonatomic,assign)CGFloat i_invest_amount;

@end
