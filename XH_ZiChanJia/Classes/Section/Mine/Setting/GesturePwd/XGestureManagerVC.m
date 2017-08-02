//
//  XGestureManagerVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XGestureManagerVC.h"
#import "GestureViewController.h"
#import "GestureVerifyViewController.h"
@interface XGestureManagerVC ()

//修改手势密码View
@property(nonatomic,strong)UIView *changeGesPwdView;
//手势密码SwitchView
@property(nonatomic,strong)UIView *gestureSwitchView;
//手势密码View上面的line
@property(nonatomic,strong)UIView *topline;
//手势密码icon
@property(nonatomic,strong)UIImageView *gesSwitchIcon;
//UISwitch
@property(nonatomic,strong)UISwitch *gesSwitch;

@end

@implementation XGestureManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势密码管理";
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.hiddenLineView = NO;
    //判断是否设置了手势密码
    if([[NSUserDefaults standardUserDefaults]objectForKey:gestureFinalSaveKey]){
        self.gesSwitch.on = YES;
        self.gesSwitchIcon.image = [UIImage imageNamed:@"gesture_onOrNot"];
        self.changeGesPwdView.hidden = NO;
        [self.gestureSwitchView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.changeGesPwdView.mas_bottom);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
                make.height.equalTo(@44);
        }];
        [self.topline mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gestureSwitchView.mas_top);
            make.left.equalTo(self.gestureSwitchView.mas_left).offset(59);
            make.right.equalTo(self.gestureSwitchView.mas_right);
            make.height.equalTo(@1);
        }];
    }else{
        self.changeGesPwdView.hidden = YES;
        self.gesSwitch.on = NO;
        self.gesSwitchIcon.image = [UIImage imageNamed:@"gesture"];
        [self.gestureSwitchView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(13);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.equalTo(@44);
        }];
        [self.topline mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gestureSwitchView.mas_top);
            make.left.equalTo(self.gestureSwitchView.mas_left);
            make.right.equalTo(self.gestureSwitchView.mas_right);
            make.height.equalTo(@1);
        }];
    }
}

#pragma mark - 修改手势密码点击事件
- (void)changeGesPwdClick {
    GestureVerifyViewController *changeVC = [[GestureVerifyViewController alloc]init];
    changeVC.isToSetNewGesture = YES;
    [self.navigationController pushViewController:changeVC animated:YES];
}

#pragma mark - 开关点击事件
- (void)switchClick {
   if(self.gesSwitch.on){
       //如果开启，先进入手势密码设置界面
       GestureViewController *gestureVC = [[GestureViewController alloc]init];
       gestureVC.type = GestureViewControllerTypeSetting;
       [self.navigationController pushViewController:gestureVC animated:YES];
    }else{
        //如果关闭，此处要先验证下手势密码再关闭
        GestureVerifyViewController *changeVC = [[GestureVerifyViewController alloc]init];
        [self.navigationController pushViewController:changeVC animated:YES];
        self.changeGesPwdView.hidden = YES;
    }
}

#pragma mark - 布局子控件
- (void)setupSubViews {
    //修改手势密码View
    self.changeGesPwdView = [[UIView alloc]init];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeGesPwdClick)];
    [self.changeGesPwdView addGestureRecognizer:tap1];
    [self.view addSubview:self.changeGesPwdView];
    [self.changeGesPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(13);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //line
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [XAppContext appColors].lineColor;
    [self.changeGesPwdView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.changeGesPwdView.mas_top);
        make.left.right.equalTo(self.changeGesPwdView);
        make.height.equalTo(@1);
    }];
    //修改手势密码Icon
    UIImageView *changePwdIcon = [[UIImageView alloc]init];
    changePwdIcon.image = [UIImage imageNamed:@"modify_gesture"];
    [self.changeGesPwdView addSubview:changePwdIcon];
    [changePwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeGesPwdView.mas_centerY);
        make.left.equalTo(self.changeGesPwdView.mas_left).offset(15);
    }];
    //修改手势密码TitleLabel
    UILabel *changeGesLabel = [[UILabel alloc]init];
    changeGesLabel.text = @"修改手势密码";
    changeGesLabel.textColor = [XAppContext appColors].grayBlackColor;
    changeGesLabel.font = [XAppContext appFonts].font_15;
    [self.changeGesPwdView addSubview:changeGesLabel];
    [changeGesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeGesPwdView.mas_centerY);
        make.left.equalTo(changePwdIcon.mas_right).offset(15);
    }];
    //arrowImg
    UIImageView *arrowImg = [[UIImageView alloc]init];
    arrowImg.image = [UIImage imageNamed:@"btn_down"];
    arrowImg.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.changeGesPwdView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeGesPwdView.mas_centerY);
        make.right.equalTo(self.changeGesPwdView.mas_right).offset(-15);
    }];
    //手势密码SwitchView
    self.gestureSwitchView = [[UIView alloc]init];
    [self.view addSubview:self.gestureSwitchView];
    [self.gestureSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.changeGesPwdView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    //topline
    self.topline = [[UIView alloc]init];
    self.topline.backgroundColor = [XAppContext appColors].lineColor;
    [self.gestureSwitchView addSubview:self.topline];
    [self.topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gestureSwitchView.mas_top);
        make.left.equalTo(self.gestureSwitchView.mas_left).offset(59);
        make.right.equalTo(self.gestureSwitchView.mas_right);
        make.height.equalTo(@1);
    }];
    //手势密码Icon
    UIImageView *gesSwitchIcon = [[UIImageView alloc]init];
    self.gesSwitchIcon = gesSwitchIcon;
    gesSwitchIcon.image = [UIImage imageNamed:@"gesture"];
    [self.gestureSwitchView addSubview:gesSwitchIcon];
    [gesSwitchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gestureSwitchView.mas_centerY);
        make.left.equalTo(self.gestureSwitchView.mas_left).offset(15);
    }];
    //手势密码TitleLabel
    UILabel *gesSwitchLabel = [[UILabel alloc]init];
    gesSwitchLabel.text = @"手势密码";
    gesSwitchLabel.textColor = [XAppContext appColors].grayBlackColor;
    gesSwitchLabel.font = [XAppContext appFonts].font_15;
    [self.gestureSwitchView addSubview:gesSwitchLabel];
    [gesSwitchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gestureSwitchView.mas_centerY);
        make.left.equalTo(gesSwitchIcon.mas_right).offset(15);
    }];
    //开关
    self.gesSwitch = [[UISwitch alloc]init];
    [self.gesSwitch addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
    self.gesSwitch.onTintColor = [XAppContext appColors].blueColor;
    [self.gestureSwitchView addSubview:self.gesSwitch];
    [self.gesSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gestureSwitchView.mas_centerY);
        make.right.equalTo(self.gestureSwitchView.mas_right).offset(-15);
    }];
    //bottomLine
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.gestureSwitchView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.gestureSwitchView.mas_bottom);
        make.left.equalTo(self.gestureSwitchView.mas_left);
        make.right.equalTo(self.gestureSwitchView.mas_right);
        make.height.equalTo(@1);
    }];
}
@end
