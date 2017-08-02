//
//  XHomeView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCustomerButtonView.h"

//首页视图View
@interface XHomeView : UIView
//顶部的scrollView
@property(nonatomic,strong)UIScrollView *topScrollView;
//轮播图的四个点
@property(nonatomic,strong)UIPageControl *pageController;
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
@property(nonatomic,strong)UIView *notifyView;
//公告标题String
@property(nonatomic,copy)NSString *notifyTitleString;
//tableview
@property(nonatomic,strong)UITableView *tableView;
//年
@property(nonatomic,copy)NSString *yearString;
//天
@property(nonatomic,copy)NSString *dayString;
//时
@property(nonatomic,copy)NSString *hourString;
//分
@property(nonatomic,copy)NSString *minuteString;
@end
