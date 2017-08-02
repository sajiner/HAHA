//
//  XDepositoryAccountView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XDepositoryAccountView.h"
#import "XLeftAndRightLabelView.h"
#import "XDepositoryAccountModel.h"

@implementation XDepositoryAccountView {
    XLeftAndRightLabelView *_accountName;
    XLeftAndRightLabelView *_phoneView;
    XLeftAndRightLabelView *_fuyouAccountView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElement];
    }
    return self;
}

- (void)initElement {
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView];
    
    XLeftAndRightLabelView *accountName = [XLeftAndRightLabelView viewWithTitleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].grayBlackColor contentFont:[XAppContext appFonts].font_15 title:@"开户姓名"];
    [self addSubview:accountName];
    _accountName = accountName;
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView1];
    
    XLeftAndRightLabelView *phoneView = [XLeftAndRightLabelView viewWithTitleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].grayBlackColor contentFont:[XAppContext appFonts].font_15 title:@"手机号"];
    [self addSubview:phoneView];
    _phoneView = phoneView;
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView2];
    
    XLeftAndRightLabelView *fuyouAccountView = [XLeftAndRightLabelView viewWithTitleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].grayBlackColor contentFont:[XAppContext appFonts].font_15 title:@"富友金账户"];
    [self addSubview:fuyouAccountView];
    _fuyouAccountView = fuyouAccountView;
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView3];
    
    // 客户资金由恒丰银行专业存管
    UIButton *cunGuanButton = [UIButton buttonWithFrame:CGRectMake(60, ScreenHeight - 144, ScreenWidth - 120, 44) title:@"客户资金由恒丰银行专业存管" titleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_13 image:[UIImage imageNamed:@"bank_certify"]];
    cunGuanButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    cunGuanButton.userInteractionEnabled = NO;
    [self addSubview:cunGuanButton];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [accountName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(accountName.mas_bottom).offset(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView1.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneView.mas_bottom).offset(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [fuyouAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fuyouAccountView.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(XDepositoryAccountModel *)model {
    _model = model;
    
    NSMutableString *strM0 = [[NSMutableString alloc] initWithString:model.u_real_name];
    [strM0 replaceCharactersInRange:NSMakeRange(1, strM0.length - 1) withString:@"**"];
    _accountName.content = strM0;
    
    NSMutableString *strM = [[NSMutableString alloc] initWithString:model.u_user_phone];
    [strM replaceCharactersInRange:NSMakeRange(3, strM.length - 7) withString:@"****"];
    _phoneView.content = strM;
    
    NSMutableString *strM1 = [[NSMutableString alloc] initWithString:model.g_fuiou_login_id];
    [strM1 replaceCharactersInRange:NSMakeRange(4, strM.length - 8) withString:@"*******"];
    _fuyouAccountView.content = strM1;
}

@end
