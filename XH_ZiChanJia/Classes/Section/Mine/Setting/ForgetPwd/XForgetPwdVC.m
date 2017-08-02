//
//  XForgetPwdVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XForgetPwdVC.h"
#import "XIconAndTextFieldView.h"
#import "XCommonUtils.h"
#import "XForgetDetailVC.h"
#import "UIBarButtonItem+XExtension.h"
//-------- 接口 ---------//
#import "XResetPwdSendSmsCodeApi.h"
#import "XResetPWdVerifiSmsCodeApi.h"
@interface XForgetPwdVC ()<UITextFieldDelegate,YTKRequestDelegate>
//请输入11位手机号码
@property(nonatomic,strong)XIconAndTextFieldView *phoneView;
//请输入短信验证码
@property(nonatomic,strong)XIconAndTextFieldView *smsCodeView;
//免费获取按钮
@property(nonatomic,strong)UIButton *getVerifiCodeBtn;
//“收不到短信”label
@property(nonatomic,strong)UILabel *cantReceiveSmsLabel;
//“试试语音验证码”uibutton
@property(nonatomic,strong)UIButton *tryVoiceCodeBtn;
//电话拨打中...UILabel
@property(nonatomic,strong)UILabel *callingLabel;
//下一步按钮
@property(nonatomic,strong)UIButton *nextStepBtn;
//短信验证码的计时器
@property(nonatomic,strong)NSTimer *timer;
//60s
@property(nonatomic,assign)NSInteger second;

//给指定手机号发送手机验证码API
@property(nonatomic,strong)XResetPwdSendSmsCodeApi *sendSmsCodeApi;
//验证短信验证码
@property(nonatomic,strong)XResetPWdVerifiSmsCodeApi *verifiSmsCodeApi;

@end

@implementation XForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.second = 60;
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    [self setupNavBar];
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"back_blue" selImageName:@"back_blue" target:self action:@selector(backClick)];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 免费获取按钮点击事件
- (void)getSmsCodeClick {
    NSLog(@"点击了免费获取");
    if([self.phoneView.textField.text isEqualToString: @""]){
        NSLog(@"请输入手机号");
        [self completeLoadWithTitle:@"请输入手机号"];
        return;
    }
    [self.sendSmsCodeApi start];
}

#pragma mark - 试试语音验证码点击事件
- (void)tryVoiceBtnClick {
    NSLog(@"点击了试试语音验证码");
    [self completeLoadWithTitle:@"语音验证码功能暂时不可用"];
    return ;
    if([self.phoneView.textField.text isEqualToString: @""]){
        NSLog(@"请输入手机号");
    }else if(![XCommonUtils checkTel:self.phoneView.textField.text]){
        NSLog(@"请输入11位有效手机号码");
    }else{
        //TODO:调接口判断手机号唯一性和获取验证码
        NSLog(@"调用语音验证码");
        //如果手机号没有注册过，则拨打电话
        if(1){
            self.cantReceiveSmsLabel.hidden = YES;
            self.tryVoiceCodeBtn.hidden = YES;
            self.callingLabel.hidden = NO;
            //这个电话号码可以从后台获取，也可以写死
            NSString *tempStr = [NSString stringWithFormat:@"电话拨打中...请接听来自400-015-0808的电话..."];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:tempStr];
            [str addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blueColor range:NSMakeRange(13, 12)];
            [str addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blackColor range:NSMakeRange(0, 13)];
            [str addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blackColor range:NSMakeRange(25, 6)];
            self.callingLabel.attributedText = str;
        }
    }
}

#pragma mark - 下一步点击事件
- (void)nextStepBtnClick {
    NSLog(@"下一步");
    if([self.phoneView.textField.text isEqualToString:@""]){
        NSLog(@"请输入手机号");
        [self completeLoadWithTitle:@"请输入手机号"];
        return;
    }
    if([self.smsCodeView.textField.text isEqualToString:@""]){
        NSLog(@"请输入短信验证码");
        [self completeLoadWithTitle:@"请输入短信验证码"];
        return;
    }
    [self.verifiSmsCodeApi start];
}

#pragma mark - UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 验证码倒计时
- (void)smsVerifiCountDown {
    self.getVerifiCodeBtn.enabled = NO;
    [self.getVerifiCodeBtn setTitle:[NSString stringWithFormat:@"%lds",self.second] forState:UIControlStateNormal];
    [self.getVerifiCodeBtn setTitleColor:[XAppContext appColors].grayBlackColor forState:UIControlStateNormal];
    if (self.second == 0) {
        self.getVerifiCodeBtn.enabled = YES;
        [self.self.getVerifiCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.self.getVerifiCodeBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
        self.getVerifiCodeBtn.enabled = YES;
        //        self.voicesBtn.enabled = YES;
        [_timer invalidate];
        self.second = 60;
    }
    self.second--;
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 重置密码 result = %@", result);
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
    //验证短信验证码
    if (request == _verifiSmsCodeApi) {
        if (state == 1) {
            //验证码通过，并且已实名认证
            XUserModel *user = [[XUserModel alloc]init];
            user.nameChecked = @"1";
            [UserManager saveWithUser:user];
            //短信验证码通过
            XForgetDetailVC *forgetDetailVC = [[XForgetDetailVC alloc]init];
            forgetDetailVC.realName = [NSString stringWithFormat:@"%@",result[@"data"]];
            switch ([self.resetOrChange intValue]) {
                case 2:
                    forgetDetailVC.title = @"修改登录密码";
                    forgetDetailVC.resetOrChange = @"1";
                    break;
                case 3:
                    forgetDetailVC.title = @"重置登录密码";
                    forgetDetailVC.resetOrChange = @"2";
                    break;
                default:
                    break;
            }
            forgetDetailVC.phoneNumber = self.phoneView.textField.text;
            forgetDetailVC.smsCode = self.smsCodeView.textField.text;
            [self.navigationController pushViewController:forgetDetailVC animated:YES];
        }else if(state == 0){
            //验证码通过，但是没有实名认证
            XUserModel *user = [[XUserModel alloc]init];
            user.nameChecked = @"0";
            [UserManager saveWithUser:user];
            //短信验证码通过
            XForgetDetailVC *forgetDetailVC = [[XForgetDetailVC alloc]init];
            forgetDetailVC.realName = @"";
            switch ([self.resetOrChange intValue]) {
                case 2:
                    forgetDetailVC.title = @"修改登录密码";
                    forgetDetailVC.resetOrChange = @"1";
                    break;
                case 3:
                    forgetDetailVC.title = @"重置登录密码";
                    forgetDetailVC.resetOrChange = @"2";
                    break;
                default:
                    break;
            }
            forgetDetailVC.phoneNumber = self.phoneView.textField.text;
            forgetDetailVC.smsCode = self.smsCodeView.textField.text;
            [self.navigationController pushViewController:forgetDetailVC animated:YES];
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

#pragma mark - 布局子控件
- (void)setupSubViews {
    //请输入11位手机号码
    self.phoneView = [[XIconAndTextFieldView alloc]init];
    self.phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneView.textField.delegate = self;
    [self.phoneView setupIconImg:@"phoneNumber" placeHolder:@"请输入11位手机号码"];
    [self.view addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(13);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //请输入短信验证码
    self.smsCodeView = [[XIconAndTextFieldView alloc]init];
    self.smsCodeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.smsCodeView.textField.delegate = self;
    [self.smsCodeView setupIconImg:@"messageCode" placeHolder:@"请输入短信验证码"];
    [self.smsCodeView resetTopLineWithLeftMargin:52];
    [self.view addSubview:self.smsCodeView];
    [self.smsCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //竖线
    UIView *verticalLine = [[UIView alloc]init];
    verticalLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.smsCodeView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smsCodeView.mas_top).offset(10);
        make.bottom.equalTo(self.smsCodeView.mas_bottom).offset(-10);
        make.right.equalTo(self.smsCodeView.mas_right).offset(-90);
        make.width.equalTo(@1);
    }];
    //免费获取
    self.getVerifiCodeBtn = [[UIButton alloc]init];
    [self.getVerifiCodeBtn setTitle:@"免费获取" forState:UIControlStateNormal];
    [self.getVerifiCodeBtn addTarget:self action:@selector(getSmsCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.getVerifiCodeBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    self.getVerifiCodeBtn.titleLabel.font = [XAppContext appFonts].font_15;
    [self.smsCodeView addSubview:self.getVerifiCodeBtn];
    [self.getVerifiCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.smsCodeView.mas_centerY);
        make.right.equalTo(self.smsCodeView.mas_right).offset(-13);
        make.left.equalTo(verticalLine.mas_right).offset(13);
    }];

    //请输入18位身份证号码下面的Line
    UIView *idCardBottomLine = [[UIView alloc]init];
    idCardBottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.view addSubview:idCardBottomLine];
    [idCardBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smsCodeView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    //试试语音验证码
    self.tryVoiceCodeBtn = [[UIButton alloc]init];
    [self.tryVoiceCodeBtn setTitle:@"试试语音验证码" forState:UIControlStateNormal];
    [self.tryVoiceCodeBtn setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    [self.tryVoiceCodeBtn addTarget:self action:@selector(tryVoiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tryVoiceCodeBtn.titleLabel.font = [XAppContext appFonts].font_13;
    [self.view addSubview:self.tryVoiceCodeBtn];
    [self.tryVoiceCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idCardBottomLine.mas_bottom).offset(11.5);
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];
    //收不到短信Label
    self.cantReceiveSmsLabel = [[UILabel alloc]init];
    self.cantReceiveSmsLabel.text = @"收不到短信？";
    self.cantReceiveSmsLabel.textColor = [XAppContext appColors].grayBlackColor;
    self.cantReceiveSmsLabel.font = [XAppContext appFonts].font_13;
    [self.view addSubview:self.cantReceiveSmsLabel];
    [self.cantReceiveSmsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tryVoiceCodeBtn.mas_centerY);
        make.right.equalTo(self.tryVoiceCodeBtn.mas_left);
    }];
    //电话拨打中...Label
    self.callingLabel = [[UILabel alloc]init];
    self.callingLabel.hidden = YES;
    self.callingLabel.font = [XAppContext appFonts].font_13;
    [self.view addSubview:self.callingLabel];
    [self.callingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.centerY.equalTo(self.tryVoiceCodeBtn.mas_centerY);
    }];
    //下一步按钮
    self.nextStepBtn = [[UIButton alloc]init];
    [self.nextStepBtn setBackgroundColor:[XAppContext appColors].blueColor];
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.nextStepBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.nextStepBtn.layer.cornerRadius = 5;
    self.nextStepBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tryVoiceCodeBtn.mas_bottom).offset(34);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
}

#pragma mark - 懒加载
- (XResetPwdSendSmsCodeApi *)sendSmsCodeApi {
    _sendSmsCodeApi = [[XResetPwdSendSmsCodeApi alloc]initWithType:self.resetOrChange phone:self.phoneView.textField.text uuid:@"" signCode:@""];
    _sendSmsCodeApi.delegate = self;
    return _sendSmsCodeApi;
}

- (XResetPWdVerifiSmsCodeApi *)verifiSmsCodeApi {
    _verifiSmsCodeApi = [[XResetPWdVerifiSmsCodeApi alloc]initWithPhone:self.phoneView.textField.text signUuid:@"" signCode:@"" phoneCode:self.smsCodeView.textField.text];
    _verifiSmsCodeApi.delegate = self;
    return _verifiSmsCodeApi;
}
@end
