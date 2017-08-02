//
//  XLoginView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/14.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIconAndTextFieldView.h"
//登录界面View
@interface XLoginView : UIView
//请输入用户名...
@property(nonatomic,strong)XIconAndTextFieldView *accountView;
//请输入登录密码
@property(nonatomic,strong)XIconAndTextFieldView *pwdView;
//记住用户名对号btn
@property(nonatomic,strong)UIButton *rememberBtn;
//同意对号btn
@property(nonatomic,strong)UIButton *agreeProtocolBtn;
//协议btn
@property(nonatomic,strong)UIButton *protocolBtn;
//登录btn
@property(nonatomic,strong)UIButton *loginBtn;
//忘记密码按钮
@property(nonatomic,strong)UIButton *forgetPwdBtn;
//立即注册按钮
@property(nonatomic,strong)UIButton *registBtn;
@end
