//
//  XWithdrawCashViewController.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWithdrawCashViewController : UIViewController

// 可用余额
@property (nonatomic, copy) NSString *balance;
// 处理后的可用余额
@property (nonatomic, copy) NSString *balance0;

@end
