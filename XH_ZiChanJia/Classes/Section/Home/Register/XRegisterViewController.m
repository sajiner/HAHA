//
//  XRegisterViewController.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRegisterViewController.h"
#import "XRegisterView.h"
#import "XCommonUtils.h"
#import "XRegisterDetailVC.h"
#import "XLoginViewController.h"
#import "XWebViewController.h"
#import "UIBarButtonItem+XExtension.h"
//-------- 接口 ---------//
#import "XSendSMSCodeApi.h"
#import "XVerifiSmsCodeApi.h"
#import "XSendVoiceCodeApi.h"
#import "XVerifiInviteCodeApi.h"
@interface XRegisterViewController ()<UITextFieldDelegate,YTKRequestDelegate>
@property(nonatomic,strong)XRegisterView *registerView;
//短信验证码的计时器
@property(nonatomic,strong)NSTimer *timer;
//60s倒计时时间
@property(nonatomic,assign)NSInteger second;
//是否有邀请码
@property(nonatomic,assign)BOOL haveInviteCode;
//发送短信验证码的API
@property(nonatomic,strong)XSendSMSCodeApi *sendSmsCodeApi;
//给手机发送语音验证码的API
@property(nonatomic,strong)XSendVoiceCodeApi *sendVoiceCodeApi;
//验短信验证码的API
@property(nonatomic,strong)XVerifiSmsCodeApi *verifiSmsCodeApi;
//验证邀请码API
@property(nonatomic,strong)XVerifiInviteCodeApi *verifiInviteApi;
//验证手机号
//@property(nonatomic,strong)XVerifiPhone *verifiPhoneApi;

@end

@implementation XRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.second = 60;
    self.haveInviteCode = NO;
    [self setupNavBar];
    [self.view addSubview:self.registerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.hiddenLineView = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"back_blue" selImageName:@"back_blue" target:self action:@selector(backClick)];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 免费获取按钮点击事件
- (void)getVerifiCodeClick {
    NSLog(@"点击了免费获取");
    [self.registerView.phoneNumberView.textField resignFirstResponder];
    [self.registerView.smsVerfiCodeView.textField resignFirstResponder];
    if([self.registerView.phoneNumberView.textField.text isEqual:@""]){
        [self completeLoadWithTitle:@"请输入手机号"];
        return;
    }
    //调接口判断手机号唯一性和获取验证码
    [self.sendSmsCodeApi start];
}

#pragma mark - 验证码倒计时
- (void)smsVerifiCountDown {
    self.registerView.getVerifiCodeBtn.enabled = NO;
    [self.registerView.getVerifiCodeBtn setTitle:[NSString stringWithFormat:@"%lds",self.second] forState:UIControlStateNormal];
    [self.registerView.getVerifiCodeBtn setTitleColor:[XAppContext appColors].grayBlackColor forState:UIControlStateNormal];
    if (self.second == 0) {
        self.registerView.getVerifiCodeBtn.enabled = YES;
        [self.self.registerView.getVerifiCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.self.registerView.getVerifiCodeBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
        self.self.registerView.getVerifiCodeBtn.enabled = YES;
//        self.voicesBtn.enabled = YES;
        [_timer invalidate];
        self.second = 60;
    }
    self.second--;
}

#pragma mark - 试试语音验证码点击事件
- (void)getVoiceCodeClick {
    NSLog(@"调用语音验证码");
    [self completeLoadWithTitle:@"语音验证码功能暂时不可用"];
    return ;
    //如果手机号没有注册过，则拨打电话
    [self.sendVoiceCodeApi start];
}

#pragma mark - 我有邀请码按钮点击事件
- (void)haveInviteCodeClick {
    self.haveInviteCode = !self.haveInviteCode;
    if(self.haveInviteCode){
        self.registerView.arrowImg.transform = CGAffineTransformMakeRotation(M_PI);
        self.registerView.inputInviteView.hidden = NO;
        self.registerView.haveCodeBottomLine.hidden = NO;
        [self.registerView.bottomContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.registerView.inputInviteView.mas_bottom);
            make.left.right.equalTo(self.registerView);
            make.height.equalTo(@140);
        }];
        [self.registerView.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            if(ScreenWidth == 320){
                make.bottom.equalTo(self.registerView.mas_bottom).offset(-10);
            }else{
                make.bottom.equalTo(self.registerView.mas_bottom).offset(-30);
            }
            make.centerX.equalTo(self.registerView.mas_centerX);
        }];
    }else{
        self.registerView.arrowImg.transform = CGAffineTransformIdentity;
        self.registerView.inputInviteView.hidden = YES;
        self.registerView.haveCodeBottomLine.hidden = YES;
        [self.registerView.bottomContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.registerView.haveCodeBottomLine.mas_bottom);
            make.left.right.equalTo(self.registerView);
            make.height.equalTo(@140);
        }];
        [self.registerView.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.registerView.mas_bottom).offset(-30);
            make.centerX.equalTo(self.registerView.mas_centerX);
        }];
    }
}

#pragma mark - 服务协议按钮点击事件
- (void)protocolBtnClick {
    NSLog(@"点击了服务协议");
    XWebViewController *protocolVC = [[XWebViewController alloc]init];
    protocolVC.urlString = Request_Regist_ServiceProtocol;
    [self.navigationController pushViewController:protocolVC animated:YES];
}

#pragma mark - 立即注册按钮点击事件
- (void)registerBtnClick {
    NSLog(@"点击了立即注册");
    if([self.registerView.phoneNumberView.textField.text isEqual:@""]){
        [self completeLoadWithTitle:@"请输入手机号"];
        return;
    }
    if([self.registerView.smsVerfiCodeView.textField.text isEqual:@""]){
        [self completeLoadWithTitle:@"请输入短信验证码"];
        return;
    }
    [self.verifiSmsCodeApi start];
}

#pragma mark - 立即登录按钮点击事件
- (void)loginBtnClick {
    NSLog(@"点击了立即登录");
    if(self.ifFromLoginVC){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        XLoginViewController *loginVC = [[XLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

#pragma mark - UITextField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 注册 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    
    //发送短信验证码
    if (request == _sendSmsCodeApi) {
        if (state == 1) {
            //手机号验证通过，给手机发送短信验证码
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(smsVerifiCountDown) userInfo:nil repeats:YES];
        }else{
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
    //TODO:语音验证码暂时不能用
    if (request == _sendVoiceCodeApi) {
        if (state == 1) {
            self.registerView.cantReceiveLabel.hidden = YES;
            self.registerView.voiceVerifiBtn.hidden = YES;
            self.registerView.callingLabel.hidden = NO;
            NSString *tempStr = [NSString stringWithFormat:@"电话拨打中...请接听来自400-015-0808的电话..."];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:tempStr];
            [str addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blueColor range:NSMakeRange(13, 12)];
            [str addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blackColor range:NSMakeRange(0, 13)];
            [str addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blackColor range:NSMakeRange(25, 6)];
            self.registerView.callingLabel.attributedText = str;
        }else{
            //弹框提示错误信息
            NSLog(@"%@",(result[@"message"] ? result[@"message"] : @""));
        }
    }
    //验证短信验证码
    if (request == _verifiSmsCodeApi) {
        if (state == 1) {
            //如果输入了邀请码，需要验证邀请码
            if(![self.registerView.inputInviteView.textField.text isEqualToString:@""]){
                //如果输入了邀请码，需要验证邀请码
                [self.verifiInviteApi start];
            }else{
                XRegisterDetailVC *detailVC = [[XRegisterDetailVC alloc]init];
                detailVC.ifFromLoginVC = self.ifFromLoginVC;
                detailVC.phoneNumber = self.registerView.phoneNumberView.textField.text;
                detailVC.smsVerifiCode = self.registerView.smsVerfiCodeView.textField.text;
                detailVC.inviteCode = self.registerView.inputInviteView.textField.text;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }else{
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
    //验证邀请码
    if (request == _verifiInviteApi) {
        if (state == 1) {
            //邀请码验证通过后跳转
            XRegisterDetailVC *detailVC = [[XRegisterDetailVC alloc]init];
            detailVC.phoneNumber = self.registerView.phoneNumberView.textField.text;
            detailVC.smsVerifiCode = self.registerView.smsVerfiCodeView.textField.text;
            detailVC.inviteCode = self.registerView.inputInviteView.textField.text;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else{
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
}

- (void)clearRequest {

}

#pragma mark - 懒加载
- (XRegisterView *)registerView {
    if(!_registerView){
        _registerView = [[XRegisterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
        _registerView.phoneNumberView.textField.delegate = self;
        _registerView.smsVerfiCodeView.textField.delegate = self;
        _registerView.inputInviteView.textField.delegate = self;
        [_registerView.getVerifiCodeBtn addTarget:self action:@selector(getVerifiCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.voiceVerifiBtn addTarget:self action:@selector(getVoiceCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.haveInviteCodeBtn addTarget:self action:@selector(haveInviteCodeClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerView;
}
//发送短信验证码
- (XSendSMSCodeApi *)sendSmsCodeApi {
    //此处不能用懒加载
    _sendSmsCodeApi = [[XSendSMSCodeApi alloc]initWithType:@"1" phone:self.registerView.phoneNumberView.textField.text uuid:@"" signCode:@""];
    _sendSmsCodeApi.delegate = self;
    return _sendSmsCodeApi;
}
//发送语音验证码
- (XSendVoiceCodeApi *)sendVoiceCodeApi {
    //此处不能用懒加载
    _sendVoiceCodeApi = [[XSendVoiceCodeApi alloc]initWithPhone:self.registerView.phoneNumberView.textField.text uuid:@"" signCode:@""];
    _sendVoiceCodeApi.delegate = self;
    return _sendVoiceCodeApi;
}
//验证短信验证码
- (XVerifiSmsCodeApi *)verifiSmsCodeApi {
    //此处不能用懒加载
    _verifiSmsCodeApi = [[XVerifiSmsCodeApi alloc]initWithPhone:self.registerView.phoneNumberView.textField.text phoneCode:self.registerView.smsVerfiCodeView.textField.text];
    _verifiSmsCodeApi.delegate = self;
    return _verifiSmsCodeApi;
}
//发送邀请码
- (XVerifiInviteCodeApi *)verifiInviteApi{
    //此处不能用懒加载
    _verifiInviteApi = [[XVerifiInviteCodeApi alloc]initWithInvitedCode:self.registerView.inputInviteView.textField.text];
    _verifiInviteApi.delegate = self;
    return _verifiInviteApi;
}
////验证手机号
//- (XVerifiPhone *)verifiPhoneApi {
//    _verifiPhoneApi = [[XVerifiPhone alloc]initWithPhone:self.registerView.phoneNumberView.textField.text];
//    _verifiPhoneApi.delegate = self;
//    return _verifiPhoneApi;
//}
@end
