//
//  XRegisterDetailView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIconAndTextFieldView.h"
#import "XTipsView.h"
//注册页面DetailView

@interface XRegisterDetailView : UIView
//返回按钮
@property(nonatomic,strong)UIButton *leftBackButton;
//用户名View
@property(nonatomic,strong)XIconAndTextFieldView *userNameView;
//登录密码view
@property(nonatomic,strong)XIconAndTextFieldView *passwordView;
@property(nonatomic,strong)XTipsView *tips;

//提交注册按钮
@property(nonatomic,strong)UIButton *registBtn;


@end
