//
//  XRegisterDetailVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRegisterDetailVC.h"
#import "XRegisterDetailView.h"
#import "XRegistSuccessVC.h"
//-------- 接口 ---------//
#import "XRegistApi.h"
@interface XRegisterDetailVC ()<UITextFieldDelegate,YTKRequestDelegate>
@property(nonatomic,strong)XRegisterDetailView *detailView;
//注册接口API
@property(nonatomic,strong)XRegistApi *registApi;
//本机ip
@property(nonatomic,copy)NSString *ipAddress;

@end

@implementation XRegisterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.detailView];
    [self.detailView.tips setTitle:@"温馨提示" tipsContent:[XReminder sharedReminder].registReminder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.ipAddress = [NSString getIPAddress:YES];
    NSLog(@"%@",self.ipAddress);
    //用户名初始化规则（ZCJ+手机号后四位+5位随机数字）
    NSString *tempPhone = [self.phoneNumber substringWithRange:NSMakeRange(7, 4)];
    NSString *strRandom = @"";
    for(int i=0; i<5; i++)
    {
        strRandom = [ strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    self.detailView.userNameView.textField.text = [NSString stringWithFormat:@"ZCJ%@%@",tempPhone,strRandom];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - 返回按钮点击事件
- (void)leftBackButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提交注册按钮点击事件
- (void)commitRegistClick {
    NSLog(@"点击了提交注册");
    if([self.detailView.userNameView.textField.text isEqualToString:@""]){
        NSLog(@"用户名不得为空");
        [self completeLoadWithTitle:@"用户名不得为空"];
        return;
    }
    if([self.detailView.passwordView.textField.text isEqualToString:@""]){
        NSLog(@"密码不得为空");
        [self completeLoadWithTitle:@"密码不得为空"];
        return;
    }
    if([self.detailView.userNameView.textField.text length] > 14 || [self.detailView.userNameView.textField.text length] < 6){
        [self completeLoadWithTitle:@"用户名长度为6-14位"];
        return;
    }
    if([XCommonUtils checkNumber:self.detailView.userNameView.textField.text]){
        [self completeLoadWithTitle:@"用户名不能为纯数字"];
        return;
    }
    [self showActivityViewWithTitle:@"请稍后..."];
    [self.registApi start];
}

#pragma mark - UITextField的代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField == self.detailView.userNameView.textField){
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 注册 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    //提交注册
    if (request == _registApi) {
        if (state == 1) {
            [self completeLoadWithTitle:nil];
            //跳转到注册成功界面，并保存token
            XUserModel *user = [[XUserModel alloc]init];
            user.token = [NSString stringWithFormat:@"%@",(result[@"token"] ? result[@"token"] : @"")];
            [UserManager saveWithUser:user];
            XRegistSuccessVC *registSuccessVC = [[XRegistSuccessVC alloc]init];
            registSuccessVC.ifFromLoginVC = self.ifFromLoginVC;
            [self.navigationController pushViewController:registSuccessVC animated:YES];
        }else{
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
    [self completeLoadWithTitle:nil];
}

- (void)clearRequest {
    
}

#pragma mark - 懒加载
- (XRegisterDetailView *)detailView {
    if(!_detailView){
        _detailView = [[XRegisterDetailView alloc]initWithFrame:self.view.bounds];
        _detailView.userNameView.textField.delegate = self;
        _detailView.passwordView.textField.delegate = self;
        [_detailView.leftBackButton addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_detailView.registBtn addTarget:self action:@selector(commitRegistClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailView;
}

- (XRegistApi *)registApi {
    _registApi = [[XRegistApi alloc]initWithUserName:self.detailView.userNameView.textField.text userPhone:self.phoneNumber password:self.detailView.passwordView.textField.text invitationCode:self.inviteCode signUuid:@"" signCode:@"" phoneCode:self.smsVerifiCode modifyIp:self.ipAddress origin:@"2"];
    _registApi.delegate = self;
    return _registApi;
}
@end
