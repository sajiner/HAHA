//
//  XNavigationController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XNavigationController.h"
#import "UIBarButtonItem+XExtension.h"

@interface XNavigationController ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation XNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:@{
                                    NSFontAttributeName: [XAppContext appFonts].font_18,
                                    NSForegroundColorAttributeName: [XAppContext appColors].blackColor
                                    }];
    navBar.translucent = NO;
    navBar.barTintColor = [XAppContext appColors].whiteColor;
    navBar.tintColor = [XAppContext appColors].blackColor;
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - 二级页面隐藏tabBar、添加左返回按钮、设置导航条下的线条
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"back_blue" selImageName:@"back_blue" target:self action:@selector(back)];
        self.hiddenLineView = NO;
    } else {
        self.hiddenLineView = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 返回上个控制器
- (void)back {
    if (self.childViewControllers.count == 2) {
        self.hiddenLineView = YES;
    }
    [self popViewControllerAnimated:YES];
}

#pragma lazy
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenWidth, 1)];
        _lineView.backgroundColor = [XAppContext appColors].lineColor;
    }
    return _lineView;
}

- (void)setHiddenLineView:(BOOL)hiddenLineView {
    if (hiddenLineView == YES) {
        if ([self.navigationBar.subviews containsObject:self.lineView]) {
            // 去掉线
            [self.lineView removeFromSuperview];
        }
    } else {
        if (![self.navigationBar.subviews containsObject:self.lineView]) {
            [self.navigationBar addSubview:self.lineView];
        }
    }
}

@end
