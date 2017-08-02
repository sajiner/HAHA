//
//  XSanBiaoInvestFormView.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/24.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 投资页面
@protocol  XSanBiaoInvestFormViewDelegate <NSObject>
@required
- (void)gotoCharge;
- (void)sanbiaoNextStep;
- (void)popViewConfirmBtn;
- (void)hidePOPView;
- (void)continueInvest;
- (void)lookForMyInvest;
- (void)computeIncome:(CGFloat)money;
- (void)riskDisBtnC;
- (void)loanAgreeBtnC;

@end

@interface XSanBiaoInvestFormView : UIView
//项目名称
@property (nonatomic,strong)UILabel *IDL;
//ID
@property (nonatomic,strong)UILabel *IDLabel;
//剩余可投
@property (nonatomic,strong)UILabel *surplusCastLabel;
//投资金额
@property (nonatomic,strong)UITextField *investAmountTextfield;
//投资期限
@property (nonatomic,strong)UILabel *investTermLabel;
//过往年化收益率
@property (nonatomic,strong)UILabel *pastAnnuaYieldLabel;
//预计收益
@property (nonatomic,strong)UILabel *expectedLabel;

@property (nonatomic,weak)id<XSanBiaoInvestFormViewDelegate>delegate;

@end

#pragma mark - 投资弹出页面

@interface XSanBiaoInvestFormPopView : UIView

@property (nonatomic,weak)id<XSanBiaoInvestFormViewDelegate>delegate;

- (void)setInvest:(NSString *)money investTerm:(NSString *)term profit:(NSString *)profit expect:(NSString *)expect;

@end


#pragma mark - 投资完成页面
@interface XSanBiaoInvestSucceedView : UIView
@property (nonatomic,strong)UILabel *IDL;
@property (nonatomic,strong)UILabel *IDLabel;
@property (nonatomic,strong)UILabel *investMoneyLabel;
@property (nonatomic,strong)UILabel *profitLabel;
@property (nonatomic,weak)id<XSanBiaoInvestFormViewDelegate>delegate;

@end

