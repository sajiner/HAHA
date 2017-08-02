//
//  XSanBiaoInvestFormView.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/24.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoInvestFormView.h"

static const CGFloat labelHeight = 40;
static const CGFloat labelLeftMargin = 15;

@interface XSanBiaoInvestFormView()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton *gotoChargeBtn;
@property (nonatomic,strong)UIButton *agreeChargeBtn;
@end

@implementation XSanBiaoInvestFormView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initElement];
    }
    return self;
}

#pragma mark - private method

- (void)agreeChargeBtnClick:(UIButton *)sender{
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"tick_normal"]]) {
        [_agreeChargeBtn setImage:[UIImage imageNamed:@"tick_selected"] forState:UIControlStateNormal];
    }else{
        [_agreeChargeBtn setImage:[UIImage imageNamed:@"tick_normal"] forState:UIControlStateNormal];
    }
}

- (void)gotoChargeBtnClick:(UIButton *)sender{

    if (_delegate && [_delegate respondsToSelector:@selector(gotoCharge)]) {
        [_delegate gotoCharge];
    }
}

- (void)riskDisBtnClick:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(riskDisBtnC)]) {
        [_delegate riskDisBtnC];
    }
}

- (void)loanAgreeBtnClick:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(loanAgreeBtnC)]) {
        [_delegate loanAgreeBtnC];
    }
}

- (void)nextStep{
    NSLog(@"nextStep");
    [self endEditing:YES];

    if ([self.agreeChargeBtn.currentImage isEqual:[UIImage imageNamed:@"tick_normal"]]) {
        CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"请同意借款协议" delegate:nil cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
        [customAlert show];
        return;
    }
    
    if ([self.investAmountTextfield.text isEqualToString:@""]) {
        CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入投资金额" delegate:nil cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
        [customAlert show];
        return;
    }
    if([self.investAmountTextfield.text doubleValue] == 0 ||[self.investAmountTextfield.text isEqualToString:@"."]) {
        CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入合法投资金额" delegate:nil cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
        [customAlert show];
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(sanbiaoNextStep)]) {
        [_delegate sanbiaoNextStep];
    }
    
}

- (void)initElement{

    CGFloat leftLabelWidth = ScreenWidth/3;
    CGFloat rightLabelWidth = 2* leftLabelWidth-labelLeftMargin;
    
    self.IDL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"个人信用贷款" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelLeftMargin, 0, leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.IDL];
    self.IDLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(leftLabelWidth+labelLeftMargin, 0,rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.IDLabel];
    
    UILabel *surplusCastL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"剩余可投（元）" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(self.IDL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:surplusCastL];
    self.surplusCastLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"0.0" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(leftLabelWidth+labelLeftMargin,  CGRectGetMaxY(self.IDLabel.frame),rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.surplusCastLabel];
    
    
    UILabel *investAmountL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"投资金额（元）" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(surplusCastL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:investAmountL];
    self.investAmountTextfield =  [[UITextField alloc] initWithFrame:CGRectMake(leftLabelWidth+labelLeftMargin,  CGRectGetMaxY(self.surplusCastLabel.frame),rightLabelWidth, labelHeight) ];
    self.investAmountTextfield.textAlignment = NSTextAlignmentLeft;
    self.investAmountTextfield.delegate = self;
    self.investAmountTextfield.placeholder = [NSString stringWithFormat:@"可用余额%@元",[UserManager User].balance];
    self.investAmountTextfield.keyboardType = UIKeyboardTypeDecimalPad;
    self.investAmountTextfield.font = [XAppContext appFonts].font_14;
    [self addSubview:self.investAmountTextfield];
    
    [self addSubview:self.gotoChargeBtn];
    self.gotoChargeBtn.frame = CGRectMake(ScreenWidth - 100, CGRectGetMinY(self.investAmountTextfield.frame), 100, 40);
    
    
    UILabel *investTermL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"投资期限" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(investAmountL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:investTermL];
    self.investTermLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftLabelWidth+labelLeftMargin,  CGRectGetMaxY(self.investAmountTextfield.frame),rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"24个月"];
    [attrString addAttribute:NSForegroundColorAttributeName  value:[XAppContext appColors].orangeColor range:NSMakeRange(0, 2)];
    self.investTermLabel.attributedText = attrString;
    [self addSubview:self.investTermLabel];
    
    UILabel *pastAnnuaYieldL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"过往年化收益率" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(investTermL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:pastAnnuaYieldL];
    self.pastAnnuaYieldLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"0.0%" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(leftLabelWidth+labelLeftMargin,  CGRectGetMaxY(self.investTermLabel.frame),rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.pastAnnuaYieldLabel];
    
    UILabel *expectedL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"预计收益（元）" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(pastAnnuaYieldL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:expectedL];
    self.expectedLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"0.00" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(leftLabelWidth+labelLeftMargin,  CGRectGetMaxY(self.pastAnnuaYieldLabel.frame),rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.expectedLabel];
    
    
    [self addSubview:self.agreeChargeBtn];
    self.agreeChargeBtn.frame = CGRectMake(25, CGRectGetMaxY(self.expectedLabel.frame)+15, ScreenWidth - 2*leftLabelWidth, 20);
    [self.agreeChargeBtn sizeToFit];
    
    UIButton *loanAgreeBtn = [UIButton buttonWithTitle:@"《借款协议》" target:self action:@selector(loanAgreeBtnClick:)];
    loanAgreeBtn.titleLabel.font = [XAppContext appFonts].font_14;
    loanAgreeBtn.frame = CGRectMake(CGRectGetMaxX(self.agreeChargeBtn.frame), CGRectGetMinY(self.agreeChargeBtn.frame)-5, 100, 20);
    [loanAgreeBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    [loanAgreeBtn sizeToFit];
    [self addSubview:loanAgreeBtn];
    
    UIButton *riskDisBtn = [UIButton buttonWithTitle:@"《风险揭示书》" target:self action:@selector(riskDisBtnClick:)];
    riskDisBtn.titleLabel.font = [XAppContext appFonts].font_14;
    riskDisBtn.frame = CGRectMake(CGRectGetMaxX(loanAgreeBtn.frame), CGRectGetMinY(self.agreeChargeBtn.frame)-5, 100, 20);
    [riskDisBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    [riskDisBtn sizeToFit];
    [self addSubview:riskDisBtn];
    
    //下一步
    UIButton *nextStepBtn = [UIButton buttonWithTitle:@"下一步" target:self action:@selector(nextStep)];
    nextStepBtn.frame = CGRectMake(labelLeftMargin, CGRectGetMaxY(self.agreeChargeBtn.frame)+20, ScreenWidth - 2*labelLeftMargin, 40);
    nextStepBtn.backgroundColor = [XAppContext appColors].blueColor;
    nextStepBtn.layer.masksToBounds = YES;
    nextStepBtn.layer.cornerRadius = 5;
    [nextStepBtn setTitleColor:[XAppContext appColors].whiteColor forState:UIControlStateNormal];
    [self addSubview:nextStepBtn];
    
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 200 - 13)/2, CGRectGetMaxY(nextStepBtn.frame)+10, 13, 16)];
    iconImageView.image = [UIImage imageNamed:@"bank_certify"];
    [self addSubview:iconImageView];
    
    UILabel *customeAlterStr = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"客户资金由恒丰银行专业存管" textColor:[XAppContext appColors].lightGrayColor];
    customeAlterStr.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame), CGRectGetMinY(iconImageView.frame), 200, 16);
    [self addSubview:customeAlterStr];
    
    //添加
    UIImageView *tipImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips_background"]];
    tipImageV.frame = CGRectMake(labelLeftMargin, CGRectGetMaxY(iconImageView.frame)+40, ScreenWidth - 2*labelLeftMargin, 80);
    
    UIImageView *faceImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips_icon"]];
    faceImageV.frame = CGRectMake(labelLeftMargin, 5, 15, 15);
    [tipImageV addSubview:faceImageV];
    
    UILabel *tipLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"温馨提示" textColor:[XAppContext appColors].blackColor];
    tipLabel.frame = CGRectMake(CGRectGetMaxX(faceImageV.frame), CGRectGetMinY(faceImageV.frame), 200, 15);
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [tipImageV addSubview:tipLabel];
    
    UILabel *tipLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelLeftMargin, CGRectGetMaxY(tipLabel.frame)+5, CGRectGetWidth(tipImageV.frame)- 2*labelLeftMargin, 0.5)];;
    tipLineLabel.backgroundColor = [XAppContext appColors].lineColor;
    [tipImageV addSubview:tipLineLabel];
    
    UILabel *wordLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"1、投资有风险，选择需谨慎！" textColor:[XAppContext appColors].blackColor];
    wordLabel.frame = CGRectMake(CGRectGetMinX(faceImageV.frame), CGRectGetMaxY(tipLineLabel.frame)+10, ScreenWidth, 20);
    wordLabel.textAlignment = NSTextAlignmentLeft;
    [tipImageV addSubview:wordLabel];
    
    [self addSubview:tipImageV];
    
    //画线
    [self addSubview:[self labelWithX:0 Y:0]];
    [self addSubview:[self labelWithX:labelLeftMargin Y:CGRectGetMaxY(self.IDL.frame)]];
    [self addSubview:[self labelWithX:labelLeftMargin Y:CGRectGetMaxY(surplusCastL.frame)]];
    
    [self addSubview:[self labelWithX:labelLeftMargin Y:CGRectGetMaxY(investAmountL.frame)]];
    [self addSubview:[self labelWithX:labelLeftMargin Y:CGRectGetMaxY(investTermL.frame)]];
    [self addSubview:[self labelWithX:labelLeftMargin Y:CGRectGetMaxY(pastAnnuaYieldL.frame)]];
    [self addSubview:[self labelWithX:0 Y:CGRectGetMaxY(expectedL.frame)]];
}
#pragma mark - privateMethod
- (UILabel *)labelWithX:(CGFloat)x Y:(CGFloat)y{
    CGFloat width = x == 0?self.frame.size.width:self.frame.size.width - labelLeftMargin;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, 1)];
    label.backgroundColor = [XAppContext appColors].lineColor;
    return label;
}

#pragma mark - textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
    if ([self.investAmountTextfield.text isEqualToString:@""]||[self.investAmountTextfield.text isEqualToString:@"."] || [self.investAmountTextfield.text doubleValue] == 0){
        if (_delegate && [_delegate respondsToSelector:@selector(computeIncome:)]) {
            [_delegate computeIncome:0];
        }
    }
    else{
        if (_delegate && [_delegate respondsToSelector:@selector(computeIncome:)]) {
            [_delegate computeIncome:[self.investAmountTextfield.text doubleValue]];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *amountText = self.investAmountTextfield.text;
    NSString *regStr = @"^([1-9][\\d]{0,100}|0)(\\.[\\d]{0,1})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regStr];
    BOOL match = [predicate evaluateWithObject:amountText];
    if ([string isEqualToString:@""]) return YES;  // 始终允许用户删除
    NSString *tmpStr = [amountText stringByAppendingString:string];
    NSString *numStr = [[tmpStr componentsSeparatedByString:@"."] firstObject];
    NSInteger amount = [numStr integerValue];
    if (([amountText integerValue] == [self.surplusCastLabel.text doubleValue]) && (![string isEqualToString:@""])) return NO;
    BOOL result = [amountText isEqualToString:@""] ? YES : (match && ((amount <= [self.surplusCastLabel.text doubleValue]) || [string isEqualToString:@"."]));
    return result;
}


#pragma mark - lazy
- (UIButton *)gotoChargeBtn{
    if (!_gotoChargeBtn) {
        _gotoChargeBtn = [UIButton buttonWithTitle:@"去充值" target:self action:@selector(gotoChargeBtnClick:)];
        [_gotoChargeBtn setTitleColor: [XAppContext appColors].blueColor forState:UIControlStateNormal];
        _gotoChargeBtn.titleLabel.font = [XAppContext appFonts].font_14;
        [_gotoChargeBtn setImage:[UIImage imageNamed:@"sanbiaoNextstep"] forState:UIControlStateNormal];
        
        _gotoChargeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, -50);
        _gotoChargeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        //        {top, left, bottom, right};

    }
    return _gotoChargeBtn;
}

- (UIButton *)agreeChargeBtn{
    if (!_agreeChargeBtn) {
        _agreeChargeBtn = [UIButton buttonWithTitle:@"同意" target:self action:@selector(agreeChargeBtnClick:)];
        [_agreeChargeBtn setTitleColor:[XAppContext appColors].blackColor forState:UIControlStateNormal];
        _agreeChargeBtn.titleLabel.font = [XAppContext appFonts].font_14;
        [_agreeChargeBtn setImage:[UIImage imageNamed:@"tick_selected"] forState:UIControlStateNormal];
    }
    return  _agreeChargeBtn;
}


@end



@implementation XSanBiaoInvestFormPopView{
    //投资金额
    UILabel *_investAmountLabel;
    //投资期限
    UILabel *_investTermLabel;
    //过往年化收益率
    UILabel *_pastAnnuaYieldLabel;
    //预计收益
    UILabel *_expectedLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initElements];
    }
    return self;
}

- (void)initElements{
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [XAppContext appColors].blackColor;
    bgView.alpha = 0.3;
    [self addSubview:bgView];
    CGFloat leftLabelWidth = ScreenWidth/3;
    
    UIView *blueBgView = [[UIView alloc] initWithFrame:CGRectMake(labelLeftMargin, 200, ScreenWidth- 2*labelLeftMargin, 250)];
    blueBgView.backgroundColor = [XAppContext appColors].blueColor;
    blueBgView.layer.masksToBounds = YES;
    blueBgView.layer.cornerRadius = 5;
    
    UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth- 2*labelLeftMargin, 200)];
    whiteBgView.backgroundColor = [XAppContext appColors].whiteColor;
    whiteBgView.layer.masksToBounds = YES;
    whiteBgView.layer.cornerRadius = 5;
    
    UILabel *confirmInfoLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"请确认您的购买信息" textColor:[XAppContext appColors].blueColor frame:CGRectMake(labelLeftMargin+5, 0, 200, labelHeight) textAlignment:NSTextAlignmentLeft];
    [whiteBgView addSubview:confirmInfoLabel];
    UIButton *cancelBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetWidth(whiteBgView.frame)- labelLeftMargin - labelHeight, CGRectGetMinY(confirmInfoLabel.frame), labelHeight, labelHeight) title:@"" titleColor:[XAppContext appColors].lightGrayColor titleFont:[XAppContext appFonts].font_17 image:[UIImage imageNamed:@"icon_close"]];
    [cancelBtn addTarget:self action:@selector(hidePOPView) forControlEvents:UIControlEventTouchUpInside];
    [whiteBgView addSubview:cancelBtn];
    
    UILabel *confirmLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(confirmInfoLabel.frame), CGRectGetMaxY(confirmInfoLabel.frame), CGRectGetWidth(whiteBgView.frame) -  2* (labelLeftMargin + 5), 1)];
    confirmLineLabel.backgroundColor = [XAppContext appColors].lineColor;
    [whiteBgView addSubview:confirmLineLabel];
    
    //投资金额
    UILabel *investAmountL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"投资金额" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(CGRectGetMinX(confirmInfoLabel.frame), CGRectGetMaxY(confirmLineLabel.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [whiteBgView addSubview:investAmountL];
    
    _investAmountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blueColor frame:CGRectMake(CGRectGetMaxX(investAmountL.frame), CGRectGetMinY(investAmountL.frame), CGRectGetWidth(whiteBgView.frame) - 2*labelLeftMargin- leftLabelWidth - 10, labelHeight) textAlignment:NSTextAlignmentRight];
    [whiteBgView addSubview:_investAmountLabel];
    

    //投资期限
    UILabel *investTermL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"投资期限" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(CGRectGetMinX(confirmInfoLabel.frame), CGRectGetMaxY(investAmountL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [whiteBgView addSubview:investTermL];
    
    _investTermLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blueColor frame:CGRectMake(CGRectGetMaxX(investAmountL.frame), CGRectGetMinY(investTermL.frame), CGRectGetWidth(whiteBgView.frame) - 2*labelLeftMargin- leftLabelWidth- 10, labelHeight) textAlignment:NSTextAlignmentRight];
    [whiteBgView addSubview:_investTermLabel];

    //过往年化收益率
    UILabel *pastAnnuaYieldL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"过往年化收益率" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(CGRectGetMinX(confirmInfoLabel.frame), CGRectGetMaxY(investTermL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [whiteBgView addSubview:pastAnnuaYieldL];
    
    _pastAnnuaYieldLabel = [UILabel labelWithFont:[XAppContext appFonts].font_18 text:@"" textColor:[XAppContext appColors].blueColor frame:CGRectMake(CGRectGetMaxX(investAmountL.frame), CGRectGetMinY(pastAnnuaYieldL.frame), CGRectGetWidth(whiteBgView.frame) - 2*labelLeftMargin- leftLabelWidth- 10, labelHeight) textAlignment:NSTextAlignmentRight];
    [whiteBgView addSubview:_pastAnnuaYieldLabel];
    
    //预计收益
    UILabel *expectedL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"预计收益" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(CGRectGetMinX(confirmInfoLabel.frame), CGRectGetMaxY(pastAnnuaYieldL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [whiteBgView addSubview:expectedL];
    
    _expectedLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blueColor frame:CGRectMake(CGRectGetMaxX(investAmountL.frame), CGRectGetMinY(expectedL.frame), CGRectGetWidth(whiteBgView.frame) - 2*labelLeftMargin- leftLabelWidth- 10, labelHeight) textAlignment:NSTextAlignmentRight];
    [whiteBgView addSubview:_expectedLabel];
    [blueBgView addSubview:whiteBgView];
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认投资" target:self action:@selector(confirm:)];
    confirmBtn.frame = CGRectMake(0, CGRectGetMaxY(whiteBgView.frame), blueBgView.frame.size.width, 40);
    [blueBgView addSubview:confirmBtn];
    [self addSubview:blueBgView];
    
}

- (void)confirm:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(popViewConfirmBtn)]) {
        [_delegate popViewConfirmBtn];
    }
}

- (void)hidePOPView{
    if (_delegate && [_delegate respondsToSelector:@selector(hidePOPView)]) {
        [_delegate hidePOPView];
    }
}

- (void)setInvest:(NSString *)money investTerm:(NSString *)term profit:(NSString *)profit expect:(NSString *)expect{
    _investAmountLabel.text = [NSString stringWithFormat:@"%.2f元",[money doubleValue]];
    _investTermLabel.text = term;
    _pastAnnuaYieldLabel.text =profit;
    _expectedLabel.text =[expect stringByAppendingString:@"元"];
}

@end

@implementation XSanBiaoInvestSucceedView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [XAppContext appColors].whiteColor;
        [self initElements];
    }
    return self;
}

- (void)initElements{
    UIImageView *succeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 110)/2, 50, 218/2, 218/2)];
    succeImageView.image = [UIImage imageNamed:@"success"];
    [self addSubview:succeImageView];
    
    UILabel *congratulationLabel = [UILabel labelWithFont:[XAppContext appFonts].font_25 text:@"恭喜您，交易成功！" textColor:[XAppContext appColors].blackColor frame:CGRectMake(0, CGRectGetMaxY(succeImageView.frame)+ 15, ScreenWidth, 30) textAlignment:NSTextAlignmentCenter];
    [self addSubview:congratulationLabel];
    
    CGFloat leftLabelWidth = ScreenWidth/3;
    CGFloat rightLabelWidth = 2* leftLabelWidth-2*labelLeftMargin;
    
    self.IDL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(congratulationLabel.frame)+15, leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.IDL];
    self.IDLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(leftLabelWidth+labelLeftMargin, CGRectGetMinY(self.IDL.frame),rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.IDLabel];
    
    UILabel *investMoneyL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"投资金额（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(self.IDL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:investMoneyL];
    self.investMoneyLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(leftLabelWidth+labelLeftMargin, CGRectGetMinY(investMoneyL.frame),rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.investMoneyLabel];
    
    UILabel *profitL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"过往收益（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelLeftMargin, CGRectGetMaxY(investMoneyL.frame), leftLabelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:profitL];
    self.profitLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(leftLabelWidth+labelLeftMargin, CGRectGetMinY(profitL.frame),rightLabelWidth, labelHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.profitLabel];
    
    [self addSubview:[self lineLabelWithX:0 Y:CGRectGetMaxY(self.IDL.frame)]];
    [self addSubview:[self lineLabelWithX:labelLeftMargin Y:CGRectGetMaxY(investMoneyL.frame)]];
    [self addSubview:[self lineLabelWithX:0 Y:CGRectGetMaxY(profitL.frame)]];
    
    
    UIButton *continueBtn = [UIButton buttonWithTitle:@"继续投资" target:self action:@selector(continueBtnClick)];
    continueBtn.frame = CGRectMake(labelLeftMargin, CGRectGetMaxY(self.profitLabel.frame)+70, ScreenWidth - 2*labelLeftMargin, labelHeight);
    continueBtn.backgroundColor = [XAppContext appColors].blueColor;
    [continueBtn setTitleColor:[XAppContext appColors].whiteColor forState:UIControlStateNormal];
    continueBtn.layer.masksToBounds = YES;
    continueBtn.layer.cornerRadius = 5;
    [self addSubview:continueBtn];
    
    UIButton *lookForBtn = [UIButton buttonWithTitle:@"查看我的投资" target:self action:@selector(lookForBtnClick)];
    lookForBtn.frame = CGRectMake(labelLeftMargin, CGRectGetMaxY(continueBtn.frame)+20, ScreenWidth - 2*labelLeftMargin, labelHeight);
    lookForBtn.backgroundColor = [XAppContext appColors].whiteColor;
    lookForBtn.layer.borderColor = [XAppContext appColors].blueColor.CGColor;
    lookForBtn.layer.borderWidth = 0.5;
    lookForBtn.layer.masksToBounds = YES;
    lookForBtn.layer.cornerRadius = 5;
    [lookForBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    [self addSubview:lookForBtn];
    
}

- (UILabel *)lineLabelWithX:(CGFloat)x Y:(CGFloat)y{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, ScreenWidth-x, 1)];
    label.backgroundColor =  [XAppContext appColors].lineColor;
    return label;
}

#pragma mark - button click method
- (void)continueBtnClick{
    if (_delegate && [_delegate respondsToSelector:@selector(continueInvest)]) {
        [_delegate continueInvest];
    }
}

- (void)lookForBtnClick{
    if (_delegate && [_delegate respondsToSelector:@selector(lookForMyInvest)]) {
        [_delegate lookForMyInvest];
    }
}
@end


