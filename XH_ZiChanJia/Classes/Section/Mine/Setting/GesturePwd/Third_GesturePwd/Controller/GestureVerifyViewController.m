
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
#import "GestureViewController.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "XLoginViewController.h"
#import "XTabBarController.h"
@interface GestureVerifyViewController ()<CircleViewDelegate,CustomAlertViewDelegate>

/**
 *  登录人员相关信息Label
 */
@property(nonatomic,strong)PCLockLabel *drawLabel;

/**
 *  文字提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;
@property(nonatomic,strong)PCCircleInfoView *infoView;
//上限次数
@property(nonatomic,assign)int time;

@end

@implementation GestureVerifyViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        //        [self.view setBackgroundColor:CircleViewBackgroundColor];
    }
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    return self;
}
//iOS9设置status状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置navgationbar背景色
    [self.navigationController.navigationBar setBarTintColor:[XAppContext appColors].blueColor];
    //title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置返回按钮的颜色，默认是蓝色
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
//    //设置上面20status的颜色
//    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
//    
//    statusBarView.backgroundColor=[XAppContext appColors].blueColor;
//    
//    [self.navigationController.navigationBar addSubview:statusBarView];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
    if(self.isToSetNewGesture){
        self.title = @"修改手势密码";
    }
    if(self.isFromBackground){
        self.title = @"验证手势密码";
    }
    if(self.isFromBackground){
        self.title = @"手势密码登录";
        [self.drawLabel showNormalMsg:[UserManager User].userName];
        [self.msgLabel showWarnMsg:@"请滑动输入密码"];
    }

    //设置status状态栏
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //清楚navbar背景黑色线条
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.hiddenLineView = YES;
    //设置背景图片
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
//    CGFloat h = [UIScreen mainScreen].bounds.size.height;
//    NSString *imageName = [NSString stringWithFormat:@"手势密码背景图%d_%d",(int)w * 2,(int)h * 2];
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
//    imgView.frame = self.view.frame;
//    [self.view insertSubview:imgView atIndex:0];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.time = 4;
    self.navigationItem.title = @"验证手势密码";
    self.view.backgroundColor = [XAppContext appColors].blueColor;
    if(!self.isFromBackground){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    }

    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    
    infoView.frame = CGRectMake(kScreenW/2 - CircleRadius * 0.6, 55, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6);
    //设置inforView的位置
    //infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 10);
    self.infoView = infoView;
    [self.view addSubview:infoView];
    
    
    PCCircleView *lockView = [[PCCircleView alloc] init];
    //设置验证控制器界面的arrow为NO
    lockView.arrow = NO;
    lockView.delegate = self;
    [lockView setType:CircleViewTypeVerify];
    [self.view addSubview:lockView];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.font = [UIFont systemFontOfSize:15];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 40);
    [msgLabel showWarnMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    
    //TODO:“绘制解锁图案”
    PCLockLabel *drawLabel = [[PCLockLabel alloc]init];
    drawLabel.font = [UIFont systemFontOfSize:18];
    [drawLabel showNormalMsg:@"绘制解锁图案"];
    self.drawLabel = drawLabel;
    drawLabel.frame = CGRectMake(0, 0, kScreenW, 18);
    drawLabel.center = CGPointMake(kScreenW / 2.0, CGRectGetMinY(self.msgLabel.frame) - 30);
    [self.view addSubview:drawLabel];
    
    // 忘记手势密码
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"忘记手势密码?" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [leftBtn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(26);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
//    [self creatButton:leftBtn frame:CGRectMake(30 , kScreenH - 50, kScreenW/2, 15) title:@"忘记手势密码" alignment:UIControlContentHorizontalAlignmentLeft tag:buttonTagForget];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [XAppContext appColors].whiteColor;
    //title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[XAppContext appColors].blackColor}];
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//忘记手势密码
-(void)didClickBtn{
//    NSLog(@"跳转到登录界面");
//    if(self.isFromBackground){
//        [self dismissViewControllerAnimated:NO completion:^{
//            self.forgetPwdBlock();
//        }];
//    }else{
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        self.forgetPwdBlock();
//    }
    NSLog(@"清空手势密码，跳转到登录界面");
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:gestureFinalSaveKey];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:gestureFinalSaveKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [UserManager clearUser];
    if(self.isFromBackground){
        //弹出登录框
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
        //设置手势密码里的忘记手势密码
        XLoginViewController *loginVC = [[XLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
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
//    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
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

#pragma mark - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    //先验证
    if (type == CircleViewTypeVerify) {
        
        //旧密码验证成功
        if (equal) {
            // infoView展示对应选中的圆
            [self infoViewSelectedSubviewsSameAsCircleView:view];
            NSLog(@"验证成功");
           
            //如果是设置新的密码
            if (self.isToSetNewGesture) {
                GestureViewController *gestureVc = [[GestureViewController alloc] init];
                gestureVc.isFromChangePwd = YES;
                [gestureVc setType:GestureViewControllerTypeSetting];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kdisplayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:gestureVc animated:YES];
                });
            } else {
                if(self.isFromBackground){
                    //后台进前台
                    [self.msgLabel showWarnMsg:@"恭喜您，手势密码解锁成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kdisplayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                }else{
                    //如果是单纯的验证密码
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kdisplayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                        [[NSUserDefaults standardUserDefaults]removeObjectForKey:gestureFinalSaveKey];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    });
                }
          
            }
            
        } else {
            if(self.isFromBackground){
                if(self.time == 0){
                    NSLog(@"输入错误次数已经达到上限，重新登录账号");
                    [self showAlertViewWithTitle:nil message:@"输入错误次数已经达到上限，重新登录账号" letfButtonTitle:@"嗯，我知道了" rightBtn:nil];
                    return ;
                }
                [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError(self.time)];
                self.time --;
            }else{
                [self.msgLabel showWarnMsgAndShake:@"密码验证错误，请重新绘制"];
            }
        }
    }
}

-(void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        //弹出登录框
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
    }
}
@end
