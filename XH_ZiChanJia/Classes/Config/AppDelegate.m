//
//  AppDelegate.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "AppDelegate.h"
#import "XTabBarController.h"
#import "YTKNetworkConfig.h"
#import "GestureViewController.h"
#import "XNavigationController.h"
#import "XLoginViewController.h"
#import "XGuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /// 设置启动图片停留时间为1秒
    [NSThread sleepForTimeInterval:1.0];
    /// 设置根控制器
    [self setupRootViewController];
    /// 配置网络信息
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = RequestBaseUrl;
    /// 接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relogin) name:RELOGIN_NOTIFICATION object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if([[NSUserDefaults standardUserDefaults]objectForKey:gestureFinalSaveKey]){
        //如果设置过手势密码，此处要先验证
        GestureViewController *gestureLoginVc = [[GestureViewController alloc] init];
        XNavigationController *nav = [[XNavigationController alloc]initWithRootViewController:gestureLoginVc];
        gestureLoginVc.isFromBackground = YES;
        gestureLoginVc.type = GestureViewControllerTypeLogin;
        XTabBarController *tabbarVC = (XTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [tabbarVC presentViewController:nav animated:YES completion:nil];

    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - 重新登录
- (void)relogin {
    XLoginViewController *viewCtrl = [[XLoginViewController alloc] init];
    [self.window.rootViewController.navigationController pushViewController:viewCtrl animated:YES];
}

#pragma mark - 设置根控制器
- (void)setupRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //判断是否首次启动
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    // 默认是NO
    BOOL isFirst = [userdefaults boolForKey:@"isFirstStart"];
    // 获取当前版本号
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:(NSString *)kCFBundleVersionKey];
    NSLog(@"%@", version);
    if (!isFirst) { // 是首次启动或者版本更新
        XGuideViewController *guideVc = [[XGuideViewController alloc] init];
        self.window.rootViewController = guideVc;
    } else {
        XTabBarController *tabBarVc = [[XTabBarController alloc] init];
        self.window.rootViewController = tabBarVc;
    }
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
}

@end
