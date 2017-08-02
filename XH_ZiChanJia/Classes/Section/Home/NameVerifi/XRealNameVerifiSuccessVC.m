//
//  XRealNameVerifiSuccessVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRealNameVerifiSuccessVC.h"
#import "XGoldViewController.h"
#import "XTabBarController.h"
#import "XHomeViewController.h"
#import "XRegisterViewController.h"
//-------- 接口 ---------//
#import "XGoldAccountApi.h"
#import "XPacketApi.h"
@interface XRealNameVerifiSuccessVC ()<YTKRequestDelegate>
//开通存管账户按钮
@property(nonatomic,strong)UIButton *openAccountBtn;
// 开通金账户请求信息api
@property (nonatomic, strong) XGoldAccountApi *goldAccountApi;
// 获取最新的用户信息api(发送给后台)
@property (nonatomic, strong) XPacketApi *packetApi;
@end

@implementation XRealNameVerifiSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    [self setupBackButton];
    [self setupSubViews];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 开通存管账户点击事件
- (void)openAccountClick {
    NSLog(@"开通存管账户");
    [self.goldAccountApi start];
}

- (void)setupSubViews {
    //对号图片
    UIImageView *successImgView = [[UIImageView alloc]init];
    successImgView.image = [UIImage imageNamed:@"success"];
    [self.view addSubview:successImgView];
    [successImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(60);
    }];
    //文字
    UILabel *successLabel = [[UILabel alloc]init];
    successLabel.text = @"恭喜您，实名认证成功!";
    successLabel.textColor = [XAppContext appColors].blackColor;
    successLabel.font = [XAppContext appFonts].font_22;
    [self.view addSubview:successLabel];
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(successImgView.mas_bottom).offset(22);
    }];
    //推荐您...Label
    UILabel *attLabel = [[UILabel alloc]init];
    attLabel.text = @"推荐您继续操作完成资金存管开户";
    attLabel.textColor = [XAppContext appColors].grayBlackColor;
    attLabel.font = [XAppContext appFonts].font_17;
    [self.view addSubview:attLabel];
    [attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(successLabel.mas_bottom).offset(18);
    }];
    //开通存管账户按钮
    self.openAccountBtn = [[UIButton alloc]init];
    [self.openAccountBtn setBackgroundColor:[XAppContext appColors].blueColor];
    [self.openAccountBtn setTitle:@"开通存管账户" forState:UIControlStateNormal];
    [self.openAccountBtn addTarget:self action:@selector(openAccountClick) forControlEvents:UIControlEventTouchUpInside];
    self.openAccountBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.openAccountBtn.layer.cornerRadius = 5;
    self.openAccountBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.openAccountBtn];
    [self.openAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(attLabel.mas_bottom).offset(48);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 开通存管账户 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    //开通存管账户
    if (request == _goldAccountApi) {
        if (state == 1) {
            NSLog(@"%@", result[@"data"]);
            NSString *str = [[NSString alloc] UrlValueEncode:result[@"data"]];
            XGoldViewController *goldVc = [[XGoldViewController alloc] init];
            goldVc.isFromNameVerifi = YES;
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

- (XGoldAccountApi *)goldAccountApi {
    _goldAccountApi = [[XGoldAccountApi alloc] initWithToken:[UserManager User].token type:@"1" client:@"1"];
    _goldAccountApi.delegate = self;
    return _goldAccountApi;
}
@end
