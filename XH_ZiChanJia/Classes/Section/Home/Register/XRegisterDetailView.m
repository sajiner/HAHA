//
//  XRegisterDetailView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRegisterDetailView.h"
//#import "UIImageView+XTips.h"
#import "XTipsView.h"
@implementation XRegisterDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self= [super initWithFrame:frame]){
        [self setupSubViews];
        self.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return self;
}

- (void)setupSubViews {
    //返回按钮
    self.leftBackButton = [[UIButton alloc]init];
    [self.leftBackButton setBackgroundImage:[UIImage imageNamed:@"back_blue"] forState:UIControlStateNormal];
    [self addSubview:self.leftBackButton];
    [self.leftBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(28);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    //资产家图片
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = [UIImage imageNamed:@"login_log"];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.leftBackButton.mas_bottom).offset(10);
    }];
    //用户名
    self.userNameView = [[XIconAndTextFieldView alloc]init];
    [self.userNameView setupIconImg:@"username" placeHolder:@"请输入用户名"];
    [self addSubview:self.userNameView];
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftBackButton.mas_bottom).offset(130);
        make.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    //登录密码
    self.passwordView = [[XIconAndTextFieldView alloc]init];
    self.passwordView.textField.secureTextEntry = YES;
    [self.passwordView setupIconImg:@"password" placeHolder:@"请输入登录密码"];
    [self addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    [self.passwordView.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_top);
        make.left.equalTo(self.passwordView).offset(52);
        make.right.equalTo(self.passwordView.mas_right);
        make.height.equalTo(@1);
    }];
    //输入登录密码下面的line
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    //提交注册
    self.registBtn = [[UIButton alloc]init];
    [self.registBtn setBackgroundColor:[XAppContext appColors].blueColor];
    [self.registBtn setTitle:@"提交注册" forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.registBtn.layer.cornerRadius = 5;
    self.registBtn.layer.masksToBounds = YES;
    [self addSubview:self.registBtn];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(22);
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
        make.top.equalTo(self.registBtn.mas_bottom).offset(11);
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
    //温馨提示
    XTipsView *tips = [[XTipsView alloc]init];
    self.tips = tips;
    [self addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(attentionLbl.mas_bottom).offset(35);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@(tips.height));
    }];
}

@end
