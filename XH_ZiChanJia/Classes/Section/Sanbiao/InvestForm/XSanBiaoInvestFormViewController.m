//
//  XSanBiaoInvestFormViewController.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoInvestFormViewController.h"
#import "XSanBiaoInvestFormView.h"
#import "XSanBiaoGetInvestIncomeApi.h"
#import "XSanBiaoInvestMarkApi.h"
#import "XMySanBiaoViewController.h"
#import "XToppedUpViewController.h"
#import "XWebViewController.h"
#import "XAssetpackageInvestApi.h"
#import "XMyJiaYingViewController.h"

@interface XSanBiaoInvestFormViewController ()<XSanBiaoInvestFormViewDelegate,YTKRequestDelegate>{
    NSString * _token;
    CGFloat _amount;
    NSInteger _pid;
    NSString * _ip;
    NSInteger _terminal;
    double  _computeAmout;
}
@property (nonatomic,strong)XSanBiaoInvestFormView * formView;
@property (nonatomic,strong)XSanBiaoInvestFormPopView * popView;
@property (nonatomic,strong)XSanBiaoInvestSucceedView * succedView;
@property (nonatomic,strong)XSanBiaoInvestMarkApi *investMarkApi;//散标投资接口
@property (nonatomic,strong)XSanBiaoGetInvestIncomeApi *incomeApi;//预计收益
@property (nonatomic,strong)XAssetpackageInvestApi *assetInvestApi;//资产包投资接口
@end

@implementation XSanBiaoInvestFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.formView];
    [self setSanbiaoValue];
    self.popView.alpha = 0;
    _ip =[NSString getIPAddress:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XSanBiaoInvestFormViewDelegate
- (void)gotoCharge{
    
    XToppedUpViewController *chargeVC = [[XToppedUpViewController alloc] init];
    [self.navigationController pushViewController:chargeVC animated:YES];
}

- (void)sanbiaoNextStep{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    [self setPopViewValue];
    self.popView.alpha = 1;
}


- (void)popViewConfirmBtn{
    [self hidePOPView];
    _computeAmout = [self.formView.expectedLabel.text doubleValue];
    if ([self.title isEqualToString:@"散标"] ) {
        [self.investMarkApi start];
    }else{
        [self.assetInvestApi start];
    }
    
    
}
- (void)hidePOPView{
    
    self.popView.alpha = 0;
    [self.popView removeFromSuperview];
}

- (void)loanAgreeBtnC{//借款协议
    
    XWebViewController *helpCenterVC = [[XWebViewController alloc]init];
    helpCenterVC.urlString = Request_loanAgreement;
    [self.navigationController pushViewController:helpCenterVC animated:YES];
}

- (void)riskDisBtnC{//风险揭示书
    
    XWebViewController *helpCenterVC = [[XWebViewController alloc]init];
    helpCenterVC.urlString = Request_riskDisclosure;
    [self.navigationController pushViewController:helpCenterVC animated:YES];
}

- (void)continueInvest{//继续投资
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)lookForMyInvest{//查看我的投资
    if ([self.title isEqualToString:@"散标"] ) {
        XMySanBiaoViewController *mySanBiaoVC = [[XMySanBiaoViewController alloc] init];
        [self.navigationController pushViewController:mySanBiaoVC animated:YES];
    }else{
        XMyJiaYingViewController *myJiaYingVc = [[XMyJiaYingViewController alloc] init];
        myJiaYingVc.title = @"我的嘉盈";
        [self.navigationController pushViewController:myJiaYingVc animated:YES];

    }
}

- (void)computeIncome:(CGFloat)money{
    _amount = money;
    if ([self.title isEqualToString:@"散标"]) {
        [self.incomeApi start];
    }else{
//        投资金额*利率*期数/12 舍弃小数点后两位的数字
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.roundingMode = NSNumberFormatterRoundFloor;
        formatter.maximumFractionDigits = 2;
        
        NSNumber *number = [NSNumber numberWithDouble:(_amount*self.model.p_project_rate*self.model.p_project_deadline/100/12)];
        NSLog(@"number__%@",number);
        self.formView.expectedLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:number]];
        _computeAmout = [self.formView.expectedLabel.text doubleValue];
        NSLog(@"_computeAmout__%lf",_computeAmout);
        if (self.popView.alpha== 1) {
            [self setPopViewValue];
        }
    }
}


#pragma mark - YTKRequestDelegate
- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    
    NSDictionary *result = request.responseJSONObject;
    NSInteger state = [result[@"status"] integerValue];
    
    if (request == _investMarkApi) {
        if (state ==  1) {
            [self.view addSubview:self.succedView];
            [self setSuccedViewValue];
        }else{
            [self completeLoadWithTitle:[NSString stringWithFormat:@"%@",result[@"message"]]];
        }
    
    }else if (request == _incomeApi){
        if (state == 1) {
            self.formView.expectedLabel.text = [NSString stringWithFormat:@"%.2f",[[request.responseObject objectForKey:@"data"] doubleValue]];
            if (self.popView.alpha== 1) {
                [self setPopViewValue];
            }            
        }else{
             [self completeLoadWithTitle:[NSString stringWithFormat:@"%@",result[@"message"]]];
        }
    }else if (request == _assetInvestApi){
        if (state ==  1) {
            [self.view addSubview:self.succedView];
            [self setSuccedViewValue];
        }else{
            [self completeLoadWithTitle:[NSString stringWithFormat:@"%@",result[@"message"]]];
        }
    }
    
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request{
    NSLog(@"requestFailed");
}


#pragma mark - private method

- (void)setSanbiaoValue{
    
    CGSize size = [self.model.p_project_name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(ScreenWidth-200, 30) lineBreakMode:NSLineBreakByTruncatingTail];
    self.formView.IDL.frame = CGRectMake(15, 0, size.width, 40);;
    self.formView.IDLabel.frame =  CGRectMake(CGRectGetMaxX(self.formView.IDL.frame)+15, 0,200, 40);
    
    self.formView.IDL.text = self.model.p_project_name;
    
    self.formView.IDLabel.text = [self.title isEqualToString:@"散标"] ? [NSString stringWithFormat:@"ID  %@",self.model.m_number]:self.model.m_number;
    self.formView.surplusCastLabel.text = [NSString stringWithFormat:@"%.2f",self.model.p_rating_money];
    self.formView.pastAnnuaYieldLabel.text = [NSString stringWithFormat:@"%.2f%%",self.model.p_project_rate];
    NSMutableAttributedString *expectAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld个月",(long)self.model.p_project_deadline]];
    [expectAttrStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(0, expectAttrStr.length -2)];
    self.formView.investTermLabel.attributedText = expectAttrStr;
}
- (void)setPopViewValue{
    
  [self.popView setInvest:self.formView.investAmountTextfield.text investTerm:self.formView.investTermLabel.text profit:self.formView.pastAnnuaYieldLabel.text expect:self.formView.expectedLabel.text];
}
- (void)setSuccedViewValue{
    self.succedView.IDL.text = [self.title isEqualToString:@"散标"]? @"个人信用贷款":@"嘉盈系列";
    self.succedView.IDLabel.text = [NSString stringWithFormat:@"ID  %@",self.model.m_number];
    self.succedView.investMoneyLabel.text = self.formView.investAmountTextfield.text;
    self.succedView.profitLabel.text = [NSString stringWithFormat:@"%.2f",_computeAmout];
}
#pragma mark - lazy
- (XSanBiaoInvestFormView *)formView{
    if (!_formView) {
        _formView = [[XSanBiaoInvestFormView alloc] initWithFrame:self.view.frame];
        _formView.delegate = self;
    }
    return _formView;
}

- (XSanBiaoInvestFormPopView *)popView{
    if (!_popView) {
        _popView = [[XSanBiaoInvestFormPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _popView.delegate = self;
    }
    return _popView;
}

- (XSanBiaoInvestSucceedView *)succedView{
    if (!_succedView) {
        _succedView = [[XSanBiaoInvestSucceedView alloc] initWithFrame:self.formView.frame];
        _succedView.delegate = self;
    }
    return _succedView;
}

- (XAssetpackageInvestApi *)assetInvestApi{
    _assetInvestApi = [[XAssetpackageInvestApi alloc] initWithToken:[UserManager User].token amount:_amount income:_computeAmout projectId:self.pid ip:_ip terminal:2];
    _assetInvestApi.delegate = self;
    return _assetInvestApi;
}

- (XSanBiaoInvestMarkApi *)investMarkApi{
    _investMarkApi = [[XSanBiaoInvestMarkApi alloc] initWithToken:[UserManager User].token amount:_amount income:_computeAmout projectId:self.pid ip:_ip terminal:2];
    _investMarkApi.delegate = self;
    return _investMarkApi;
    
}

- (XSanBiaoGetInvestIncomeApi *)incomeApi{
    _incomeApi = [[XSanBiaoGetInvestIncomeApi alloc] initWithAmout:_amount pId:self.pid];
    _incomeApi.delegate = self;
    return _incomeApi;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
