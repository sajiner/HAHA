//
//  XWebViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XWebViewController.h"

/*****************************************
 *
 * 公用的webViewController
 *
 *****************************************/

@interface XWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, assign, getter=isHaveToken) BOOL isHaveToken;

@property (nonatomic, strong) NSMutableURLRequest *currentRequest;

@end

@implementation XWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupBackButton];
    [self.view addSubview:self.webView];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [_webView loadRequest:request];
    _currentRequest = request;
}

#pragma mark - 设置返回按钮
- (void)setupBackButton {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"back_blue" selImageName:@"back_blue" target:self action:@selector(leftBarbuttonClick)];
}

#pragma mark - 返回按钮点击事件
- (void)leftBarbuttonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request);
    if ([[[request URL] absoluteString ] rangeOfString:@"blank.html"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([[[request URL] absoluteString ] rangeOfString:@"my.html"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
   [self showActivityViewWithTitle:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self completeLoadWithTitle:nil];
    if (!self.navigationItem.title) {
        self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    } else if ([self.navigationItem.title  isEqual: @"风险偏好"]) {
        [self setupToken];
        if (!_isHaveToken) {
            [_webView loadRequest:_currentRequest];
            _isHaveToken = YES;
        }
    }
}

/// 设置token
- (void)setupToken {
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"hmd.setToken('%@')",[UserManager User].token]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self completeLoadWithTitle:@"加载失败"];
}

#pragma mark - lazy
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

@end
