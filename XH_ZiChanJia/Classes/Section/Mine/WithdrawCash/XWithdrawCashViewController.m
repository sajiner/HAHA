//
//  XWithdrawCashViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XWithdrawCashViewController.h"
#import "XWithdrawCashView.h"
#import "XDrawCashApi.h"
#import "XGetBankCardApi.h"
#import "XGoldViewController.h"
#import "XPacketApi.h"
#import "XWebViewController.h"

@interface XWithdrawCashViewController ()<XWithdrawCashViewDelegate, YTKRequestDelegate, UITextFieldDelegate>

@property (nonatomic, strong) XWithdrawCashView *withdrawCashView;
// 提现api
@property (nonatomic, strong) XDrawCashApi *drawCashApi;
// 获取银行卡信息
@property (nonatomic, strong) XGetBankCardApi *bankCardApi;
// 用户行为请求api(发送给后台)
@property (nonatomic, strong) XPacketApi *packetApi;

@end

@implementation XWithdrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉导航栏底部线
    self.navigationController.hiddenLineView = YES;
    // 右侧导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现请阅" style:UIBarButtonItemStylePlain target:self action:@selector(withdrawCashNotice)];
    
    
    [self.view addSubview:self.withdrawCashView];
    // 获取银行卡信息
    [self.bankCardApi start];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.withdrawCashView endEditing:YES];
}

#pragma mark - 提现请阅
- (void)withdrawCashNotice {
    XWebViewController *webVc = [[XWebViewController alloc] init];
    webVc.urlString = Request_cashRead;
    webVc.navigationItem.title = @"提现请阅";
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@"result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    if (request == _drawCashApi) {
        if (state == 1) {
            NSString *str = [[NSString alloc] UrlValueEncode:result[@"data"]];
            XGoldViewController *goldVc = [[XGoldViewController alloc] init];
            goldVc.navigationItem.title = @"提现";
            goldVc.params = [NSString stringWithFormat:@"json=%@", str];
            [self.navigationController pushViewController:goldVc animated:YES];
            _packetApi = [[XPacketApi alloc] initWithJson:result[@"data"]];
            [_packetApi start];
        } else {
            NSLog(@"result = %@", result[@"message"]);
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
    } else if (request == _bankCardApi) {
        if (state == 1) {
            _withdrawCashView.bankCardNum = result[@"data"][@"cardNo"];
            _withdrawCashView.iconName = result[@"data"][@"code"];
        } else {
            NSLog(@"result = %@", result[@"message"]);
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {

    if ([_balance floatValue] >= [textField.text floatValue] && [_withdrawCashView.withDrawMoneyTextField.text floatValue] > 2.00) {
        _withdrawCashView.drawCashAfterAmount =  [NSString stringWithFormat:@"%.2f", ([_balance floatValue] - [textField.text floatValue])];
    }
}

/**
 *  限制输入数字只能有两位小数
 *
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    NSInteger flag=0;
    const NSInteger limited = 2;
    for (int i = (int)futureString.length-1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
}

#pragma mark - XWithdrawCashViewDelegate 下一步
- (void)withdrawCashView:(XWithdrawCashView *)withdrawCashView didClickOfButton:(UIButton *)sneder {
    NSLog(@"下一步");
    if ([_withdrawCashView.withDrawMoneyTextField.text floatValue] > [_balance floatValue]) { // 提现金额大于可用余额
        [self showAlertViewWithTitle:@"温馨提示" message:@"提现金额不能大于可用余额" letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        return;
    } else if ([_withdrawCashView.withDrawMoneyTextField.text floatValue] < 2.00) {
        [self showAlertViewWithTitle:@"温馨提示" message:@"提现金额不能小于手续费" letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        return;
    } else {
        [self.drawCashApi start];
    }
}

#pragma mark - lazy
- (XWithdrawCashView *)withdrawCashView {
    if (!_withdrawCashView) {
        _withdrawCashView = [[XWithdrawCashView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _withdrawCashView.withdrawCashDelegate = self;
        _withdrawCashView.withDrawMoneyTextField.delegate = self;
        _withdrawCashView.balance = _balance0;
        _withdrawCashView.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return _withdrawCashView;
}

- (XDrawCashApi *)drawCashApi {
    NSString *money = [NSString stringWithFormat:@"%.0f", [_withdrawCashView.withDrawMoneyTextField.text floatValue] * 100];
    _drawCashApi = [[XDrawCashApi alloc] initWithToken:[UserManager User].token money:money client:@"1"];
    _drawCashApi.delegate = self;
    return _drawCashApi;
}

- (XGetBankCardApi *)bankCardApi {
    _bankCardApi = [[XGetBankCardApi alloc] initWithToken:[UserManager User].token];
    _bankCardApi.delegate = self;
    return _bankCardApi;
}

@end
