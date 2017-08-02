
//
//  XLoginViewController.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/14.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XLoginViewController.h"
#import "XLoginView.h"
#import "XRegisterViewController.h"
#import "XForgetPwdVC.h"
#import "XWebViewController.h"
#import "UIBarButtonItem+XExtension.h"
#import "XSanBiaoViewController.h"
#import "GestureViewController.h"
#import "XTabBarController.h"
#import "XRealNameVerifiVC.h"
#import "XGoldViewController.h"
//-------- 接口 ---------//
#import "XLoginApi.h"
#import "XGoldAccountApi.h"
#import "XPacketApi.h"
@interface XLoginViewController ()<UITextFieldDelegate,YTKRequestDelegate,CustomAlertViewDelegate>
@property(nonatomic,strong)XLoginView *loginView;
//登录API
@property(nonatomic,strong)XLoginApi *loginApi;
// 开通金账户请求信息api
@property (nonatomic, strong) XGoldAccountApi *goldAccountApi;
// 获取最新的用户信息api(发送给后台)
@property (nonatomic, strong) XPacketApi *packetApi;
//登录ip
@property(nonatomic,copy)NSString *loginIp;

@end

@implementation XLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"back_blue" selImageName:@"back_blue" target:self action:@selector(back)];
    //记住用户名
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:XRememberUserNameKey] isEqualToString:@""]){
        self.loginView.accountView.textField.text = [[NSUserDefaults standardUserDefaults]objectForKey:XRememberUserNameKey];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.hiddenLineView = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].blackColor}];
    [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];

    self.loginIp = [NSString getIPAddress:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - 返回按钮点击
- (void)back {
    if(self.isFromBackground){
        self.backBlock();
        return;
    }
    if(self.tabBarController.selectedIndex == 3){
        self.tabBarController.selectedIndex = 0;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 记住用户名点击事件
- (void)rememberClick {
    self.loginView.rememberBtn.selected = !self.loginView.rememberBtn.selected;
}

#pragma mark - 同意协议点击事件
- (void)agreeBtnClick {
    self.loginView.agreeProtocolBtn.selected = !self.loginView.agreeProtocolBtn.selected;
    if(!self.loginView.agreeProtocolBtn.selected){
        [self.loginView.loginBtn setBackgroundColor:[XAppContext appColors].lightGrayColor];
        self.loginView.loginBtn.enabled = NO;
    }else{
        self.loginView.loginBtn.enabled = YES;
        [self.loginView.loginBtn setBackgroundColor:[XAppContext appColors].blueColor];
    }
}

#pragma mark - 查看协议点击事件
- (void)protocolCheckClick {
    NSLog(@"查看资产家平台服务协议");
    XWebViewController *protocolVC = [[XWebViewController alloc]init];
    protocolVC.urlString = Request_Regist_ServiceProtocol;
    [self.navigationController pushViewController:protocolVC animated:YES];
}

#pragma mark - 登录按钮点击事件
- (void)loginBtnClick {
    NSLog(@"点击登录");
    [self.loginView.accountView.textField resignFirstResponder];
    [self.loginView.pwdView.textField resignFirstResponder];
    if([self.loginView.accountView.textField.text isEqualToString:@""]){
        NSLog(@"用户名不能为空");
        [self completeLoadWithTitle:@"用户名不能为空"];
        return;
    }
    if([self.loginView.pwdView.textField.text isEqualToString:@""]){
        NSLog(@"密码不能为空");
        [self completeLoadWithTitle:@"密码不能为空"];
        return;
    }
    [self.loginApi start];
}

#pragma mark - 忘记密码按钮点击事件
- (void)forgetBtnClick {
    NSLog(@"点击忘记密码");
    XForgetPwdVC *forgetPwdVC = [[XForgetPwdVC alloc]init];
    forgetPwdVC.title = @"重置登录密码";
    forgetPwdVC.resetOrChange = @"3";
    
    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}

#pragma mark - 立即注册按钮点击事件
- (void)registeBtnClick {
    NSLog(@"点击立即注册");
    XRegisterViewController *registVC = [[XRegisterViewController alloc]init];
    registVC.ifFromLoginVC = YES;
    [self.navigationController pushViewController:registVC animated:YES];
}

#pragma mark - UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 登录 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    //登录
    if (request == _loginApi) {
        if (state == 1) {
            //记住用户名
            if(self.loginView.rememberBtn.selected){
                [[NSUserDefaults standardUserDefaults]setObject:self.loginView.accountView.textField.text forKey:XRememberUserNameKey];
                [[NSUserDefaults standardUserDefaults]synchronize];
            } else {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:XRememberUserNameKey];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            [self showAlertViewWithTitle:@"登录成功！" message:@"现在开启您的赚钱之旅吧！" letfButtonTitle:@"嗯，我知道了" rightBtn:nil];
            //登录成功
            XUserModel *user = [XUserModel mj_objectWithKeyValues:result[@"data"][0]];
            [UserManager saveWithUser:user];
        } else if(state == 0) {
            [self completeLoadWithTitle:@"您输入的用户名或密码错误，请重新输入"];
        } else {
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
    //开通存管账户
    if (request == _goldAccountApi) {
        if (state == 1) {
            NSLog(@"%@", result[@"data"]);
            NSString *str = [[NSString alloc] UrlValueEncode:result[@"data"]];
            XGoldViewController *goldVc = [[XGoldViewController alloc] init];
            goldVc.isFromLogin = YES;
            goldVc.isFromBackground = self.isFromBackground;
            goldVc.navigationItem.title = @"存管账户";
            goldVc.params = [NSString stringWithFormat:@"json=%@", str];
            [self.navigationController pushViewController:goldVc animated:YES];
            _packetApi = [[XPacketApi alloc] initWithJson:result[@"data"]];
            [_packetApi start];
        } else {
            NSLog(@"%@", result[@"message"]);
            [self showAlertViewWithTitle:@"" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
    }

}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
}

- (void)clearRequest {

}

#pragma mark - CustomAlertViewDelegate
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        //1.如果实名认证了
        if([[UserManager User].nameChecked isEqualToString:@"1"]){
            //2.如果开通了存管账户
            if([[UserManager User].magicUser isEqualToString:@"1"]){
                //3.每次登录都会跳转到手势密码
                //点击“嗯，我知道了”
                GestureViewController *gestureVC = [[GestureViewController alloc]init];
                gestureVC.type = GestureViewControllerTypeSetting;
                gestureVC.isFromLogin = YES;
                [self.navigationController pushViewController:gestureVC animated:YES];
                __weak typeof(self) weakself = self;
                gestureVC.backBlock = ^{
                    if(weakself.isFromBackground){
                        [weakself dismissViewControllerAnimated:NO completion:nil];
                        XTabBarController *tabbarVC =  (XTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                        [tabbarVC.childViewControllers[0] popToRootViewControllerAnimated:NO];
                        [tabbarVC.childViewControllers[1] popToRootViewControllerAnimated:NO];
                        [tabbarVC.childViewControllers[2] popToRootViewControllerAnimated:NO];
                        [tabbarVC.childViewControllers[3] popToRootViewControllerAnimated:NO];
                        tabbarVC.selectedIndex = 0;
                    }else{
                        //如果是从首页右上角注册进来的，返回到首页
                        for (int i= 0 ; i<self.navigationController.viewControllers.count; i++) {
                            if([self.navigationController.viewControllers[i] isKindOfClass:[XRegisterViewController class]]){
                                [weakself.navigationController popToRootViewControllerAnimated:YES];
                                return ;
                            }else{
                                
                            }
                        }
                        //否则返回到“我”
                        weakself.tabBarController.selectedIndex = 3;
                        [weakself.navigationController popToRootViewControllerAnimated:YES];
                    }
                };
            }else{
                //2.如果没有开通存管账户，跳转到开通存管账户
                [self.goldAccountApi start];
                return;
            }
        }else{
            //1.如果没有实名认证-开通存管账户-设置手势密码
            NSLog(@"跳转到实名认证页面");
            XRealNameVerifiVC *realNameVerVC = [[XRealNameVerifiVC alloc]init];
            realNameVerVC.isFromBackground = self.isFromBackground;
            [self.navigationController pushViewController:realNameVerVC animated:YES];
            return;

        }
        
    }
}

#pragma mark - 懒加载
- (XLoginView *)loginView {
    if(!_loginView){
        _loginView = [[XLoginView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        _loginView.accountView.textField.delegate = self;
        _loginView.pwdView.textField.delegate = self;
        [_loginView.rememberBtn addTarget:self action:@selector(rememberClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.agreeProtocolBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.protocolBtn addTarget:self action:@selector(protocolCheckClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.forgetPwdBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.registBtn addTarget:self action:@selector(registeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginView;
}

- (XLoginApi *)loginApi {
    _loginApi = [[XLoginApi alloc]initWithuUserName:self.loginView.accountView.textField.text uPassword:self.loginView.pwdView.textField.text signUuid:@"" signCode:@"" modifyIp:self.loginIp origin:@"2" emailAddress:@""];
    _loginApi.delegate = self;
    return _loginApi;
}

- (XGoldAccountApi *)goldAccountApi {
    _goldAccountApi = [[XGoldAccountApi alloc] initWithToken:[UserManager User].token type:@"1" client:@"1"];
    _goldAccountApi.delegate = self;
    return _goldAccountApi;
}
@end
