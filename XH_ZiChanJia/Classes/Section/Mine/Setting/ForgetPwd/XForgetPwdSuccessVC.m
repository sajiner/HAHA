//
//  XForgetPwdSuccessVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XForgetPwdSuccessVC.h"
#import "XLoginViewController.h"
#import "XMineViewController.h"
#import "XNavigationController.h"
@interface XForgetPwdSuccessVC ()
//3秒后自动...subLabel2
@property(nonatomic,strong)UILabel *subLabel2;
//定时器
@property(nonatomic,strong)NSTimer *timer;
//记录三秒
@property(nonatomic,assign)NSInteger second;
@end

@implementation XForgetPwdSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.second = 2;
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    [self setupLeftBackButton];
    [self setupSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRepeat) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 设置返回按钮
- (void)setupLeftBackButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBackButtonClick)];
    self.navigationItem.leftBarButtonItem.tintColor = [XAppContext appColors].blueColor;
}

#pragma mark - 返回
- (void)leftBackButtonClick {
    [UserManager clearUser];
    if([self.title isEqualToString:@"修改登录密码"]){
        XLoginViewController *loginVC = [[XLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else if([self.title isEqualToString:@"重置登录密码"]){
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if([viewController isKindOfClass:[XLoginViewController class]]){
                [self.navigationController popToViewController:viewController animated:YES];
            }
        }
    }
}

#pragma mark - 定时器方法
- (void)timeRepeat {
    if(self.second >= 0){
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld秒后自动为您跳转到登录页",self.second]];
        [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].blueColor} range:NSMakeRange(0, 2)];
        [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor} range:NSMakeRange(2, 11)];
        self.subLabel2.attributedText = attr;
        self.second --;
    }else{
        NSLog(@"跳转到登录界面");
        [UserManager clearUser];
        [self leftBackButtonClick];
        [self.timer invalidate];
        self.timer = nil;
    }
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
    successLabel.text = @"恭喜您，登录密码重置成功!";
    successLabel.textColor = [XAppContext appColors].blackColor;
    successLabel.font = [XAppContext appFonts].font_22;
    [self.view addSubview:successLabel];
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(successImgView.mas_bottom).offset(22);
    }];
    //立即登录，开启...
    UILabel *subLabel1 = [[UILabel alloc]init];
    subLabel1.text = @"立即登录，开启您的赚钱之旅吧！";
    subLabel1.textColor = [XAppContext appColors].grayBlackColor;
    subLabel1.font = [XAppContext appFonts].font_17;
    [self.view addSubview:subLabel1];
    [subLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successLabel.mas_bottom).offset(62);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    //3秒后...
    self.subLabel2 = [[UILabel alloc]init];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"3秒后自动为您跳转到登录页"];
    [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].blueColor} range:NSMakeRange(0, 2)];
    [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor} range:NSMakeRange(2, 11)];
    self.subLabel2.attributedText = attr;
    self.subLabel2.font = [XAppContext appFonts].font_17;
    [self.view addSubview:self.subLabel2];
    [self.subLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subLabel1.mas_bottom).offset(13);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}
@end
