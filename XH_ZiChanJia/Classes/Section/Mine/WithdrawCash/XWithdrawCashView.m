//
//  XWithdrawCashView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XWithdrawCashView.h"
#import "UIView+XExtension.h"

@implementation XWithdrawCashView {
    UILabel *_withdrawAfterNumLabel;   // 提现后余额
    UIButton *_bankButton;
    UILabel *_balanceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initElement];
    }
    return self;
}

- (void)initElement {
    // 当前可用余额
    UILabel *balanceLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"当前可用余额（元）" textColor:[XAppContext appColors].grayBlackColor];
    balanceLabel.frame = CGRectMake(0, 0, ScreenWidth, 80);
    balanceLabel.numberOfLines = 0;
    [self addSubview:balanceLabel];
    _balanceLabel = balanceLabel;
    
    // 银行卡
    UIButton *bankButton = [UIButton buttonWithFrame:CGRectMake(0, balanceLabel.bottom + 5, ScreenWidth, 86) title:@"" titleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_25 image:nil];
    bankButton.backgroundColor = [XAppContext appColors].backgroundColor;
    bankButton.imageEdgeInsets = UIEdgeInsetsMake(0, - 25, 0, 0);
    bankButton.userInteractionEnabled = NO;
    [self addSubview:bankButton];
    _bankButton = bankButton;
    
    // 线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, bankButton.bottom + 12, ScreenWidth, 1)];
    line1.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, bankButton.bottom + 57, ScreenWidth, 1)];
    line2.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:line2];
    
    // 提现金额
    UILabel *titleLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"提现金额（元）" textColor:[XAppContext appColors].grayBlackColor];
    titleLabel.frame = CGRectMake(15, line1.bottom, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    UITextField *withDrawMoneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.right + 15, line1.bottom, ScreenWidth - 95, 44)];
    withDrawMoneyTextField.placeholder = @"3.00 <= 提现金额 <= 可用余额";
    withDrawMoneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:withDrawMoneyTextField.placeholder];
    [strM addAttributes:@{
                         NSFontAttributeName: [XAppContext appFonts].font_12
                         }range:NSMakeRange(0, strM.length)];
    withDrawMoneyTextField.attributedPlaceholder = strM;
    [self addSubview:withDrawMoneyTextField];
    _withDrawMoneyTextField = withDrawMoneyTextField;
    
    // 提现后余额
    UILabel *withdrawAfterTitleLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"提现后余额（元）" textColor:[XAppContext appColors].grayBlackColor];
    withdrawAfterTitleLabel.frame = CGRectMake(15, line2.bottom, 110, 44);
    withdrawAfterTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:withdrawAfterTitleLabel];
    
    UILabel *withdrawAfterNumLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"0.00" textColor:[XAppContext appColors].grayBlackColor];
    withdrawAfterNumLabel.frame = CGRectMake(withdrawAfterTitleLabel.right, line2.bottom, ScreenWidth - withdrawAfterTitleLabel.right - 95, 44);
    [self addSubview:withdrawAfterNumLabel];
    _withdrawAfterNumLabel = withdrawAfterNumLabel;
    
    // 手续费
    UILabel *commissionLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"手续费2.00元" textColor:[XAppContext appColors].grayBlackColor];
    commissionLabel.frame = CGRectMake(ScreenWidth - 105, line2.bottom, 90, 44);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:commissionLabel.text];
    [attr addAttributes:@{
                         NSForegroundColorAttributeName: [XAppContext appColors].orangeColor
                         }range:NSMakeRange(commissionLabel.text.length - 5, 4)];
    commissionLabel.attributedText = attr;
    commissionLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:commissionLabel];
    
    // 下一步
    UIButton *goToppedUp = [UIButton buttonWithTitle:@"下一步" target:self action:@selector(next:)];
    goToppedUp.frame = CGRectMake(15, commissionLabel.bottom + 10, ScreenWidth - 30, 44);
    [goToppedUp setBackgroundImage:[UIImage imageNamed:@"mine_topped"] forState:UIControlStateNormal];
    [goToppedUp setTitleColor:[XAppContext appColors].whiteColor forState:UIControlStateNormal];
    goToppedUp.titleLabel.font = [XAppContext appFonts].font_18;
    [self addSubview:goToppedUp];
    
    // 客户资金由恒丰银行专业存管
    UIButton *cunGuanButton = [UIButton buttonWithFrame:CGRectMake(60, goToppedUp.bottom, ScreenWidth - 120, 44) title:@"客户资金由恒丰银行专业存管" titleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_13 image:[UIImage imageNamed:@"bank_certify"]];
    cunGuanButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    cunGuanButton.userInteractionEnabled = NO;
    [self addSubview:cunGuanButton];
}

#pragma mark - 下一步
- (void)next: (UIButton *)sender {
    if ([self.withdrawCashDelegate respondsToSelector:@selector(withdrawCashView:didClickOfButton:)]) {
        [self.withdrawCashDelegate withdrawCashView:self didClickOfButton:sender];
    }
}

#pragma mark - getter & setter
- (void)setDrawCashAfterAmount:(NSString *)drawCashAfterAmount {
    _drawCashAfterAmount = drawCashAfterAmount;
    _withdrawAfterNumLabel.text = drawCashAfterAmount;
}

- (void)setBankCardNum:(NSString *)bankCardNum {
    _bankCardNum = bankCardNum;
    NSMutableString *strM = [[NSMutableString alloc] initWithString:bankCardNum];
    [strM replaceCharactersInRange:NSMakeRange(4, strM.length - 8) withString:@"***********"];
    [_bankButton setTitle:strM forState:UIControlStateNormal];
}

- (void)setBalance:(NSString *)balance {
    _balance = balance;
    [self label:_balanceLabel withTitle:@"可用余额（元）" content:(balance ? balance : @"0.00") contentFont:[XAppContext appFonts].font_36 contentColor: [XAppContext appColors].orangeColor];
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    [_bankButton setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
}

@end
