//
//  XForgetDetailVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XForgetDetailVC.h"
#import "XIconAndTextFieldView.h"
#import "XForgetPwdSuccessVC.h"
#import "UIBarButtonItem+XExtension.h"
//-------- 接口 ---------//
#import "XResetPwdApi.h"
@interface XForgetDetailVC ()<UITextFieldDelegate,YTKRequestDelegate>
//navLine
@property(nonatomic,strong)UIView *navLine;
//请输入18位身份证号码
@property(nonatomic,strong)XIconAndTextFieldView *idCardView;
//请输入8-16位新登录密码
@property(nonatomic,strong)XIconAndTextFieldView *inputNewPwdView;
//请再次输入新登录密码
@property(nonatomic,strong)XIconAndTextFieldView *inputNewPwdAgainView;
//提交按钮
@property(nonatomic,strong)UIButton *commitBtn;
//bottomLine
@property(nonatomic,strong)UIView *bottomLine;
//是否实名认证
@property(nonatomic,assign)BOOL haveRealNameVerifi;
//修改ip
@property(nonatomic,copy)NSString *ipAddress;
//重置密码接口
@property(nonatomic,strong)XResetPwdApi *resetPwdApi;
  
@end

@implementation XForgetDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    [self setupNavBar];
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([[UserManager User].nameChecked isEqualToString:@"1"]){
        self.haveRealNameVerifi = YES;
    }else{
        self.haveRealNameVerifi = NO;
    }
}

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"back_blue" selImageName:@"back_blue" target:self action:@selector(backClick)];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提交按钮点击事件
- (void)commitBtnClick {
    NSLog(@"点击提交");
    if([[UserManager User].nameChecked isEqualToString:@"1"]){
        if([self.idCardView.textField.text isEqualToString:@""]){
            [self completeLoadWithTitle:@"请输入18位身份证号码"];
            return;
        }
    }
    if([self.inputNewPwdView.textField.text isEqualToString:@""]){
        [self completeLoadWithTitle:@"请输入8-16位新登录密码"];
        return;
    }
    if([self.inputNewPwdAgainView.textField.text isEqualToString:@""]){
        [self completeLoadWithTitle:@"请再次输入新登录密码"];
        return;
    }
    if(![self.inputNewPwdView.textField.text isEqualToString:self.inputNewPwdAgainView.textField.text]){
        [self completeLoadWithTitle:@"两次输入密码不一致"];
        return;
    }
    self.ipAddress = [NSString getIPAddress:YES];
    [self.resetPwdApi start];
}

#pragma mark - UITextField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 布局子控件
- (void)setupSubViews {
    //请输入18位身份证号码
    self.idCardView = [[XIconAndTextFieldView alloc]init];
    self.idCardView.textField.delegate = self;
    [self.idCardView setupIconImg:@"card_Id" placeHolder:@"请输入18位身份证号码"];
    [self.view addSubview:self.idCardView];
    [self.idCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(13);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //请输入8-16位新登录密码
    self.inputNewPwdView = [[XIconAndTextFieldView alloc]init];
    self.inputNewPwdView.textField.secureTextEntry = YES;
    [self.inputNewPwdView resetTopLineWithLeftMargin:52];
    self.inputNewPwdView.textField.delegate = self;
    [self.inputNewPwdView setupIconImg:@"password" placeHolder:@"请输入8-16位新登录密码"];
    [self.view addSubview:self.inputNewPwdView];
    [self.inputNewPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //请再次输入新登录密码
    self.inputNewPwdAgainView = [[XIconAndTextFieldView alloc]init];
    self.inputNewPwdAgainView.textField.secureTextEntry = YES;
    self.inputNewPwdAgainView.textField.delegate = self;
    [self.inputNewPwdAgainView setupIconImg:@"password" placeHolder:@"请再次输入新登录密码"];
    [self.inputNewPwdAgainView resetTopLineWithLeftMargin:52];
    [self.view addSubview:self.inputNewPwdAgainView];
    [self.inputNewPwdAgainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputNewPwdView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //请再次输入新登录密码下面的line
    UIView *bottomLine = [[UIView alloc]init];
    self.bottomLine = bottomLine;
    bottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputNewPwdAgainView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    //提交按钮
    self.commitBtn = [[UIButton alloc]init];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn setBackgroundColor:[XAppContext appColors].blueColor];
    self.commitBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.commitBtn.layer.cornerRadius = 5;
    self.commitBtn.layer.masksToBounds = YES;
    [self.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).offset(22);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
}

#pragma mark - set方法
- (void)setHaveRealNameVerifi:(BOOL)haveRealNameVerifi {
    _haveRealNameVerifi= haveRealNameVerifi;
    if(haveRealNameVerifi){
        self.idCardView.hidden = NO;
        [self.inputNewPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idCardView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@44);
        }];
        [self.inputNewPwdView resetTopLineWithLeftMargin:52];
        [self.bottomLine updateConstraints];
    }else{
        self.idCardView.hidden = YES;
        [self.inputNewPwdView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(13);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@44);
        }];
        [self.inputNewPwdView resetTopLineWithLeftMargin:0];
        [self.bottomLine updateConstraints];
    }
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 重置密码 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    //忘记密码
    if (request == _resetPwdApi) {
        if (state == 1) {
            //修改成功
            XForgetPwdSuccessVC *forgetSuccessVC = [[XForgetPwdSuccessVC alloc]init];
            switch ([self.resetOrChange intValue]) {
                case 1:
                    forgetSuccessVC.title = @"修改登录密码";
                    break;
                case 2:
                    forgetSuccessVC.title = @"重置登录密码";
                    break;
                default:
                    break;
            }
            [self.navigationController pushViewController:forgetSuccessVC animated:YES];
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
- (XResetPwdApi *)resetPwdApi {
    _resetPwdApi = [[XResetPwdApi alloc]initWithPhone:self.phoneNumber password:self.inputNewPwdAgainView.textField.text identity:self.idCardView.textField.text origin:@"2" modifyIp:self.ipAddress phoneCode:self.smsCode type:self.resetOrChange realName:self.realName];
    _resetPwdApi.delegate = self;
    return _resetPwdApi;
}


@end
