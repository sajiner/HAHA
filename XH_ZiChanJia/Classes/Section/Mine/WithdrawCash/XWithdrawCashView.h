//
//  XWithdrawCashView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWithdrawCashView;
@protocol XWithdrawCashViewDelegate <NSObject>

- (void)withdrawCashView: (XWithdrawCashView *)withdrawCashView didClickOfButton: (UIButton *)sneder;

@end

@interface XWithdrawCashView : UIView

@property (nonatomic, weak) id<XWithdrawCashViewDelegate> withdrawCashDelegate;
// 提现金额
@property (nonatomic, strong)  UITextField *withDrawMoneyTextField;
// 提现后余额
@property (nonatomic, copy) NSString *drawCashAfterAmount;
// 银行卡
@property (nonatomic, copy) NSString *bankCardNum;
// 可用余额
@property (nonatomic, copy) NSString *balance;
// 银行卡图标名
@property (nonatomic, copy) NSString *iconName;

@end
