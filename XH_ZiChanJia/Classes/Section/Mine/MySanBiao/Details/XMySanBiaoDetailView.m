//
//  XMySanBiaoDetailView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoDetailView.h"
#import "XLeftAndRightLabelView.h"
#import "XFormView.h"
#import "XMySanBiaoModel.h"
#import "UIView+XExtension.h"
#import "XMySanBiaoDetailModel.h"
#import "XMySanBiaoReturnPlanModel.h"

@interface XMySanBiaoDetailView () {
    UIButton *_loanAgreementButton;
}

// 回款详细信息数据
@property (nonatomic, strong) NSMutableArray *payBackContents;

@property (nonatomic, weak) UIImageView *backView;

// 回款计划数据
@property (nonatomic, strong) NSMutableArray *payBackplans;

@end

@implementation XMySanBiaoDetailView {
    // 项目名称
    UILabel *_projectNameLabel;
    // 投资项目ID
    UILabel *_projectIdLabel;
    // 投资资金
    UILabel *_investAmountLabel;
    // 预计收益
    UILabel *_predictMoneyLabel;
    // 到期日期
    UILabel *_lastDateLabel;
    // 已回款
    UILabel *_repayMoneyLabel;
    // 投资状态图表
    UIImageView *_stateIconView;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame planNums:(NSUInteger)planNums {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElementWithPlanNums: planNums];
    }
    return self;
}

- (void)initElementWithPlanNums: (NSUInteger)planNums {
    
    // 设置背景颜色
    self.backgroundColor = [XAppContext appColors].backgroundColor;
    
    // 背景图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, ScreenWidth - 16, 760 + 44 * planNums)];
    backImageView.image = [UIImage imageNamed:@"sanBiao_background"];
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    _backView = backImageView;
    
    _height = backImageView.height;
    
    // 标相关的信息
    [self projectIntroductionWithSuperView:backImageView];
    
    // 回款状态信息
    [self payBackStatusWithSuperView:backImageView];

    // 回款计划及相关合同
    [self payBackPlanWithSuperView:backImageView planNums: planNums];
    
}

#pragma mark - private method
- (void)payBackPlanWithSuperView: (UIView *)backImageView planNums: (NSUInteger)planNums {
    
    // 回款计划
    UIImageView *lineIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue_line"]];
    [backImageView addSubview:lineIcon];
    
    UILabel *payPlanLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"回款计划" textColor:[XAppContext appColors].blackColor];
    [backImageView addSubview:payPlanLabel];
    
    // frame
    [payPlanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lineIcon.mas_trailing).offset(8);
        make.top.mas_equalTo(_predictMoneyLabel.mas_bottom).offset(355);
        make.height.mas_equalTo(44);
    }];
    
    [lineIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(6);
        make.size.mas_equalTo(CGSizeMake(3, 16));
        make.centerY.mas_equalTo(payPlanLabel.mas_centerY).offset(0);
    }];
    
    _payBackplans = [NSMutableArray array];
    for (int i = 0; i < planNums + 1; i++) {
        XFormView *formView = [[XFormView alloc] init];
        [backImageView addSubview:formView];
        
        formView.contentFont = [XAppContext appFonts].font_15;
        if (i == 0) {
            formView.contentColor = [XAppContext appColors].grayBlackColor;
            formView.content1 = @"期次";
            formView.content2 = @"预计还款时间";
            formView.content3 = @"应收利息（元）";
            formView.content4 = @"合计（元）";
        } else {
            [_payBackplans addObject:formView];
            formView.contentColor = [XAppContext appColors].orangeColor;
            formView.label2.font = [XAppContext appFonts].font_12;
            formView.label1.textColor = [XAppContext appColors].grayBlackColor;
            formView.label2.textColor = [XAppContext appColors].lightGrayColor;
            formView.content1 = [NSString stringWithFormat:@"%d", i];
        }
        
        [formView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(6);
            make.trailing.mas_equalTo(-6);
            make.height.mas_equalTo(44);
            make.top.mas_equalTo(payPlanLabel.mas_bottom).offset(44 * i);
        }];
    }
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [backImageView addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(6);
        make.trailing.mas_equalTo(-6);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(payPlanLabel.mas_bottom).offset(44 * (planNums + 1));
    }];
    
    // 相关合同
    UIImageView *lineIcon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue_line"]];
    [backImageView addSubview:lineIcon1];
    
    UILabel *contractLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"合同相关" textColor:[XAppContext appColors].blackColor];
    [backImageView addSubview:contractLabel];
    
    // frame
    [contractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lineIcon.mas_trailing).offset(8);
        make.top.mas_equalTo(bottomLine.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
    }];
    
    [lineIcon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(6);
        make.size.mas_equalTo(CGSizeMake(3, 16));
        make.centerY.mas_equalTo(contractLabel.mas_centerY).offset(0);
    }];
    
    UIButton *loanAgreementButton = [UIButton buttonWithTitle:@"《借款协议》" target:self action:@selector(gotoLoanAgreement:)];
    loanAgreementButton.titleLabel.font = [XAppContext appFonts].font_13;
    [loanAgreementButton setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    [backImageView addSubview:loanAgreementButton];
    _loanAgreementButton = loanAgreementButton;
    
    [loanAgreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contractLabel.mas_bottom).offset(0);
        make.leading.mas_equalTo(6);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
}

/* 回款状态信息 */
- (void)payBackStatusWithSuperView: (UIView *)backImageView {
    // 回款状态
    UIImageView *lineIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue_line"]];
    [backImageView addSubview:lineIcon];
    
    UILabel *payBackLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"回款状态" textColor:[XAppContext appColors].blackColor];
    [backImageView addSubview:payBackLabel];
    
    // frame
    [payBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lineIcon.mas_trailing).offset(8);
        make.top.mas_equalTo(_predictMoneyLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
    }];
    
    [lineIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(6);
        make.size.mas_equalTo(CGSizeMake(3, 16));
        make.centerY.mas_equalTo(payBackLabel.mas_centerY).offset(0);
    }];
    
    // 数组循环创建回款状态详细信息
    NSArray *titles = @[@"已回收", @"待收金额", @"待收本金", @"待收利息", @"已收违约金", @"已收收益"];
    _payBackContents = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        XLeftAndRightLabelView *statusView = [XLeftAndRightLabelView viewWithTitleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].orangeColor contentFont:[XAppContext appFonts].font_15 title:titles[i]];
        [_payBackContents addObject:statusView];
        [backImageView addSubview:statusView];
        
        if (i == 0) {
            statusView.contentColor = [XAppContext appColors].grayBlackColor;
        }
        if (i >= 4) {
            [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(0);
                make.top.mas_equalTo(payBackLabel.mas_bottom).offset(44 * i + 10);
                make.trailing.mas_equalTo(0);
                make.height.mas_equalTo(44);
            }];
        } else {
            [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(0);
                make.top.mas_equalTo(payBackLabel.mas_bottom).offset(44 * i);
                make.trailing.mas_equalTo(0);
                make.height.mas_equalTo(44);
            }];
        }
    }
}

/* 标相关的信息 */
- (void)projectIntroductionWithSuperView: (UIView *)backImageView {
    // 投资状态图表
    UIImageView *stateIconView = [[UIImageView alloc] init];
    _stateIconView = stateIconView;
    [stateIconView sizeToFit];
    [backImageView addSubview:stateIconView];
    
    // 项目名称
    UILabel *projectNameLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].blackColor];
    _projectNameLabel = projectNameLabel;
    projectNameLabel.preferredMaxLayoutWidth = ScreenWidth - 200;
    [backImageView addSubview:projectNameLabel];
    
    // 投资项目ID
    UILabel *projectIdLabel = [UILabel labelWithFont:[XAppContext appFonts].font_12 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _projectIdLabel = projectIdLabel;
    [backImageView addSubview:projectIdLabel];
    
    // 下划线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    [backImageView addSubview:lineView];
    
    // 投资资金
    UILabel *investAmountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _investAmountLabel = investAmountLabel;
    _investAmountLabel.numberOfLines = 0;
    _investAmountLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:investAmountLabel];
    
    // 到期日期
    UILabel *lastDateLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _lastDateLabel = lastDateLabel;
    _lastDateLabel.numberOfLines = 0;
    _lastDateLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:lastDateLabel];
    
    // 预计收益
    UILabel *predictMoneyLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _predictMoneyLabel = predictMoneyLabel;
    _predictMoneyLabel.numberOfLines = 0;
    _predictMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:predictMoneyLabel];
    
    // 已回款
    UILabel *repayMoneyLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _repayMoneyLabel = repayMoneyLabel;
    _repayMoneyLabel.numberOfLines = 0;
    _repayMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:repayMoneyLabel];
    
    // frame
    [stateIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
    }];
    
    [projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(39);
        make.width.lessThanOrEqualTo(@(ScreenWidth - 200));
    }];
    
    [projectIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(projectNameLabel.mas_trailing).offset(10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(39);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.trailing.mas_equalTo(-17);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(projectNameLabel.mas_bottom).offset(0);
    }];
    
    [investAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
    [lastDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(investAmountLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
    [predictMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.top.mas_equalTo(investAmountLabel.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
    [repayMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(predictMoneyLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(lastDateLabel.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark - gotoLoanAgreement
- (void)gotoLoanAgreement: (UIButton *)sender {
    if ([self.mySanBiaoDetailViewDelegate respondsToSelector:@selector(mySanBiaoDetailView:didClickOfLoanProtocol:)]) {
        [self.mySanBiaoDetailViewDelegate mySanBiaoDetailView:self didClickOfLoanProtocol:sender];
    }
}

#pragma mark - setter
- (void)setDetailModel:(XMySanBiaoDetailModel *)detailModel {
    _detailModel = detailModel;
    XLeftAndRightLabelView *view1 = _payBackContents[0];
    view1.content = [NSString stringWithFormat:@"%@期(共%@期)", detailModel.returnPeriod, detailModel.countPeriod];
    
    XLeftAndRightLabelView *view2 = _payBackContents[1];
    view2.content = detailModel.paymentAcount0 ? detailModel.paymentAcount0 : @"0.00";
    
    XLeftAndRightLabelView *view3 = _payBackContents[2];
    view3.content = detailModel.paymentPrincipal0 ? detailModel.paymentPrincipal0 : @"0.00";
    
    XLeftAndRightLabelView *view4 = _payBackContents[3];
    view4.content = detailModel.paymentInterest0 ? detailModel.paymentInterest0 : @"0.00";
    
    XLeftAndRightLabelView *view5 = _payBackContents[4];
    view5.content = @"0.00";
    
    XLeftAndRightLabelView *view6 = _payBackContents[5];
    view6.content = detailModel.endPaymentInterest0 ? detailModel.endPaymentInterest0 : @"0.00";
    
    for (int i = 0; i < detailModel.list.count; i++) {
        XMySanBiaoReturnPlanModel *planModel = detailModel.list[i];
        XFormView *formView = _payBackplans[i];
        formView.content2 = planModel.paymentTime0 ? planModel.paymentTime0 : @"- - -";
        formView.content3 = planModel.paymenterest0 ? planModel.paymenterest0 : @"0.00";
        formView.content4 = planModel.paymentTotalAmount0 ? planModel.paymentTotalAmount0 : @"0.00";
        if ([planModel.paymentStues integerValue] == 0) {
             formView.contentColor = [XAppContext appColors].redColor;
        }
    }
}

- (void)setSanBiaoModel:(XMySanBiaoModel *)sanBiaoModel {
    _sanBiaoModel = sanBiaoModel;
    
    _projectNameLabel.text = sanBiaoModel.projectName;
    _projectIdLabel.text = [NSString stringWithFormat:@"ID %@", sanBiaoModel.markNumber];
    
    [self label:_investAmountLabel withTitle:@"投资资金" content:(sanBiaoModel.investAmount0 ? sanBiaoModel.investAmount0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    [self label:_predictMoneyLabel withTitle:@"预期收益" content:(sanBiaoModel.predictMoney0 ? sanBiaoModel.predictMoney0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    [self label:_lastDateLabel withTitle:@"到期日期" content:(sanBiaoModel.lastDate0 ? sanBiaoModel.lastDate0 : @"- - -") contentFont:[XAppContext appFonts].font_15 contentColor: [XAppContext appColors].lightGrayColor];
    [self label:_repayMoneyLabel withTitle:@"已回款" content:(sanBiaoModel.repayMoney0 ? sanBiaoModel.repayMoney0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    _investAmountLabel.textAlignment = NSTextAlignmentLeft;
    _predictMoneyLabel.textAlignment = NSTextAlignmentLeft;
    _lastDateLabel.textAlignment = NSTextAlignmentLeft;
    _repayMoneyLabel.textAlignment = NSTextAlignmentLeft;
    // 投资状态 (1-投资中，2-回款中，3-已结束, -1表示全部)
    switch ([sanBiaoModel.investStatus integerValue]) {
        case 1:
            _stateIconView.image = [UIImage imageNamed:@"mine_invest"];
            break;
        case 2:
            _stateIconView.image = [UIImage imageNamed:@"mine_payBack"];
            break;
        case 3:
            _stateIconView.image = [UIImage imageNamed:@"mine_end"];
            break;
    }
}

@end
