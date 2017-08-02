//
//  XGoldViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XGoldViewController.h"
#import "XMineViewController.h"
#import "GestureViewController.h"
#import "XTabBarController.h"
#import "XRegisterViewController.h"
@interface XGoldViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation XGoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self setupBackButton];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:Request_GoldInlet]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[_params dataUsingEncoding:NSUTF8StringEncoding]];
    [_webView loadRequest:request];
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
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request);
    //开通存管账户成功
    if ([[[request URL] absoluteString ]rangeOfString:@"goldSuccess.html"].location != NSNotFound) {
        //如果是从实名认证或者登录跳转进来的
        if(self.isFromNameVerifi || self.isFromLogin){
            //如果没有设置手势密码
            if(![[NSUserDefaults standardUserDefaults]objectForKey:gestureFinalSaveKey]){
                //TODO:如果开通存管账户成功(如果失败，或者点击退出，都不跳转到手势密码)
                GestureViewController *gestureVC = [[GestureViewController alloc]init];
                gestureVC.type = GestureViewControllerTypeSetting;
                gestureVC.isFromLogin = YES;
                [self.navigationController pushViewController:gestureVC animated:YES];
                __weak typeof(self) weakself = self;
                //如果是从后台跳前台的登录进来的，此时肯定没有手势密码
                if(self.isFromBackground){
                    gestureVC.backBlock = ^{
                        [weakself leftBarbuttonClick];
                    };
                }else{
                    //TODO:如果不是从后台跳前台进来的
                    gestureVC.backBlock = ^{
                        //如果是从首页右上角注册进来的，返回到首页
                        for (int i= 0 ; i<self.navigationController.viewControllers.count; i++) {
                            if([self.navigationController.viewControllers[i] isKindOfClass:[XRegisterViewController class]]){
                                [weakself.navigationController popToRootViewControllerAnimated:YES];
                                return ;
                            }
                        }
                        //否则返回到“我”
                        weakself.tabBarController.selectedIndex = 3;
                        [weakself.navigationController popToRootViewControllerAnimated:YES];
                    };
                }
                
            }
        }
        // 跳转到我的页面
        //        self.navigationController.navigationBar.clipsToBounds = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    if ([[[request URL] absoluteString ]rangeOfString:@"goldDefeat.html"].location != NSNotFound) {
        //开通存管账户失败，就直接返回
        [self leftBarbuttonClick];
        return NO;
    }
//    if ([[[request URL] absoluteString ]rangeOfString:@"close.html"].location != NSNotFound) {
//        return NO;
//    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showActivityViewWithTitle:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self completeLoadWithTitle:nil];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= ’150%’"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self completeLoadWithTitle:nil];
}

#pragma mark - lazy
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavBarHeight)];
        _webView.delegate = self;
    }
    return _webView;
}
@end
