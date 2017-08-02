//
//  XLoginView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/14.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XLoginView.h"
@implementation XLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
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
    //请输入用户名/手机号码/邮箱
    self.accountView = [[XIconAndTextFieldView alloc]init];
    self.accountView.textField.returnKeyType = UIReturnKeyDone;
    [self.accountView setupIconImg:@"username" placeHolder:@"请输入用户名/手机号码/邮箱"];
    [self addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(130);
        make.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    //请输入登录密码
    self.pwdView = [[XIconAndTextFieldView alloc]init];
    self.pwdView.textField.returnKeyType = UIReturnKeyDone;
    self.pwdView.textField.secureTextEntry = YES;
    [self.pwdView setupIconImg:@"password" placeHolder:@"请输入登录密码"];
    [self.pwdView resetTopLineWithLeftMargin:52];
    [self addSubview:self.pwdView];
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    //请输入登录密码下面的line
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    //记住用户名对号btn
    self.rememberBtn = [[UIButton alloc]init];
    self.rememberBtn.selected = YES;
    [self.rememberBtn setEnlargeEdgeWithTop:5 right:5 bottom:5 left:5];
    [self.rememberBtn setBackgroundImage:[UIImage imageNamed:@"tick_normal"] forState:UIControlStateNormal];
    [self.rememberBtn setBackgroundImage:[UIImage imageNamed:@"tick_selected"] forState:UIControlStateSelected];
    [self addSubview:self.rememberBtn];
    [self.rememberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(12);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    //记录用户名Label
    UILabel *rememberLabel = [[UILabel alloc]init];
    rememberLabel.text = @"记住用户名";
    rememberLabel.textColor = [XAppContext appColors].blackColor;
    rememberLabel.font = [XAppContext appFonts].font_13;
    [self addSubview:rememberLabel];
    [rememberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rememberBtn.mas_centerY);
        make.left.equalTo(self.rememberBtn.mas_right).offset(9);
    }];
    //同意对号btn
    self.agreeProtocolBtn = [[UIButton alloc]init];
    self.agreeProtocolBtn.selected = YES;
    [self.agreeProtocolBtn setEnlargeEdgeWithTop:5 right:5 bottom:5 left:5];
    [self.agreeProtocolBtn setBackgroundImage:[UIImage imageNamed:@"tick_normal"] forState:UIControlStateNormal];
    [self.agreeProtocolBtn setBackgroundImage:[UIImage imageNamed:@"tick_selected"] forState:UIControlStateSelected];
    [self addSubview:self.agreeProtocolBtn];
    [self.agreeProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberBtn.mas_bottom).offset(8);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    //同意Label
    UILabel *agreeLabel = [[UILabel alloc]init];
    agreeLabel.text = @"同意";
    agreeLabel.textColor = [XAppContext appColors].blackColor;
    agreeLabel.font = [XAppContext appFonts].font_13;
    [self addSubview:agreeLabel];
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.agreeProtocolBtn.mas_centerY);
        make.left.equalTo(self.agreeProtocolBtn.mas_right).offset(9);
    }];
    //协议btn
    self.protocolBtn = [[UIButton alloc]init];
    [self.protocolBtn setTitle:@"《资产家平台服务协议》" forState:UIControlStateNormal];
    [self.protocolBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.protocolBtn.titleLabel.font = [XAppContext appFonts].font_13;
    [self addSubview:self.protocolBtn];
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(agreeLabel.mas_centerY);
        make.left.equalTo(agreeLabel.mas_right).offset(5);
    }];
    //登录按钮
    self.loginBtn = [[UIButton alloc]init];
    [self.loginBtn setBackgroundColor:[XAppContext appColors].blueColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.agreeProtocolBtn.mas_bottom).offset(22);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
    //客户资金...
    UILabel *attentionLbl = [[UILabel alloc]init];
    attentionLbl.text = @"客户资金由恒丰银行专业存管";
    attentionLbl.textColor = [XAppContext appColors].grayBlackColor;
    attentionLbl.font = [XAppContext appFonts].font_13;
    [self addSubview:attentionLbl];
    [attentionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(11);
        make.centerX.equalTo(self.mas_centerX);
    }];
    //绿色icon
    UIImageView *greenIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bank_certify"]];
    greenIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:greenIcon];
    [greenIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(attentionLbl.mas_top);
        make.right.equalTo(attentionLbl.mas_left).offset(-5);
    }];
    //忘记密码按钮
    self.forgetPwdBtn = [[UIButton alloc]init];
    [self.forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPwdBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.forgetPwdBtn.titleLabel.font = [XAppContext appFonts].font_15;
    [self addSubview:self.forgetPwdBtn];
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    //立即注册按钮
    self.registBtn = [[UIButton alloc]init];
    [self.registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = [XAppContext appFonts].font_15;
    [self addSubview:self.registBtn];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetPwdBtn.mas_top);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

@end
