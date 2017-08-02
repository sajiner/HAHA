//
//  XRegistSuccessVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRegistSuccessVC.h"
#import "XRealNameVerifiVC.h"
@interface XRegistSuccessVC ()
//你还未进行...Label
@property(nonatomic,strong)UILabel *attLabel2;
//定时器
@property(nonatomic,strong)NSTimer *timer;
//记录三秒
@property(nonatomic,assign)NSInteger second;
//实名认证按钮
@property(nonatomic,strong)UIButton *verifiBtn;

@end

@implementation XRegistSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    self.second = 2;
    [self setupBackButton];
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRepeat) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 定时器方法
- (void)timeRepeat {
    if(self.second >= 0){
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"你还未进行实名认证，%ld秒后引导您实名认证",self.second]];
        [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].blueColor} range:NSMakeRange(10, 2)];
        [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor} range:NSMakeRange(0, 10)];
        [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor} range:NSMakeRange(12, 8)];
        self.attLabel2.attributedText = attr;
        self.second --;
    }else{
        NSLog(@"跳转到实名认证页面");
        XRealNameVerifiVC *realNameVerVC = [[XRealNameVerifiVC alloc]init];
        [self.navigationController pushViewController:realNameVerVC animated:YES];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 实名认证按钮点击事件
- (void)realNameVerifiClick {
    XRealNameVerifiVC *realNameVerVC = [[XRealNameVerifiVC alloc]init];
    realNameVerVC.isFromBackground = self.ifFromLoginVC;
    [self.navigationController pushViewController:realNameVerVC animated:YES];
}

#pragma mark - 布局子控件
- (void)setupSubViews {
    //对号图片
    UIImageView *successImgView = [[UIImageView alloc]init];
    successImgView.image = [UIImage imageNamed:@"success"];
    [self.view addSubview:successImgView];
    [successImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(60.5);
    }];
    //文字
    UILabel *successLabel = [[UILabel alloc]init];
    successLabel.text = @"恭喜您，注册成功!";
    successLabel.textColor = [XAppContext appColors].blackColor;
    successLabel.font = [XAppContext appFonts].font_22;
    [self.view addSubview:successLabel];
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(successImgView.mas_bottom).offset(22);
    }];
    //实名认证...Label
    UILabel *attLabel1 = [[UILabel alloc]init];
    attLabel1.text = @"实名认证，让您的交易更安全!";
    attLabel1.textColor = [XAppContext appColors].grayBlackColor;
    attLabel1.font = [XAppContext appFonts].font_17;
    [self.view addSubview:attLabel1];
    [attLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(successLabel.mas_bottom).offset(62);
    }];
    //你还未进行...Label
    self.attLabel2 = [[UILabel alloc]init];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"你还未进行实名认证，3秒后引导您实名认证"];
    [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].blueColor} range:NSMakeRange(10, 2)];
    [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor} range:NSMakeRange(0, 10)];
    [attr setAttributes:@{NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor} range:NSMakeRange(12, 8)];
    self.attLabel2.attributedText = attr;
    self.attLabel2.font = [XAppContext appFonts].font_15;
    [self.view addSubview:self.attLabel2];
    [self.attLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(attLabel1.mas_bottom).offset(13);
    }];
    //实名认证按钮
    self.verifiBtn = [[UIButton alloc]init];
    [self.verifiBtn setBackgroundColor:[XAppContext appColors].blueColor];
    [self.verifiBtn addTarget:self action:@selector(realNameVerifiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.verifiBtn setTitle:@"实名认证" forState:UIControlStateNormal];
    self.verifiBtn.titleLabel.font = [XAppContext appFonts].font_18;
    self.verifiBtn.layer.cornerRadius = 5;
    self.verifiBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.verifiBtn];
    [self.verifiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.attLabel2.mas_bottom).offset(29);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
}
@end
