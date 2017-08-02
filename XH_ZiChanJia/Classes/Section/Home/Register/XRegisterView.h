//
//  XRegisterView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIconAndTextFieldView.h"
//注册页面View
@interface XRegisterView : UIView
//请输入有效的手机号
@property(nonatomic,strong)XIconAndTextFieldView *phoneNumberView;
//请输入短信验证码
@property(nonatomic,strong)XIconAndTextFieldView *smsVerfiCodeView;
//免费获取按钮
@property(nonatomic,strong)UIButton *getVerifiCodeBtn;
//”收不到短信“文字
@property(nonatomic,strong)UILabel *cantReceiveLabel;
//试试语音验证码按钮
@property(nonatomic,strong)UIButton *voiceVerifiBtn;
//电话拨打中...文字Label
@property(nonatomic,strong)UILabel *callingLabel;
//我有邀请码按钮
@property(nonatomic,strong)UIButton *haveInviteCodeBtn;
//我有邀请码下面的line
@property(nonatomic,strong)UIView *haveCodeBottomLine;

//arrowImg
@property(nonatomic,strong)UIImageView *arrowImg;
//请输入邀请码View
@property(nonatomic,strong)XIconAndTextFieldView *inputInviteView;
//请输入邀请码下面的部分
@property(nonatomic,strong)UIView *bottomContainerView;
//对号按钮
@property(nonatomic,strong)UIButton *agreeBtn;
//资产家平台服务协议按钮
@property(nonatomic,strong)UIButton *protocolBtn;
//立即注册按钮
@property(nonatomic,strong)UIButton *registerBtn;
//立即登录按钮
@property(nonatomic,strong)UIButton *loginBtn;

@end
