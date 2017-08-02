
#import "GestureViewController.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "XLoginViewController.h"
#import "XTabBarController.h"
@interface GestureViewController ()<CircleViewDelegate,CustomAlertViewDelegate,CustomAlertViewDelegate>

/**
 *  重设按钮
 */
@property (nonatomic, strong) UIButton *resetBtn;

/**
 *  提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) PCCircleView *lockView;

/**
 *  infoView
 */
@property (nonatomic, strong) PCCircleInfoView *infoView;

/**
 *  记录登录输入错误次数
 */
@property(nonatomic,assign)int time;

@end

@implementation GestureViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%f",self.view.frame.origin.y);
    self.navigationController.hiddenLineView = YES;
}

//iOS9设置status状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化time
    self.time = 4;
    self.view.backgroundColor = [XAppContext appColors].blueColor;
    // 1.界面相同部分生成器
    [self setupSameUI];
    
    // 2.界面不同部分生成器
    [self setupDifferentUI];
    
    //title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].whiteColor}];
    //设置navgationBar背景颜色
    [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].blueColor];
    
    self.lockView.arrow = NO;
    if (self.type == GestureViewControllerTypeLogin) {
        [self.msgLabel showWarnMsg:gestureTextGestureVerify];
    }
    if(!self.isFromBackground){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
        self.navigationItem.leftBarButtonItem.tintColor = [XAppContext appColors].whiteColor;
    }
    // 进来先清空存的第一个密码（因为修改密码是从验证密码跳转进来的，所以需要先把本地存储的密码清空，只需要清除第一次存储的密码就可以，因为验证是验证的第二次密码）
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
    
    //清楚navbar背景黑色线条
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - 创建UIBarButtonItem
- (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = (CGRect){CGPointZero, {100, 20}};
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.tag = tag;
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [button setHidden:YES];
    self.resetBtn = button;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        case GestureViewControllerTypeLogin:
            [self setupSubViewsLoginVc];
            break;
        default:
            break;
    }
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{
    
    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
//    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
//    msgLabel.font = [UIFont systemFontOfSize:16];
//    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
//    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 46);
//    self.msgLabel = msgLabel;
//    [self.view addSubview:msgLabel];
    
}
#pragma mark - leftBarbutton按钮的点击事件
- (void)backClick{
    if(self.isFromBackground){
        NSLog(@"清空手势密码，跳转到登录界面");
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:gestureFinalSaveKey];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:gestureFinalSaveKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [UserManager clearUser];
        //弹出登录框
        XLoginViewController *loginVC = [[XLoginViewController alloc] init];
        loginVC.isFromBackground = YES;
        //            XNavigationController *currentViewCtrl1 = [[XNavigationController alloc] initWithRootViewController:viewCtrl];
        [self.navigationController pushViewController:loginVC animated:YES];
        //清除本地信息
        [UserManager clearUser];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:gestureFinalSaveKey];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:gestureFinalSaveKey];
        [NSUserDefaults standardUserDefaults];
        __weak typeof(self) weakSelf = self;
        loginVC.backBlock = ^{
            XTabBarController *tabbarVC =  (XTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            [tabbarVC.childViewControllers[0] popToRootViewControllerAnimated:NO];
            [tabbarVC.childViewControllers[1] popToRootViewControllerAnimated:NO];
            [tabbarVC.childViewControllers[2] popToRootViewControllerAnimated:NO];
            [tabbarVC.childViewControllers[3] popToRootViewControllerAnimated:NO];
            tabbarVC.selectedIndex = 0;
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
        };
        return;
    }
    if(self.isFromChangePwd){
        [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
        //title颜色
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
        return;
    }
    if(self.isFromLogin){
        [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
        //title颜色
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
        self.backBlock();
    }else{
        [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
        //title颜色
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    [self.lockView setType:CircleViewTypeSetting];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.font = [UIFont systemFontOfSize:15];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 16);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.lockView.frame) - 40);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    
    //判断是否从修改手势密码跳转进来的
    if(!self.isFromChangePwd){
        self.title = @"设置手势密码";
        [self.msgLabel showWarnMsg:gestureTextDrawFirst];
        
        //重新绘制手势密码
//        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rightBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self creatButton:rightBtn frame:CGRectMake(kScreenW/2 - CircleViewEdgeMargin + 11.5, kScreenH - 50, kScreenW/2, 15) title:@"重新绘制手势密码" alignment:UIControlContentHorizontalAlignmentRight tag:buttonTagReset];
        //忽略
        UIButton *ignoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ignoreBtn setTitle:@"忽略" forState:UIControlStateNormal];
        [ignoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ignoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [ignoreBtn addTarget:self action:@selector(ignoreClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ignoreBtn];
        [ignoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-31);
            make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        }];
    }else{
        self.title = @"修改手势密码";
        [self.msgLabel showWarnMsg:gestureTextDrawFirst];
        
        // 忘记手势密码
//        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self creatButton:leftBtn frame:CGRectMake(30 , kScreenH - 50, kScreenW/2, 15) title:@"忘记手势密码" alignment:UIControlContentHorizontalAlignmentLeft tag:buttonTagForget];
        
    }
    
    //“绘制解锁图案”
    PCLockLabel *drawLabel = [[PCLockLabel alloc]init];
    drawLabel.font = [UIFont systemFontOfSize:18];
    [drawLabel showNormalMsg:@"绘制解锁图案"];
//    drawLabel.textColor = [UIColor whiteColor];
    self.drawLabel = drawLabel;
    drawLabel.frame = CGRectMake(0, 0, kScreenW, 18);
    drawLabel.center = CGPointMake(kScreenW / 2.0, CGRectGetMinY(self.msgLabel.frame) - 30);
    [self.view addSubview:drawLabel];
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    infoView.frame = CGRectMake(kScreenW/2 - CircleRadius * 0.6, 55, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6);
    //设置inforView的位置
    //infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 10);
    self.infoView = infoView;
    [self.view addSubview:infoView];
    
    //重新绘制手势密码
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self creatButton:rightBtn frame:CGRectMake(kScreenW/2 - CircleViewEdgeMargin + 11.5, kScreenH - 50, kScreenW/2, 15) title:@"重新绘制手势密码" alignment:UIControlContentHorizontalAlignmentRight tag:buttonTagReset];
}
#pragma mark - 登陆手势密码界面
- (void)setupSubViewsLoginVc
{
    
    [self.lockView setType:CircleViewTypeLogin];
    
    self.title = @"手势密码登录";
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.font = [UIFont systemFontOfSize:16];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.lockView.frame) - 30);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    
    //登录人员相关介绍
    PCLockLabel *drawLabel = [[PCLockLabel alloc]init];
    [drawLabel showNormalMsg:[UserManager User].userName];
    self.drawLabel = drawLabel;
    drawLabel.frame = CGRectMake(0, 0, kScreenW, 18);
    drawLabel.center = CGPointMake(kScreenW / 2.0, CGRectGetMinY(self.msgLabel.frame) - 30);
    [self.view addSubview:drawLabel];
    
    //您好
    PCLockLabel *helloLabel = [[PCLockLabel alloc]init];
    [helloLabel showNormalMsg:@"您好"];
    helloLabel.frame = CGRectMake(0, 0, kScreenW, 18);
    helloLabel.center = CGPointMake(kScreenW / 2.0, CGRectGetMinY(self.drawLabel.frame) - 20);
    [self.view addSubview:helloLabel];
    
    // 头像
    UIImageView  *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.frame = CGRectMake(0, 0, 65, 65);
    imageView.center = CGPointMake(kScreenW/2, CGRectGetMinY(helloLabel.frame) - 50);
    [imageView setImage:[UIImage imageNamed:@"head"]];
    [self.view addSubview:imageView];

    // 忘记手势密码
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self creatButton:leftBtn frame:CGRectMake(30 , kScreenH - 60, kScreenW/2, 20) title:@"忘记手势密码" alignment:UIControlContentHorizontalAlignmentLeft tag:buttonTagForget];
//    
//    // 切换账户
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self creatButton:rightBtn frame:CGRectMake(kScreenW/2 - CircleViewEdgeMargin + 11.5 , kScreenH - 60, kScreenW/2, 20) title:@"切换账户" alignment:UIControlContentHorizontalAlignmentRight tag:buttonTagChange];
    
    // 忘记手势密码
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = buttonTagChange;
    [rightBtn setTitle:@"切换账户" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [rightBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-26);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
    // 忘记手势密码
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.tag = buttonTagForget;
    [leftBtn setTitle:@"忘记手势密码?" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [leftBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(26);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
}

#pragma mark - 创建UIButton
- (void)creatButton:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title alignment:(UIControlContentHorizontalAlignment)alignment tag:(NSInteger)tag
{
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:alignment];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - button点击事件
- (void)didClickBtn:(UIButton *)sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case buttonTagReset:
        {
            NSLog(@"点击了重设按钮");
            // 1.隐藏右上角的重设按钮
            [self.resetBtn setHidden:YES];
            
            // 2.infoView取消选中
            [self infoViewDeselectedSubviews];
            
            // 3.msgLabel提示文字复位
            [self.msgLabel showNormalMsg:gestureTextBeforeSet];
            
            // 4.清除之前存储的密码
            [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
        }
            break;
            
        case buttonTagManager:
        {
            NSLog(@"点击了管理手势密码按钮");
        }
            break;
            
        case buttonTagForget:
            [self backClick];
            break;
            
        case buttonTagChange:
            NSLog(@"点击了切换账户");
            //跳转到登录
            [self backClick];
        default:
            break;
            
    }
}

#pragma mark - 忽略按钮的点击事件
- (void)ignoreClick{
    if(self.isFromLogin){
        [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
        //title颜色
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
        self.backBlock();
    }else{
        [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
        //title颜色
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - circleView - delegate
#pragma mark - circleView - delegate - setting
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = [PCCircleViewConst getGestureWithKey:gestureOneSaveKey];

    // 看是否存在第一个密码
    if ([gestureOne length]) {
        [self.resetBtn setHidden:NO];
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}
#pragma mark - 第一次设置手势密码
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    NSLog(@"获得第一个手势密码%@", gesture);
    [self.drawLabel showNormalMsg:@"再次绘制解锁图案"];
    [self.msgLabel showWarnMsg:gestureTextDrawFirst];
    
    // infoView展示对应选中的圆
    [self infoViewSelectedSubviewsSameAsCircleView:view];
}
#pragma mark - 第二次设置手势密码
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    NSLog(@"获得第二个手势密码%@",gesture);
    if (equal) {
        NSLog(@"两次手势匹配！可以进行本地化保存了");
        if(self.isFromChangePwd){
            [self.msgLabel showWarnMsg:@"恭喜您，手势密码修改成功"];
        }else{
            [self.msgLabel showWarnMsg:gestureTextSetSuccess];
        }
        [PCCircleViewConst saveGesture:gesture Key:gestureFinalSaveKey];
        // 设置手势密码成功后跳转到指定页面
        if(self.isFromChangePwd == YES){
            [self showAlertViewWithTitle:nil message:@"恭喜您，手势密码修改成功！" letfButtonTitle:@"嗯，我知道了" rightBtn:nil];
//            [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
        }else{
            [self showAlertViewWithTitle:nil message:@"恭喜您，手势密码设置成功!" letfButtonTitle:@"嗯，我知道了" rightBtn:nil];
//            [self.navigationController popViewControllerAnimated:YES];
        }

    } else {
        NSLog(@"两次手势不匹配！");
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
        [self.resetBtn setHidden:NO];
    }
    
}


#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    // 此时的type有两种情况 Login or verify
    if (type == CircleViewTypeLogin) {
        if (equal) {
            NSLog(@"登陆成功！");
            [self.msgLabel showWarnMsg:gestureTextGestureVerifySuccess];
            //后台进前台
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kdisplayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        } else {
            if(self.time == 0){
                NSLog(@"输入错误次数已经达到上限，重新登录账号");
                [self showAlertViewWithTitle:nil message:@"输入错误次数已经达到上限，重新登录账号" letfButtonTitle:@"嗯，我知道了" rightBtn:nil];
                return ;
            }
            [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError(self.time)];
            self.time --;
        }
    } else if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功，跳转到设置手势界面");
        } else {
            NSLog(@"原手势密码输入错误！");
            
        }
    }
}

#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView
{
    for (PCCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}

#pragma mark - 让infoView对应按钮取消选中
- (void)infoViewDeselectedSubviews
{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
    }];
}

#pragma mark - CustomeAlertViewDelegate
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        if(self.type == GestureViewControllerTypeLogin){
            XLoginViewController *viewCtrl = [[XLoginViewController alloc] init];
            viewCtrl.isFromBackground = YES;
            //            XNavigationController *currentViewCtrl1 = [[XNavigationController alloc] initWithRootViewController:viewCtrl];
            [self.navigationController pushViewController:viewCtrl animated:YES];
            //清除本地信息
            [UserManager clearUser];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:gestureFinalSaveKey];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:gestureFinalSaveKey];
            [NSUserDefaults standardUserDefaults];
            __weak typeof(self) weakSelf = self;
            viewCtrl.backBlock = ^{
                XTabBarController *tabbarVC =  (XTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                [tabbarVC.childViewControllers[0] popToRootViewControllerAnimated:NO];
                [tabbarVC.childViewControllers[1] popToRootViewControllerAnimated:NO];
                [tabbarVC.childViewControllers[2] popToRootViewControllerAnimated:NO];
                [tabbarVC.childViewControllers[3] popToRootViewControllerAnimated:NO];
                tabbarVC.selectedIndex = 0;
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            };
        }else{
            //设置手势密码成功后跳转到指定页面
            if(self.isFromChangePwd == YES){
                [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
                //title颜色
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
                [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
            }
            if(self.isFromLogin){
                [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
                //title颜色
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
                self.backBlock();
            }else{
                [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].whiteColor];
                //title颜色
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].grayBlackColor}];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        

    }
}

@end
