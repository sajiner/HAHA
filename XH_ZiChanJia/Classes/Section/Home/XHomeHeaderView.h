//
//  XHomeHeaderView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCustomerButtonView.h"
#import "XCycleView.h"
//首页头部View
@interface XHomeHeaderView : UIView
//顶部的scrollView
@property(nonatomic,strong)XCycleView *cycleScrollView;
//依次为：银行管理-备付金-技术安全-资产无忧，四个按钮
@property(nonatomic,strong)XCustomerButtonView *btn1;
@property(nonatomic,strong)XCustomerButtonView *btn2;
@property(nonatomic,strong)XCustomerButtonView *btn3;
@property(nonatomic,strong)XCustomerButtonView *btn4;
//累计成交规模String
@property(nonatomic,copy)NSString *turnoverString;
//累计总用户数String
@property(nonatomic,copy)NSString *userNumberString;
//公告栏View
@property(nonatomic,strong)UIButton *notifyView;
//公告标题String
@property(nonatomic,copy)NSString *notifyTitleString;
@end
