//
//  XSanBiaoDetailBottomButtonView.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoDetailBottomButtonView.h"
#import "NSNumber+XDecimalString.h"

@interface XSanBiaoDetailBottomButtonView(){
    UILabel *_blueLine;
    UIView *_projectCourseView;
   UILabel *_graylabel;
}
@end

@implementation XSanBiaoDetailBottomButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initElements];
    }
    return self;
}


- (void)initElements{
    NSArray *titlesArr = @[@"项目信息",@"风控信息",@"投资列表",@"还款计划"];
    CGFloat buttonWidth  = ScreenWidth/4;
    
    for (NSInteger i=0; i<titlesArr.count; i++) {
        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(buttonWidth*i, 0, buttonWidth, XSanBiaoDetailLableHeight) title:titlesArr[i] titleColor:[XAppContext appColors].blackColor titleFont:[XAppContext appFonts].font_14 image:[UIImage imageNamed:@""]];
        if (i == 0) {
            [btn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [self addSubview:btn];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonWidth*i, 5, 1, 30)];
        [self addSubview:lineLabel];
    }
    UILabel *blueLineBg = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 1)];
    blueLineBg.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:blueLineBg];
    _blueLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, buttonWidth, 1)];
    _blueLine.backgroundColor = [XAppContext appColors].blueColor;
    [self addSubview:_blueLine];
    
    //添加内容
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_blueLine.frame), ScreenWidth, 980)];
    [self.showView addSubview:self.projectView];
    [self addSubview:self.showView];
 
    _projectCourseView = [self projectViewWithFrame:CGRectMake(0, CGRectGetMaxY(((UIView *)self.showView).frame)+30, ScreenWidth, 140)];
    [self addSubview:_projectCourseView];
    
    _graylabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_projectCourseView.frame), ScreenWidth, 100)];
    _graylabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self addSubview:_graylabel];
}

- (void)click:(UIButton *)sender{
    if (sender.tag - 1000 == _blueLine.frame.origin.x/ScreenWidth*4) {
        return;
    }
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag == sender.tag) {
                [((UIButton *)view) setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
                [UIView animateWithDuration:0.5 animations:^{
                    _blueLine.frame = CGRectMake((ScreenWidth/4)*(sender.tag -1000), 40, ScreenWidth/4, 1);
                }];
            }else{
                [((UIButton *)view) setTitleColor:[XAppContext appColors].blackColor forState:UIControlStateNormal];
            }
        }
    }
    
    for (UIView *view in self.showView.subviews) {
        if ([view isKindOfClass:[XSanBiaoDetailBottomProjectView class]]||[view isKindOfClass:[XSanBiaoDetailBottomWindInfoView class]]||[view isKindOfClass:[XSanBiaoDetailBottomInvestListView class]]||[view isKindOfClass:[XSanBiaoDetailBottomPayPlanView class]]) {
            [view removeFromSuperview];            
        }
    }
    
    switch (sender.tag) {
        case 1000:{
            self.showView.frame = CGRectMake(0, CGRectGetMaxY(_blueLine.frame), ScreenWidth, 930);
            [self.showView addSubview:self.projectView];
            break;
        }
        case 1001:{
            if (is_iPhone5) {
                self.showView.frame = CGRectMake(0, CGRectGetMaxY(_blueLine.frame), ScreenWidth, 500);
            }else{
                self.showView.frame = CGRectMake(0, CGRectGetMaxY(_blueLine.frame), ScreenWidth, 420);
            }
            [self.showView addSubview: self.windInfoView];
            break;
        }
        case 1002:{
            self.showView.frame = CGRectMake(0, CGRectGetMaxY(_blueLine.frame), ScreenWidth, 40 + XSanBiaoDetailLableHeight+1+XSanBiaoDetailLableHeight*self.investModel.listArr.count);
            [self.showView addSubview: self.investView];
            self.investView.investModel = self.investModel;
            break;
        }
        case 1003:{
            self.showView.frame = CGRectMake(0, CGRectGetMaxY(_blueLine.frame), ScreenWidth, (40+ 20+XSanBiaoDetailLableHeight*self.payListArr.count+XSanBiaoDetailLableHeight/2));
            [self.showView addSubview:self.planView];
            if (self.showPlanViewWord == YES) {
                [self.planView showPayPlanViewAlterWord];
            }
            else{
                self.planView.payListModelArr = self.payListArr;
            }
            break;
        }
        default:
            break;
    }
    
    _projectCourseView.frame =CGRectMake(0, CGRectGetMaxY(((UIView *)self.showView).frame)+30, ScreenWidth, 140);
    _graylabel.frame = CGRectMake(0, CGRectGetMaxY(_projectCourseView.frame), ScreenWidth, 100);
    
    if (_delegate && [_delegate respondsToSelector:@selector(changeHeightWtihBottom:)]) {
        [_delegate changeHeightWtihBottom:CGRectGetMaxY(self.showView.frame)+ 140 + 30 + 40];
    }
}


- (UIView *)projectViewWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    //添加项目历程
    UILabel *projectCourseL = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 3, 15)];
    projectCourseL.backgroundColor =[XAppContext appColors].blueColor;
    [view addSubview:projectCourseL];
    UILabel *basicInfo = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"项目历程" textColor:[XAppContext appColors].blackColor frame:CGRectMake(15*2, CGRectGetMinY(projectCourseL.frame), 100, 20) textAlignment:NSTextAlignmentLeft];
    [view addSubview:basicInfo];
    
    CGFloat imageViewHeight = is_iPhone5?80:100;
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(projectCourseL.frame)+20, ScreenWidth - 30, imageViewHeight)];
    bottomImageView.image = [UIImage imageNamed:@"sanBiao_Project"];
    [view addSubview:bottomImageView];
    return view;
}
#pragma mark - lazy

- (XSanBiaoDetailBottomProjectView *)projectView{
    if (!_projectView) {
        _projectView = [[XSanBiaoDetailBottomProjectView alloc] init];
    }
    return _projectView;
}

- (XSanBiaoDetailBottomWindInfoView *)windInfoView{
    if (!_windInfoView) {
        _windInfoView = [[XSanBiaoDetailBottomWindInfoView alloc] init];
    }
    return _windInfoView;
}

- (XSanBiaoDetailBottomInvestListView *)investView{
    if (!_investView) {
        _investView = [[XSanBiaoDetailBottomInvestListView alloc] init];
    }
    return _investView;
}

-(XSanBiaoDetailBottomPayPlanView *)planView{
    if (!_planView) {
        _planView = [[XSanBiaoDetailBottomPayPlanView alloc] init];
    }
    return _planView;
}

@end

#pragma mark -  项目信息
@implementation XSanBiaoDetailBottomProjectView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [XAppContext appColors].whiteColor;
        [self initElement];
    }
    return self;
}

- (void)initElement{
    [self addSubview:blueHorizenLabelWithY(5)];
    
    UILabel *basicInfo = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"基本信息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin*2, 5, XSanBiaoDetailLableWidth, 20) textAlignment:NSTextAlignmentLeft];
    [self addSubview:basicInfo];
    
    //借款事由
    UILabel *borrowReasonL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"借款事由" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,  CGRectGetMaxY(basicInfo.frame)+5, XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:borrowReasonL];
    self.borrowReasonLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(borrowReasonL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.borrowReasonLabel];
    
    //借款金额
    UILabel *loanAmountL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"借款金额" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(borrowReasonL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:loanAmountL];
    self.loanAmountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(loanAmountL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.loanAmountLabel];
    
    //借款期限
    UILabel *deadLineL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"借款期限" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(loanAmountL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:deadLineL];
    self.deadLineLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(deadLineL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.deadLineLabel];
    
    
    //信用级别
    UILabel *creditLevelL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"信用级别" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(deadLineL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:creditLevelL];
    self.creditLevelLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(creditLevelL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.creditLevelLabel];
    
    //还款方式
    UILabel *paymentWayL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"还款方式" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(creditLevelL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:paymentWayL];
    self.paymentWayLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(paymentWayL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.paymentWayLabel];
    
    
    
    [self addSubview: blueHorizenLabelWithY(CGRectGetMaxY(paymentWayL.frame)+20)];
    UILabel *personInfoL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"个人信息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin*2, (CGRectGetMaxY(paymentWayL.frame)+20), XSanBiaoDetailLableWidth, 20) textAlignment:NSTextAlignmentLeft];
    [self addSubview:personInfoL];
    
    //姓名
    UILabel *nameL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"姓名" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(personInfoL.frame)+5 , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:nameL];
    self.nameLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(nameL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.nameLabel];
    
    
    //性别
    UILabel *sexL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"性别" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(nameL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:sexL];
    self.sexLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(sexL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.sexLabel];
    
    
    //年龄
    UILabel *ageL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"年龄" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(sexL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:ageL];
    self.ageLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(ageL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.ageLabel];
    
    
    //学历
    UILabel *educationL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"学历" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(ageL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:educationL];
    self.educationLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(educationL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.educationLabel];
    
    
    //婚姻状况
    UILabel *marriedL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"婚姻状况" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(educationL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:marriedL];
    self.marriedLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(marriedL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.marriedLabel];
    
    //现居住地
    UILabel *livePlaceL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"现居住地" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(marriedL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:livePlaceL];
    self.livePlaceLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(livePlaceL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.livePlaceLabel];
    
    //    平台逾期次数 0次
    UILabel *platformPastTimeL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"平台逾期次数" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(livePlaceL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:platformPastTimeL];
    UILabel *platformPastTimeLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"0次" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(platformPastTimeL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:platformPastTimeLabel];
    //    平台逾期金额 0.00元
    UILabel *platformPastMoneyL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"平台逾期总金额" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(platformPastTimeL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:platformPastMoneyL];
    UILabel *platformPastMoneyLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"0.00元" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(platformPastMoneyL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:platformPastMoneyLabel];
    
    
    [self addSubview:blueHorizenLabelWithY(CGRectGetMaxY(platformPastMoneyL.frame)+20)];
    UILabel *auditStateL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"审核状态" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin*2, (CGRectGetMaxY(platformPastMoneyL.frame)+20), XSanBiaoDetailLableWidth, 20) textAlignment:NSTextAlignmentLeft];
    [self addSubview:auditStateL];
    
    //身份证信息
    UILabel *IDCardL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"身份证信息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(auditStateL.frame)+5 , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:IDCardL];
    self.IDCardLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth/2, CGRectGetMinY(IDCardL.frame), XSanBiaoDetailLableWidth/2, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.IDCardLabel];
    [self addSubview:[self imageViewWithX:CGRectGetMinX(self.IDCardLabel.frame)-15 Y:CGRectGetMinY(self.IDCardLabel.frame)+12.5]];

    //银行信息
    UILabel *bankInfoL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"银行卡信息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(IDCardL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:bankInfoL];
    self.bankInfoLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth/2, CGRectGetMinY(bankInfoL.frame), XSanBiaoDetailLableWidth/2, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.bankInfoLabel];
    [self addSubview:[self imageViewWithX:CGRectGetMinX(self.bankInfoLabel.frame)-15 Y:CGRectGetMinY(self.bankInfoLabel.frame)+12.5]];

    //信用报告
    UILabel *creditReportL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"信用报告" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(bankInfoL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:creditReportL];
    self.creditReportLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth/2, CGRectGetMinY(creditReportL.frame),XSanBiaoDetailLableWidth/2, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.creditReportLabel];
    [self addSubview:[self imageViewWithX:CGRectGetMinX(self.creditReportLabel.frame)-15 Y:CGRectGetMinY(self.creditReportLabel.frame)+12.5]];

    //联系人信息
    UILabel *contactsL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"联系人信息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(creditReportL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:contactsL];
    self.contactsLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth/2, CGRectGetMinY(contactsL.frame), XSanBiaoDetailLableWidth/2, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.contactsLabel];
    [self addSubview:[self imageViewWithX:CGRectGetMinX(self.contactsLabel.frame)-15 Y:CGRectGetMinY(self.contactsLabel.frame)+12.5]];
    
    //收入认证
    UILabel *inCommonCertificationL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"收入认证" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(contactsL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:inCommonCertificationL];
    self.inCommonCertificationLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth/2, CGRectGetMinY(inCommonCertificationL.frame), XSanBiaoDetailLableWidth/2, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.inCommonCertificationLabel];
    [self addSubview:[self imageViewWithX:CGRectGetMinX(self.inCommonCertificationLabel.frame)-15 Y:CGRectGetMinY(self.inCommonCertificationLabel.frame)+12.5]];

    
    [self addSubview:blueHorizenLabelWithY(CGRectGetMaxY(inCommonCertificationL.frame)+20)];
    UILabel *assetInfoL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"资产信息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin*2, (CGRectGetMaxY(inCommonCertificationL.frame)+20), XSanBiaoDetailLableWidth, 20) textAlignment:NSTextAlignmentLeft];
    [self addSubview:assetInfoL];
    
    //房产证明
    UILabel *houseCertificationL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"房产证明" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(assetInfoL.frame)+5 , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:houseCertificationL];
    self.houseCertificationLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth/2, CGRectGetMinY(houseCertificationL.frame), XSanBiaoDetailLableWidth/2, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.houseCertificationLabel];
    [self addSubview:[self imageViewWithX:CGRectGetMinX(self.houseCertificationLabel.frame)-15 Y:CGRectGetMinY(self.houseCertificationLabel.frame)+12.5]];

    
    //车产证明
    UILabel *carCertificationL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"车产证明" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,CGRectGetMaxY(houseCertificationL.frame) , XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [self addSubview:carCertificationL];
    self.carCertificationLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth/2, CGRectGetMinY(carCertificationL.frame), XSanBiaoDetailLableWidth/2, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [self addSubview:self.carCertificationLabel];
    [self addSubview:[self imageViewWithX:CGRectGetMinX(self.carCertificationLabel.frame)-15 Y:CGRectGetMinY(self.carCertificationLabel.frame)+12.5]];
}

//完成图标
- (UIImageView *)imageViewWithX:(CGFloat)x Y:(CGFloat)y{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sanbiao_investCompelte"]];
    imageView.frame = CGRectMake(x, y, 15, 15);
    return imageView;
}

@end

#pragma mark - 风险保障计划
@implementation XSanBiaoDetailBottomWindInfoView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [XAppContext appColors].whiteColor;

        UILabel *blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(XSanBiaoDetailLeftMargin, 5, 3, XSanBiaoDetailLeftMargin)];
        blueLabel.backgroundColor =[XAppContext appColors].blueColor;
        [self addSubview:blueLabel];
        
        self.windInfoL = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"风险保障计划" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin*2, 5, 100, 20) textAlignment:NSTextAlignmentLeft];
        [self addSubview:self.windInfoL];
        CGFloat labelHeight = is_iPhone5?480:400;
        UILabel *windInfoLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"一、前置严格的借款人准入机制\n        平台上线借款人都要采用立体化多层级的大数据采集分析系统结合先进的反欺诈措施对拟上线借款项目从多个维度考核，并结合线下战略合作服务机构的专业尽调团队对拟上线项目进行360度实地尽职调查。调查内容包括但不限于可能存在的隐性负债数据、人行征信系统、税务系统数据、工商局系统数据、车辆管理系统数据、房屋管理系统数据、法院系统数据、银行流水数据等，保证上线项目需求真实、用途合法及项目主体有稳定、可信的还款能力，最终为风险把控提供可信依据。\n\n二、风险保障金先行支付、受让机制\n        风险保障金受让机制是指为，要求推荐对应借款项下借款人的平台合作机构或其指定机构提取一定比例的保证金放入“风险保障金”专用账户，用于担保该作机构推荐的借款人的逾期、垫付义务的履行。\n        当出借人投资的某笔借款出现逾期时，自动触发风险保障金先行支付机制，直接使用风险保障金账户内的保证金先行支付当期出借人应收款项；当借款人出现连续逾期时（超3期），将触发风险保障金受让机制由平台合作机构或其指定机构受让原出借人投资的此笔借款的剩余未偿投资本金或剩余未偿投资本金和逾期当期利息（具体情况视投资标的类型的具体偿付规则为准）。" textColor:[XAppContext appColors].grayBlackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(self.windInfoL.frame)+10, ScreenWidth-2*XSanBiaoDetailLeftMargin, labelHeight) textAlignment:NSTextAlignmentLeft];
        windInfoLabel.numberOfLines = 0;
        [self addSubview:windInfoLabel];
        
    }
    return self;
}

@end

#pragma mark - 投资列表

@implementation XSanBiaoDetailBottomInvestListView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [XAppContext appColors].whiteColor;
        [self initElement];
    }
    return self;
}

- (void)initElement{
    self.investInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake (XSanBiaoDetailLeftMargin, 0, ScreenWidth -2*XSanBiaoDetailLeftMargin, XSanBiaoDetailLableHeight)];
    self.investInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.investInfoLabel.font = [XAppContext appFonts].font_15;
    self.investInfoLabel.tag  = 10000;
    [self addSubview:self.investInfoLabel];
    
    UILabel *infoBottomL = [[UILabel alloc] initWithFrame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(self.investInfoLabel.frame), ScreenWidth - 2*XSanBiaoDetailLeftMargin, 1)];
    infoBottomL.backgroundColor = [XAppContext appColors].lineColor;
    infoBottomL.tag = 10000;
    [self addSubview:infoBottomL];
}

- (void)setInvestModel:(XSanBiaoInvestModel *)investModel{
    if (investModel.listArr.count==0) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        UILabel *label = [UILabel labelWithFont:[XAppContext appFonts].font_20 text:@"暂无投资记录" textColor:[XAppContext appColors].lightGrayColor];
        label.backgroundColor = [XAppContext appColors].whiteColor;
        label.frame = CGRectMake(0, 0, ScreenWidth, 80);
        [self addSubview:label];
    }else{
        
        for (UIView *view in self.subviews) {
            if (view.tag != 10000) {
                [view removeFromSuperview];
            }
        }
        _investModel = investModel;
        
        NSMutableAttributedString *investMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已投资总金额%@元",[[NSNumber numberWithDouble:_investModel.money] decimalString]]];
        [investMoneyStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(6, investMoneyStr.length-6)];
        NSMutableAttributedString *investStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已投资%ld笔",_investModel.count]];
        [investStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].redColor range:NSMakeRange(3, investStr.length - 4)];
        [investStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"    "]];
        [investStr appendAttributedString:investMoneyStr];
        self.investInfoLabel.attributedText = investStr;
                
        NSArray *listArr = investModel.listArr;
        for (NSInteger i= 0; i<=listArr.count; i++) {
            if (i == 0) {
                UIView *view = [self viewWithFrameY:( CGRectGetMaxY(self.investInfoLabel.frame)+1+XSanBiaoDetailLableHeight*i) leftTitle:@"投资人" centerTitle:@"投资金额(元)" rightTitle:@"投资时间" color:YES];
                [self addSubview:view];
            }else{
                UIView *view = [self viewWithFrameY:( CGRectGetMaxY(self.investInfoLabel.frame)+1+XSanBiaoDetailLableHeight*i) leftTitle:((XSanBiaoInvestSubModel *)listArr[i-1]).u_user_name centerTitle:[[NSNumber numberWithFloat:((XSanBiaoInvestSubModel *)listArr[i-1]).i_invest_amount] decimalString] rightTitle:((XSanBiaoInvestSubModel *)listArr[i-1]).i_invest_time color:NO];
                [self addSubview:view];
            }
            
        }
    }
}
//color YES 为黑色
- (UIView *)viewWithFrameY:(CGFloat)frmeY leftTitle:(NSString *)leftTitle centerTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle color:(BOOL)color{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, frmeY, ScreenWidth, XSanBiaoDetailLableHeight)];
    //截取字符串
    if (!color) {
        rightTitle = [rightTitle substringToIndex:10];
    }
    UILabel *leftLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:leftTitle textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, 0, (ScreenWidth - 2*XSanBiaoDetailLeftMargin)/3, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [view addSubview:leftLabel];
    
    UILabel *centerLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:centerTitle textColor:[XAppContext appColors].orangeColor frame:CGRectMake(XSanBiaoDetailLeftMargin + (ScreenWidth - 2*XSanBiaoDetailLeftMargin)/3, 0, (ScreenWidth - 2*XSanBiaoDetailLeftMargin)/3, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentCenter];
    [view addSubview:centerLabel];
    
    UILabel *rightLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:rightTitle textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(XSanBiaoDetailLeftMargin + (ScreenWidth - 2*XSanBiaoDetailLeftMargin)/3*2, 0, (ScreenWidth - 2*XSanBiaoDetailLeftMargin)/3, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [view addSubview:rightLabel];

    UILabel *viewBgL = [[UILabel alloc] initWithFrame:CGRectMake(XSanBiaoDetailLeftMargin, XSanBiaoDetailLableHeight, ScreenWidth - 2*XSanBiaoDetailLeftMargin, 1)];
    viewBgL.backgroundColor = [XAppContext appColors].lineColor;
    [view addSubview:viewBgL];
    if (color) {
        centerLabel.textColor = rightLabel.textColor = leftLabel.textColor = [XAppContext appColors].blackColor;
    }else{
        leftLabel.text = [leftTitle stringByReplacingCharactersInRange:NSMakeRange(1, leftTitle.length -2) withString:@
         "******"];
    }
    
    return view;
}

@end


#pragma mark - 还款计划

@implementation XSanBiaoDetailBottomPayPlanView

- (instancetype)init{
    self = [super init];
    if (self ) {
        self.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return self;
}

- (void)showPayPlanViewAlterWord{
    UILabel *label = [UILabel labelWithFont:[XAppContext appFonts].font_20 text:@"您未购买此标，不能看到信息" textColor:[XAppContext appColors].lightGrayColor];
    label.frame = CGRectMake(0, 0, ScreenWidth, 80);
    if (![UserManager User].token) {
        label.text = @"您未登录，请先登录";
    }
    [self addSubview:label];
}

- (void)setPayListModelArr:(NSArray<XSanBiaoPayListModel *> *)payListModelArr{
    for (UIView *view  in self.subviews) {
        [view removeFromSuperview];
    }
    
    _payListModelArr = payListModelArr;
    if (_payListModelArr.count==0) {
        return;
    }
    
    for (NSInteger i=0; i<= _payListModelArr.count; i++) {
        if (i == 0) {
            UIView *view =  [self viewWithFrameY:20+XSanBiaoDetailLableHeight *i frameHeight:XSanBiaoDetailLableHeight/2*3 noStr:@"期次" leftTitle:@"预计还款\n时间" centerTitle:@"应收本金／利息\n（元）" rightTitle:@"应收本息（元）" color:YES];
            [self addSubview:view];
        }else{
            UIView *view =  [self viewWithFrameY:20+XSanBiaoDetailLableHeight*i+XSanBiaoDetailLableHeight/2
                                     frameHeight:XSanBiaoDetailLableHeight
                                           noStr:[NSString stringWithFormat:@"%ld",(long)((XSanBiaoPayListModel*)_payListModelArr[i-1]).d_months]
                                       leftTitle:((XSanBiaoPayListModel*)_payListModelArr[i-1]).d_pay_dayx
                                     centerTitle:[NSString stringWithFormat:@"%.2f/%.2f",((XSanBiaoPayListModel*)_payListModelArr[i-1]).d_pay_amount,((XSanBiaoPayListModel*)_payListModelArr[i-1]).d_interest_backshould]
                                      rightTitle:[NSString stringWithFormat:@"%.2f",((XSanBiaoPayListModel*)_payListModelArr[i-1]).d_pay_amount+((XSanBiaoPayListModel*)_payListModelArr[i-1]).d_interest_backshould]
                                           color:NO];
            [self addSubview:view];
        }
    }
}
//color YES 黑色
- (UIView *)viewWithFrameY:(CGFloat)frmeY frameHeight:(CGFloat)height noStr:(NSString *)noStr leftTitle:(NSString *)leftTitle centerTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle color:(BOOL)color{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, frmeY, ScreenWidth, height)];
    view.backgroundColor = [XAppContext appColors].whiteColor;
    
    CGFloat noLableW = is_iPhone5? 35: 40;
    CGFloat leftMargin = is_iPhone5?XSanBiaoDetailLeftMargin*0.6:XSanBiaoDetailLeftMargin;
    UILabel *noLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:noStr textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, 00, noLableW, height) textAlignment:NSTextAlignmentCenter];
    noLabel.numberOfLines = 0;
    [view addSubview:noLabel];
    
    CGFloat dateLabelW = is_iPhone5? 83: 90;
    UILabel *dateLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:leftTitle textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(CGRectGetMaxX(noLabel.frame), 0, dateLabelW, height) textAlignment:NSTextAlignmentCenter];
    dateLabel.numberOfLines = 0;
    [view addSubview:dateLabel];
    
    CGFloat listLabelW = is_iPhone5? 110: 120;
    UILabel *listLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:centerTitle textColor:[XAppContext appColors].orangeColor frame:CGRectMake(CGRectGetMaxX(dateLabel.frame), 0, listLabelW, height) textAlignment:NSTextAlignmentCenter];
    listLabel.numberOfLines = 0;
    [view addSubview:listLabel];
    
    UILabel *interestLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:rightTitle textColor:[XAppContext appColors].orangeColor frame:CGRectMake(CGRectGetMaxX(listLabel.frame), 0, ScreenWidth- leftMargin - CGRectGetMaxX(listLabel.frame), height) textAlignment:NSTextAlignmentCenter];
    interestLabel.numberOfLines = 0;
    [view addSubview:interestLabel];
    
    [view addSubview:[self labelWithFrameX:leftMargin Y:0 width:(ScreenWidth -2*leftMargin) height:1]];
    [view addSubview:[self labelWithFrameX:leftMargin Y:height width:(ScreenWidth -2*leftMargin) height:1]];
    [view addSubview:[self labelWithFrameX:leftMargin Y:0 width:1 height:height]];
    
    [view addSubview:[self labelWithFrameX:CGRectGetMaxX(noLabel.frame) Y:0 width:1 height:height]];
    [view addSubview:[self labelWithFrameX:CGRectGetMaxX(dateLabel.frame) Y:0 width:1 height:height]];
    [view addSubview:[self labelWithFrameX:CGRectGetMaxX(listLabel.frame) Y:0 width:1 height:height]];
    [view addSubview:[self labelWithFrameX:(ScreenWidth - leftMargin) Y:0 width:1 height:height]];
    if (color) {
        noLabel.textColor = dateLabel.textColor = listLabel.textColor = interestLabel.textColor = [XAppContext appColors].blackColor;
    }
    return view;
}

- (UILabel *)labelWithFrameX:(CGFloat)x Y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    label.backgroundColor = [XAppContext appColors].lineColor;
    return label;
}

@end

//还款计划
@implementation XAssetBaoListView{
    UILabel *_basicInfo;
}

- (instancetype)initWithFrame:(CGRect)frame listModelArr:(NSArray<XAssetBaoListModel *> *)listModelArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [XAppContext appColors].whiteColor;
        [self initElementsWithdArr:listModelArr];
    }
    return self;
}
- (void)initElementsWithdArr:(NSArray<XAssetBaoListModel *> *)listModelArr{
    if ([listModelArr count] == 0 ) {
        return;
    }
    
    [self addSubview:blueHorizenLabelWithY(5)];
    
    _basicInfo = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"标的组成" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin*2, 5, XSanBiaoDetailLableWidth, 20) textAlignment:NSTextAlignmentLeft];
    [self addSubview:_basicInfo];
    
    for (NSInteger i = 0; i<listModelArr.count; i++) {
        UIView *view = [self viewWithFrame:CGRectMake(0, CGRectGetMaxY(_basicInfo.frame)+ 200*i, ScreenWidth, 200) Model:listModelArr[i]];
        [self addSubview:view];
    }
}

- (UIView *)viewWithFrame:(CGRect)frame Model:(XAssetBaoListModel *)model{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [XAppContext appColors].whiteColor;
    //标的编号
    UIView *borrowBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 30)];
    borrowBgView.backgroundColor = [XAppContext appColors].lineColor;
    [view addSubview:borrowBgView];
    UILabel *borrowReasonL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"标的编号" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin,  0, XSanBiaoDetailLableWidth-30, CGRectGetHeight(borrowBgView.frame)) textAlignment:NSTextAlignmentLeft];
    [borrowBgView addSubview:borrowReasonL];
    UILabel * borrowReasonLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:model.m_number textColor:[XAppContext appColors].grayBlackColor frame:CGRectMake(CGRectGetMaxX(borrowReasonL.frame), 0,XSanBiaoDetailLableWidth, CGRectGetHeight(borrowBgView.frame)) textAlignment:NSTextAlignmentRight];
    [borrowBgView addSubview:borrowReasonLabel];
    
    //标的金额
    UILabel *loanAmountL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"标的金额（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(borrowBgView.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [view addSubview:loanAmountL];
    UILabel * loanAmountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:[NSString stringWithFormat:@"%.2f",model.m_money] textColor:[XAppContext appColors].orangeColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(loanAmountL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [view addSubview:loanAmountLabel];
    
    //可投金额
    UILabel *deadLineL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"可投金额（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(loanAmountL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [view addSubview:deadLineL];
    UILabel* deadLineLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:[NSString stringWithFormat:@"%.2f",(model.m_money - model.m_rated_money)] textColor:[XAppContext appColors].orangeColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(deadLineL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    [view addSubview:deadLineLabel];
    
    
    //期限
    UILabel *creditLevelL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"期限" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(deadLineL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [view addSubview:creditLevelL];
    UILabel * creditLevelLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(creditLevelL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    NSMutableAttributedString *deadLineStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld个月",model.m_deadline]];
    [deadLineStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(0, deadLineStr.length-2)];
    creditLevelLabel.attributedText = deadLineStr;
    [view addSubview:creditLevelLabel];
    
    //还款方式
    UILabel *paymentWayL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"还款方式" textColor:[XAppContext appColors].blackColor frame:CGRectMake(XSanBiaoDetailLeftMargin, CGRectGetMaxY(creditLevelL.frame), XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentLeft];
    [view addSubview:paymentWayL];
    UILabel *paymentWayLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(ScreenWidth- XSanBiaoDetailLeftMargin - XSanBiaoDetailLableWidth, CGRectGetMinY(paymentWayL.frame),XSanBiaoDetailLableWidth, XSanBiaoDetailLableHeight) textAlignment:NSTextAlignmentRight];
    paymentWayLabel.text = model.m_way == 1?@"等额本息":@"等额本息";
    [view addSubview:paymentWayLabel];
    
    return view;
}

@end



