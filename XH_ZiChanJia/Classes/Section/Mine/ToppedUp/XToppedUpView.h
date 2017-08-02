//
//  XToppedUpView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XToppedUpView;
@protocol XToppedUpViewDelegate <NSObject>

- (void)toppedUpView: (XToppedUpView *)toppedUpView didClickOfButton: (UIButton *)sneder;

@end

@interface XToppedUpView : UIView

@property (nonatomic, weak) id<XToppedUpViewDelegate> toppedUpDelegate;
// 充值金额
@property (nonatomic, copy) NSString *moneyAmount;
// 银行卡
@property (nonatomic, copy) NSString *bankCardNum;
// 可用余额
@property (nonatomic, copy) NSString *balance;
// 银行卡图标名
@property (nonatomic, copy) NSString *iconName;
// 充值金额
@property (nonatomic, strong) UITextField *content;

@end
