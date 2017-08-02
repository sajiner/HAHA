//
//  XSanBiaoDetailScrollview.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoDetailScrollview.h"
#import "NSNumber+XDecimalString.h"

static const  CGFloat leftMargin = 15;
static const  CGFloat labelHeight = 40;
static const  CGFloat labelWidth = 100;

@interface XSanBiaoDetailScrollview()<XSanBiaoDetailBottomButtonViewDelegate>
@end

@implementation XSanBiaoDetailScrollview

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(ScreenWidth, 1600 + 180+80);//60 button的高度
        [self initElements];
    }
    return self;
}

- (void)initElements{
    //顶部视图
    [self addSubview:self.topView];
    
    //中间视图
    UIView *centerBgView =[self centerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, 340)];
    [self addSubview:centerBgView];
    
    //底部视图
    [self addSubview:self.bottomView];
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(centerBgView.frame) , ScreenWidth, 1180+80);
}
#pragma mark - XSanBiaoDetailBottomButtonViewDelegate
- (void)changeHeightWtihBottom:(CGFloat)bottom{
    self.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.topView.frame)+260 + bottom + 180);
    [self setNeedsDisplay];
}


#pragma mark - private method

- (UIView *)centerViewWithFrame:(CGRect)frame{
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [XAppContext appColors].backgroundColor;
    
    self.personLoanL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, 0, labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:self.personLoanL];
    self.personLoanIDLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(CGRectGetMaxX(self.personLoanL.frame), 0, ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:self.personLoanIDLabel];
    
    
    //centerView
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.personLoanIDLabel.frame)+10, ScreenWidth, 120)];
    centerView.backgroundColor = [XAppContext appColors].whiteColor;
    
    UILabel *loanMoney = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"借款金额（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, 0, labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:loanMoney];
    self.loanAmountLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(loanMoney.frame), ScreenWidth-labelWidth - 2*leftMargin,labelHeight) textAlignment:NSTextAlignmentRight];
    [centerView addSubview:self.loanAmountLabel];
    
    
    UILabel *resetCast = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"剩余可投（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, CGRectGetMaxY(loanMoney.frame), labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:resetCast];
    self.restCastLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14  text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(resetCast.frame), ScreenWidth-labelWidth - 2*leftMargin, centerView.height/3) textAlignment:NSTextAlignmentRight];
    [centerView addSubview:self.restCastLabel];
    
    UILabel *joinLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"加入条件" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, CGRectGetMaxY(resetCast.frame), labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:joinLabel];
    
    UILabel * joinConditionLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(joinLabel.frame), ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentRight];
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:@"100.00元起投，整数倍增加"];
    [mutableStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(0, 5)];
    joinConditionLabel.attributedText = mutableStr;
    [centerView addSubview:joinConditionLabel];
    
    [centerView addSubview:[self lineLabelWithX:0 Y:0]];
    [centerView addSubview:[self lineLabelWithX:leftMargin Y:loanMoney.y]];
    [centerView addSubview:[self lineLabelWithX:leftMargin Y:resetCast.y]];
    [centerView addSubview:[self lineLabelWithX:leftMargin Y:joinLabel.y]];
    [centerView addSubview:[self lineLabelWithX:0 Y:CGRectGetMaxY(joinLabel.frame)]];
    [bgView addSubview:centerView];
    
    //bottom
    UIView *bottomView  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(centerView.frame)+10, ScreenWidth, 80)];
    bottomView.backgroundColor = [XAppContext appColors].whiteColor;

    UILabel *paymetnConditionL = [UILabel labelWithFont:[XAppContext appFonts].font_14  text:@"还款方式" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, 0, labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:paymetnConditionL];
    UILabel *principalLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14  text:@"等额本息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(paymetnConditionL.frame), ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentRight];
    [bottomView addSubview:principalLabel];
    
    UILabel *guarwayLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"保障方式" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, CGRectGetMaxY(principalLabel.frame), labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:guarwayLabel];
    UILabel *wayLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"风险备付金" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(guarwayLabel.frame), ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentRight];
    [bottomView addSubview:wayLabel];
    
    [bottomView addSubview:[self lineLabelWithX:0 Y:0]];
    [bottomView addSubview:[self lineLabelWithX:leftMargin Y:40]];
    [bottomView addSubview:[self lineLabelWithX:0 Y:80]];
    [bgView addSubview:bottomView];

    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 200 - 13)/2, CGRectGetMaxY(bottomView.frame)+10, 13, 16)];
    iconImageView.image = [UIImage imageNamed:@"bank_certify"];
    [bgView addSubview:iconImageView];
    
    UILabel *customeAlterStr = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"客户资金由恒丰银行专业存管" textColor:[XAppContext appColors].blackColor];
    customeAlterStr.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame), CGRectGetMinY(iconImageView.frame), 200, 16);
    [bgView addSubview:customeAlterStr];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,  CGRectGetMaxY(customeAlterStr.frame)+10+8, ScreenWidth - 60, 0.5)];
    lineLabel.backgroundColor = [XAppContext appColors].lightGrayColor;
    [bgView addSubview:lineLabel];
    UILabel *loadMore = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@" 滑动查看更多 " textColor:[XAppContext appColors].blackColor];
    loadMore.frame = CGRectMake((ScreenWidth- 100)/2, CGRectGetMaxY(customeAlterStr.frame)+10, 100, 16);
    loadMore.textColor = [XAppContext appColors].blueColor;
    loadMore.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [bgView addSubview:loadMore];
    
    self.arrowImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_up"]];
    self.arrowImgV.frame =CGRectMake((ScreenWidth - 12)/2, CGRectGetMaxY(loadMore.frame)+5,12, 7.5);
    [bgView addSubview:self.arrowImgV];

    return bgView;
}

- (UILabel *)lineLabelWithX:(CGFloat)x Y:(CGFloat)y{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, ScreenWidth-x, 1)];
    label.backgroundColor =  [XAppContext appColors].lineColor;
    return label;
}

#pragma mark - set method 
- (void)setDetailModel:(XSanBiaoDetailModel *)detailModel{
    _detailModel = detailModel;
    //赋值
    CGFloat rate =  _detailModel.p_project_money == 0? 0 : (double)_detailModel.p_rated_money/(double)_detailModel.p_project_money;
    self.topView.progressValue = rate;
    self.topView.text = [NSString stringWithFormat:@"%ld",(long)_detailModel.p_project_deadline];
    self.topView.percent = [NSString stringWithFormat:@"%.2f",_detailModel.p_project_rate];
    
    CGSize size = [_detailModel.p_project_name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(ScreenWidth-200, 30) lineBreakMode:NSLineBreakByTruncatingTail];
    self.personLoanL.frame = CGRectMake(leftMargin, 0, size.width, 40);
    self.personLoanL.text = _detailModel.p_project_name;
    
    self.personLoanIDLabel.frame =CGRectMake(CGRectGetMaxX(self.personLoanL.frame), 0, ScreenWidth-labelWidth - 2*leftMargin, labelHeight);
    self.personLoanIDLabel.text = [NSString stringWithFormat:@"ID  %@",_detailModel.m_number];
    self.loanAmountLabel.text = [NSString stringWithFormat:@"%.2f",_detailModel.p_project_money];
    self.restCastLabel.text = [NSString stringWithFormat:@"%@元",[[NSNumber numberWithFloat:_detailModel.p_rating_money] decimalString]];
    
}
- (void)setPersonModel:(XSanBiaoDetailPersonModel *)personModel{
    _personModel = personModel;
    self.bottomView.projectView.borrowReasonLabel.text = [_personModel.m_borrow_type isEqualToString:@"1"]?@"信用贷":@"车贷";    
    self.bottomView.projectView.loanAmountLabel.text = [NSString stringWithFormat:@"%.2f元",_personModel.d_give_money];//d_give_money
    
    NSMutableAttributedString *deadLineStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@个月",_personModel.d_debt_period]];
    [deadLineStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(0, deadLineStr.length-2)];
    self.bottomView.projectView.deadLineLabel.attributedText = deadLineStr;
    
    self.bottomView.projectView.creditLevelLabel.text = _personModel.d_rate_result;
    
    self.bottomView.projectView.paymentWayLabel.text = _personModel.m_way == 1?@"等额本息":@"";
    self.bottomView.projectView.nameLabel.text = [_personModel.d_debtors_name stringByReplacingCharactersInRange:NSMakeRange(1, _personModel.d_debtors_name.length -1) withString:@ "**"];
    self.bottomView.projectView.sexLabel.text = _personModel.p_sex;
    self.bottomView.projectView.ageLabel.text = [NSString stringWithFormat:@"%ld",(long)_personModel.age];
    self.bottomView.projectView.educationLabel.text = _personModel.p_education;
    self.bottomView.projectView.marriedLabel.text = _personModel.p_marriage_case;
    self.bottomView.projectView.livePlaceLabel.text = _personModel.p_live_address;
    
    self.bottomView.projectView.IDCardLabel.text =
    self.bottomView.projectView.bankInfoLabel.text =
    self.bottomView.projectView.creditReportLabel.text =
    self.bottomView.projectView.contactsLabel.text =
    self.bottomView.projectView.inCommonCertificationLabel.text =
    self.bottomView.projectView.houseCertificationLabel.text =
    self.bottomView.projectView.carCertificationLabel.text= @"已验证";
}

#pragma mark - lazy
- (XSanBiaoDetailTopView *)topView{
    if (!_topView) {
        _topView = [[XSanBiaoDetailTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,200)];
        _topView.progressTrackColor = [XAppContext appColors].lightBlueColor;
        _topView.progressColor = [XAppContext appColors].blueColor;
        _topView.progressStrokeWidth = 10;
        _topView.progressValue = 0.0;
        _topView.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return _topView;
}


- (XSanBiaoDetailBottomButtonView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[XSanBiaoDetailBottomButtonView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
    
}


@end
