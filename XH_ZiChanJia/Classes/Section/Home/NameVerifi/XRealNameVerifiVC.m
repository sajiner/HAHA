//
//  XRealNameVerifiVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRealNameVerifiVC.h"
#import "XIconAndTextFieldView.h"
#import "XTipsView.h"
#import "XRealNameVerifiSuccessVC.h"
#import "XRegisterViewController.h"
#import "XTabBarController.h"
#import "XHomeViewController.h"

//-------- 接口 ---------//
#import "XVerifiRealNameApi.h"
@interface XRealNameVerifiVC ()<UITextFieldDelegate,YTKRequestDelegate,CustomAlertViewDelegate>
//姓名
@property(nonatomic,strong)XIconAndTextFieldView *nameView;
//身份证号
@property(nonatomic,strong)XIconAndTextFieldView *idCardView;
//提交按钮
@property(nonatomic,strong)UIButton *commitBtn;
//客户资金...Label
@property(nonatomic,strong)UILabel *attentionLbl;
//温馨提示
@property(nonatomic,strong)XTipsView *tips;
//客服热线Label
@property(nonatomic,strong)UILabel *hotLine;
//电话Button
@property(nonatomic,strong)UIButton *hotBtn;
//实名认证API
@property(nonatomic,strong)XVerifiRealNameApi *verifiRealNameApi;

@end

@implementation XRealNameVerifiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    [self setupBackButton];
    [self setupSubViews];
    [self.tips setTitle:@"温馨提示" tipsContent:[XReminder sharedReminder].nameVerifi];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //如果已经验证，回显并按钮置灰不可点击
    if([[UserManager User].nameChecked isEqualToString:@"1"]){
        //如果已经实名认证过了
        for (int i = 0; i<[self.u_real_name length]; i++) {
            if(i != 0){
                self.u_real_name = [self.u_real_name stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        self.nameView.textField.text = self.u_real_name;
        self.idCardView.textField.text = [NSString stringWithFormat:@"%@***************",[self.u_id_number substringToIndex:3]];
        self.nameView.textField.textColor = [XAppContext appColors].grayBlackColor;
        self.idCardView.textField.textColor = [XAppContext appColors].grayBlackColor;
        self.nameView.textField.enabled = NO;
        self.idCardView.textField.enabled = NO;
        [self.commitBtn setBackgroundColor:[XAppContext appColors].lightGrayColor];
        self.commitBtn.enabled = NO;
        self.hotLine.hidden = NO;
        self.hotBtn.hidden = NO;
    }else{
        //如果没有认证
        self.nameView.textField.textColor = [UIColor blackColor];
        self.idCardView.textField.textColor = [UIColor blackColor];
        self.nameView.textField.enabled = YES;
        self.idCardView.textField.enabled = YES;
        [self.commitBtn setBackgroundColor:[XAppContext appColors].blueColor];
        self.commitBtn.enabled = YES;
        self.hotLine.hidden = YES;
        self.hotBtn.hidden = YES;
    }
}

#pragma mark - 设置返回按钮
- (void)setupBackButton {
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_blue"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarbuttonClick)];
    [self.navigationItem.leftBarButtonItem setTintColor:[XAppContext appColors].blueColor];
}

#pragma mark - 返回按钮点击事件
- (void)leftBarbuttonClick {
    if(self.isFromBackground){
        //如果从后台过来的
        [self dismissViewControllerAnimated:NO completion:nil];
        XTabBarController *tabbarVC =  (XTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [tabbarVC.childViewControllers[0] popToRootViewControllerAnimated:NO];
        [tabbarVC.childViewControllers[1] popToRootViewControllerAnimated:NO];
        [tabbarVC.childViewControllers[2] popToRootViewControllerAnimated:NO];
        [tabbarVC.childViewControllers[3] popToRootViewControllerAnimated:NO];
        tabbarVC.selectedIndex = 0;
        return;
    }
    for (int i = 0 ; i<self.navigationController.viewControllers.count; i++) {
        if([self.navigationController.viewControllers[i] isKindOfClass:[XRegisterViewController class]]){
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }
    }
    for (int i = 0 ; i<self.navigationController.viewControllers.count; i++) {
        if([self.navigationController.viewControllers[i] isKindOfClass:[XHomeViewController class]]){
            self.tabBarController.selectedIndex = 3;
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提交按钮点击事件
- (void)commitClick{
    NSLog(@"点击了提交");
    if([self.nameView.textField.text isEqualToString:@""]){
        NSLog(@"请输入姓名");
        [self completeLoadWithTitle:@"请输入姓名"];
        return;
    }
    if([self.idCardView.textField.text isEqualToString:@""]){
        NSLog(@"请输入身份证号");
        [self completeLoadWithTitle:@"请输入身份证号"];
        return;
    }
    [self.verifiRealNameApi start];
}

#pragma mark - UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 布局子控件
- (void)setupSubViews {
    //请输入您的姓名
    self.nameView = [[XIconAndTextFieldView alloc]init];
    self.nameView.textField.delegate = self;
    [self.nameView setupIconImg:@"username" placeHolder:@"请输入您的姓名"];
    [self.view addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(13);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //请输入18位身份证号码
    self.idCardView = [[XIconAndTextFieldView alloc]init];
    self.idCardView.textField.delegate = self;
    [self.idCardView setupIconImg:@"card_Id" placeHolder:@"请输入18位身份证号码"];
    [self.idCardView resetTopLineWithLeftMargin:52];
    [self.view addSubview:self.idCardView];
    [self.idCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //请输入18位身份证号码下面的Line
    UIView *idCardBottomLine = [[UIView alloc]init];
    idCardBottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.view addSubview:idCardBottomLine];
    [idCardBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    //提交按钮
    self.commitBtn = [[UIButton alloc]init];
    [self.commitBtn setBackgroundColor:[XAppContext appColors].blueColor];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    self.commitBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.commitBtn.layer.cornerRadius = 5;
    self.commitBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.commitBtn];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idCardBottomLine.mas_bottom).offset(22);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
    //客户资金...
    UILabel *attentionLbl = [[UILabel alloc]init];
    self.attentionLbl = attentionLbl;
    attentionLbl.text = @"客户资金由恒丰银行专业存管";
    attentionLbl.textColor = [XAppContext appColors].grayBlackColor;
    attentionLbl.font = [XAppContext appFonts].font_13;
    [self.view addSubview:attentionLbl];
    [attentionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commitBtn.mas_bottom).offset(11);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    //绿色icon
    UIImageView *greenIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bank_certify"]];
    greenIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:greenIcon];
    [greenIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(attentionLbl.mas_top);
        make.right.equalTo(attentionLbl.mas_left).offset(-5);
    }];
    self.tips = [[XTipsView alloc]init];
    [self.view addSubview:self.tips];
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.attentionLbl.mas_bottom).offset(60);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(self.tips.height));
    }];
    //400-015-8080
    UIButton *hotBtn = [[UIButton alloc]init];
    hotBtn.hidden = YES;
    self.hotBtn = hotBtn;
    NSMutableAttributedString * contentString = [[NSMutableAttributedString alloc] initWithString:@"400-015-8080"];
    NSRange contentRange = {0,[contentString length]};
    [contentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [contentString addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blueColor range:contentRange];
    [contentString addAttribute:NSFontAttributeName value:[XAppContext appFonts].font_13 range:contentRange];
    [hotBtn setAttributedTitle:contentString forState:UIControlStateNormal];
    [hotBtn addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hotBtn];
    [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.left.equalTo(self.view.mas_centerX).offset(-10);
    }];
    //客服热线
    UILabel *hotLine = [[UILabel alloc]init];
    hotLine.hidden = YES;
    self.hotLine = hotLine;
    hotLine.text = @"客服热线";
    hotLine.textColor = [XAppContext appColors].grayBlackColor;
    hotLine.font = [XAppContext appFonts].font_13;
    [self.view addSubview:hotLine];
    [hotLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hotBtn.mas_centerY);
        make.right.equalTo(hotBtn.mas_left).offset(-14);
    }];
}

#pragma mark - 拨打电话
- (void)callBtnClick{
    [self showAlertViewWithTitle:@"400-015-0808" message:@"周一至周五 9:00-21:00                     周六至周日 9:00-18:00" letfButtonTitle:@"拨打" rightBtn:@"取消"];
}

#pragma mark - 懒加载
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        [self completeLoadWithTitle:nil];
    }else{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-015-0808"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 实名认证 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    //发送短信验证码
    if (request == _verifiRealNameApi) {
        if (state == 1) {
            XUserModel *user = [UserManager User];
            user.nameChecked = @"1";
            [UserManager saveWithUser:user];
            //如果认证通过，跳转到成功界面
            XRealNameVerifiSuccessVC *successVC = [[XRealNameVerifiSuccessVC alloc]init];
            successVC.isFromBackground = self.isFromBackground;
            [self.navigationController pushViewController:successVC animated:YES];
        }else if(state == 0){
            [self completeLoadWithTitle:@"您输入的姓名或身份证号错误，请重新输入"];
        }else if(state == 123){
            if([result[@"data"][@"autherCount"]intValue] == 0){
                [self completeLoadWithTitle:@"您已超过认证次数，请联系人工客服处理，姓名格式错误"];
            }else{
                [self completeLoadWithTitle:[NSString stringWithFormat:@"认证失败，姓名格式错误，剩余%@次认证机会",result[@"data"][@"autherCount"]]];
            }
        }else if(state == 124){
            if([result[@"data"][@"autherCount"]intValue] == 0 ){
                [self completeLoadWithTitle:@"您已超过认证次数，请联系人工客服处理，身份证格式错误"];
            }else{
                [self completeLoadWithTitle:[NSString stringWithFormat:@"认证失败，身份证格式错误，剩余%@次认证机会",result[@"data"][@"autherCount"]]];
            }
        }else if(state == 128){
            if([result[@"data"][@"autherCount"]intValue] == 0){
                [self completeLoadWithTitle:@"您已超过认证次数，请联系人工客服处理，该身份证号信息已被占用"];
            }else{
                [self completeLoadWithTitle:[NSString stringWithFormat:@"认证失败，该身份证号信息已被占用，剩余%@次认证机会",result[@"data"][@"autherCount"]]];
            }
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
- (XVerifiRealNameApi *)verifiRealNameApi {
    _verifiRealNameApi = [[XVerifiRealNameApi alloc]initWithToken:[UserManager User].token realName:self.nameView.textField.text identity:self.idCardView.textField.text realNameSource:@"2"];
    _verifiRealNameApi.delegate = self;
    return _verifiRealNameApi;
}
@end
