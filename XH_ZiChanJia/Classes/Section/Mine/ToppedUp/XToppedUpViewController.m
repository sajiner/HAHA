//
//  XToppedUpViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XToppedUpViewController.h"
#import "XToppedUpView.h"
#import "XGetBankCardApi.h"
#import "XToppedUpApi.h"
#import "XGoldViewController.h"
#import "XPacketApi.h"
#import "XWebViewController.h"

@interface XToppedUpViewController ()<XToppedUpViewDelegate, YTKRequestDelegate, UITextFieldDelegate>

@property (nonatomic, strong) XToppedUpView *toppedUpView;
// 获取银行卡信息
@property (nonatomic, strong) XGetBankCardApi *bankCardApi;
// 充值api
@property (nonatomic, strong) XToppedUpApi *toppedUpApi;
// 获取最新的用户信息api(发送给后台)
@property (nonatomic, strong) XPacketApi *packetApi;

@end

@implementation XToppedUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉导航栏底部线
    self.navigationController.hiddenLineView = YES;
    // 右侧导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"充值请阅" style:UIBarButtonItemStylePlain target:self action:@selector(toppedUpNotice)];
    
    [self.view addSubview:self.toppedUpView];
    [self.bankCardApi start];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.toppedUpView endEditing:YES];
}

#pragma mark - 充值请阅
- (void)toppedUpNotice {
    XWebViewController *webVc = [[XWebViewController alloc] init];
    webVc.urlString = Request_chargeRead;
    webVc.navigationItem.title = @"充值请阅";
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@"result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    if (request == _toppedUpApi) {
        if (state == 1) {
            NSString *str = [[NSString alloc] UrlValueEncode:result[@"data"]];
            XGoldViewController *goldVc = [[XGoldViewController alloc] init];
            goldVc.navigationItem.title = @"充值";
            goldVc.params = [NSString stringWithFormat:@"json=%@", str];
            [self.navigationController pushViewController:goldVc animated:YES];
            _packetApi = [[XPacketApi alloc] initWithJson:result[@"data"]];
            _packetApi.delegate = self;
            [_packetApi start];
        } else {
            NSLog(@"result = %@", result[@"message"]);
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
    } else if (request == _bankCardApi) {
        if (state == 1) {
            _toppedUpView.bankCardNum = result[@"data"][@"cardNo"];
            _toppedUpView.iconName = result[@"data"][@"code"];
            
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

#pragma mark - XToppedUpViewDelegate 前往富友充值
- (void)toppedUpView:(XToppedUpView *)toppedUpView didClickOfButton:(UIButton *)sneder {
    NSLog(@"前往富友充值");
    if ([_toppedUpView.moneyAmount isEqualToString:@""]) {
        [self showAlertViewWithTitle:@"温馨提示" message:@"请输入充值金额" letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
    } else if ([_toppedUpView.moneyAmount doubleValue] > 50000) {
        [self showAlertViewWithTitle:@"温馨提示" message:@"快捷充值单笔最高5万元，如需更高金额请使用网银充值" letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
    } else {
        [self.toppedUpApi start];
    }
}

#pragma mark - lazy
- (XToppedUpView *)toppedUpView {
    if (!_toppedUpView) {
        _toppedUpView = [[XToppedUpView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _toppedUpView.toppedUpDelegate = self;
        _toppedUpView.balance = _balance;
        _toppedUpView.content.delegate = self;
        _toppedUpView.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return _toppedUpView;
}

- (XToppedUpApi *)toppedUpApi {
    NSString *money = [NSString stringWithFormat:@"%.0f", [_toppedUpView.moneyAmount floatValue] * 100];
    _toppedUpApi = [[XToppedUpApi alloc] initWithToken:[UserManager User].token money:money client:@"1"];
    _toppedUpApi.delegate = self;
    return _toppedUpApi;
}

- (XGetBankCardApi *)bankCardApi {
    _bankCardApi = [[XGetBankCardApi alloc] initWithToken:[UserManager User].token];
    _bankCardApi.delegate = self;
    return _bankCardApi;
}

@end
