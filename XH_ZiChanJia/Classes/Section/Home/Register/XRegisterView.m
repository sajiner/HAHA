//
//  XRegisterView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRegisterView.h"
@implementation XRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self= [super initWithFrame:frame]){
        [self setupSubViews];
        self.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return self;
}
- (void)setupSubViews {
    //资产家图片
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = [UIImage imageNamed:@"login_log"];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    //手机号码
    self.phoneNumberView = [[XIconAndTextFieldView alloc]init];
    self.phoneNumberView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneNumberView setupIconImg:@"phoneNumber" placeHolder:@"请输入有效的手机号码"];
    [self addSubview:self.phoneNumberView];
    [self.phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(130);
        make.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    //短信验证码
    self.smsVerfiCodeView = [[XIconAndTextFieldView alloc]init];
    self.smsVerfiCodeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.smsVerfiCodeView.textField.clearButtonMode = UITextFieldViewModeNever;
    [self.smsVerfiCodeView setupIconImg:@"messageCode" placeHolder:@"请输入短信验证码"];
    [self addSubview:self.smsVerfiCodeView];
    [self.smsVerfiCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumberView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    [self.smsVerfiCodeView.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smsVerfiCodeView.mas_top);
        make.left.equalTo(self.smsVerfiCodeView).offset(52);
        make.right.equalTo(self.smsVerfiCodeView.mas_right);
        make.height.equalTo(@1);
    }];
    //下面的横线
    UIView *smsBottomLine = [[UIView alloc]init];
    smsBottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:smsBottomLine];
    [smsBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smsVerfiCodeView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    //竖线
    UIView *verticalLine = [[UIView alloc]init];
    verticalLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.smsVerfiCodeView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smsVerfiCodeView.mas_top).offset(10);
        make.bottom.equalTo(self.smsVerfiCodeView.mas_bottom).offset(-10);
        make.right.equalTo(self.smsVerfiCodeView.mas_right).offset(-90);
        make.width.equalTo(@1);
    }];
    //免费获取按钮
    self.getVerifiCodeBtn = [[UIButton alloc]init];
    [self.getVerifiCodeBtn setTitle:@"免费获取" forState:UIControlStateNormal];
    [self.getVerifiCodeBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.getVerifiCodeBtn.titleLabel.font = [XAppContext appFonts].font_15;
    [self.smsVerfiCodeView addSubview:self.getVerifiCodeBtn];
    [self.getVerifiCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.smsVerfiCodeView.mas_centerY);
        make.right.equalTo(self.smsVerfiCodeView.mas_right).offset(-13);
        make.left.equalTo(verticalLine.mas_right).offset(13);
    }];
    //语音验证码View
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [XAppContext appColors].yellowColor;
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smsBottomLine.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@30);
    }];
    //实时语音验证码按钮
    self.voiceVerifiBtn = [[UIButton alloc]init];
    [self.voiceVerifiBtn setTitle:@"试试语音验证码" forState:UIControlStateNormal];
    [self.voiceVerifiBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.voiceVerifiBtn.titleLabel.font = [XAppContext appFonts].font_13;
    [backgroundView addSubview:self.voiceVerifiBtn];
    [self.voiceVerifiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backgroundView.mas_centerY);
        make.right.equalTo(backgroundView.mas_right).offset(-15);
    }];
    //“收不到短信”
    self.cantReceiveLabel = [[UILabel alloc]init];
    self.cantReceiveLabel.text = @"收不到短信？";
    self.cantReceiveLabel.font = [XAppContext appFonts].font_13;
    self.cantReceiveLabel.textColor = [XAppContext appColors].grayBlackColor;
    [backgroundView addSubview:self.cantReceiveLabel];
    [self.cantReceiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.voiceVerifiBtn.mas_centerY);
        make.right.equalTo(self.voiceVerifiBtn.mas_left);
    }];
    //“电话拨打中...”
    self.callingLabel = [[UILabel alloc]init];
    self.callingLabel.font = [XAppContext appFonts].font_13;
    self.callingLabel.hidden = YES;
    [backgroundView addSubview:self.callingLabel];
    [self.callingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backgroundView.mas_centerY);
        make.right.equalTo(backgroundView.mas_right).offset(-15);
    }];
    //底部线条
    UIView *voiceBottomLine = [[UIView alloc]init];
    voiceBottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:voiceBottomLine];
    [voiceBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    //我有邀请码
    self.haveInviteCodeBtn = [[UIButton alloc]init];
    [self.haveInviteCodeBtn setTitle:@"我有邀请码" forState:UIControlStateNormal];
    [self.haveInviteCodeBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.haveInviteCodeBtn.titleLabel.font = [XAppContext appFonts].font_12;
    [self addSubview:self.haveInviteCodeBtn];
    [self.haveInviteCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(voiceBottomLine.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    //箭头
    self.arrowImg = [[UIImageView alloc]init];
    self.arrowImg.image = [UIImage imageNamed:@"arrow_down"];
    self.arrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.haveInviteCodeBtn.mas_centerY);
        make.left.equalTo(self.haveInviteCodeBtn.mas_right).offset(5);
    }];
    //底部线条
    self.haveCodeBottomLine = [[UIView alloc]init];
    self.haveCodeBottomLine.hidden = YES;
    self.haveCodeBottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:self.haveCodeBottomLine];
    [self.haveCodeBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.haveInviteCodeBtn.mas_bottom).offset(5);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    //请输入邀请码
    self.inputInviteView = [[XIconAndTextFieldView alloc]init];
    self.inputInviteView.topLine.hidden = YES;
    [self.inputInviteView setupIconImg:@"inviteCode" placeHolder:@"请输入邀请码(选填)"];
    self.inputInviteView.hidden = YES;
    [self addSubview:self.inputInviteView];
    [self.inputInviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.haveCodeBottomLine.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    //请输入邀请码下面的容器View
    self.bottomContainerView = [[UIView alloc]init];
    [self addSubview:self.bottomContainerView];
    [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.haveCodeBottomLine.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@140);
    }];
    //容器View顶部的线条
    UIView *containerTopLine = [[UIView alloc]init];
    containerTopLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.bottomContainerView addSubview:containerTopLine];
    [containerTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomContainerView.mas_top);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    //对号按钮
    self.agreeBtn = [[UIButton alloc]init];
    self.agreeBtn.selected = YES;
    [self.agreeBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"tick_normal"] forState:UIControlStateNormal];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"tick_selected"] forState:UIControlStateSelected];
    [self.agreeBtn addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomContainerView addSubview:self.agreeBtn];
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerTopLine.mas_bottom).offset(15);
        make.left.equalTo(self.bottomContainerView.mas_left).offset(15);
    }];
    //"同意"
    UILabel *agreeLabel = [[UILabel alloc]init];
    agreeLabel.text = @"同意";
    agreeLabel.textColor = [XAppContext appColors].blackColor;
    agreeLabel.font = [XAppContext appFonts].font_13;
    [self.bottomContainerView addSubview:agreeLabel];
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.agreeBtn.mas_centerY);
        make.left.equalTo(self.agreeBtn.mas_right).offset(8);
    }];
    //资产家平台服务协议按钮
    self.protocolBtn = [[UIButton alloc]init];
    [self.protocolBtn setTitle:@"《资产家平台服务协议》" forState:UIControlStateNormal];
    [self.protocolBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.protocolBtn.titleLabel.font = [XAppContext appFonts].font_13;
    [self.bottomContainerView addSubview:self.protocolBtn];
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.agreeBtn.mas_centerY);
        make.left.equalTo(agreeLabel.mas_right).offset(6);
    }];
    //立即注册按钮
    self.registerBtn = [[UIButton alloc]init];
    [self.registerBtn setBackgroundColor:[XAppContext appColors].blueColor];
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    [self.bottomContainerView addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.protocolBtn.mas_bottom).offset(23);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
    //客户资金...
    UILabel *attentionLbl = [[UILabel alloc]init];
    attentionLbl.text = @"客户资金由恒丰银行专业存管";
    attentionLbl.textColor = [XAppContext appColors].grayBlackColor;
    attentionLbl.font = [XAppContext appFonts].font_13;
    [self.bottomContainerView addSubview:attentionLbl];
    [attentionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerBtn.mas_bottom).offset(11);
        make.centerX.equalTo(self.mas_centerX);
    }];
    //绿色icon
    UIImageView *greenIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bank_certify"]];
    greenIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.bottomContainerView addSubview:greenIcon];
    [greenIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(attentionLbl.mas_top);
        make.right.equalTo(attentionLbl.mas_left).offset(-5);
    }];
    //立即登录
    self.loginBtn = [[UIButton alloc]init];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [XAppContext appFonts].font_15;
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)agreeClick {
    self.agreeBtn.selected = !self.agreeBtn.selected;
    if(self.agreeBtn.selected){
        [self.registerBtn setBackgroundColor:[XAppContext appColors].blueColor];
        self.registerBtn.enabled = YES;
    }else{
        [self.registerBtn setBackgroundColor:[XAppContext appColors].lightGrayColor];
        self.registerBtn.enabled = NO;
    }
}
@end
