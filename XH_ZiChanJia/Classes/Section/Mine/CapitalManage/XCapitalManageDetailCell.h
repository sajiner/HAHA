//
//  XCapitalManageDetailCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLeftAndRightLabelView;
@interface XCapitalManageDetailCell : UIView
// 交易流水号
@property (nonatomic, strong) XLeftAndRightLabelView *serialView;
// 交易状态
@property (nonatomic, strong) XLeftAndRightLabelView *statusView;

@end
