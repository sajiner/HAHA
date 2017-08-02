//
//  XTabBarController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XTabBarController.h"
#import "XHomeViewController.h"
#import "XMineViewController.h"
#import "XSanBiaoViewController.h"
#import "XAssetBaoViewController.h"
#import "XNavigationController.h"
#import "XLoginViewController.h"

@interface XTabBarController ()<UITabBarControllerDelegate>

@end

@implementation XTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self addAllChildViewControllers];
}

- (void)addAllChildViewControllers {
   [self addChildViewController: [[XHomeViewController alloc] init]title:@"首页" selectedImage:@"home_on" normolImage:@"home_off"];
    [self addChildViewController: [[XSanBiaoViewController alloc] init]title:@"散标" selectedImage:@"mt_on" normolImage:@"mt_off"];
    [self addChildViewController: [[XAssetBaoViewController alloc] init]title:@"嘉盈" selectedImage:@"zc_on" normolImage:@"zc_off"];
    [self addChildViewController: [[XMineViewController alloc] init]title:@"我" selectedImage:@"me_on" normolImage:@"me_off"];

}

- (void)addChildViewController:(UIViewController *)vc title: (NSString *)title selectedImage: (NSString *)selectedImage normolImage: (NSString *)normolImage {
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:normolImage];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [XAppContext appColors].whiteColor;
    
//    NSDictionary *normalTextAttributes = @{
//                                           NSFontAttributeName: [UIFont systemFontOfSize:10],
//                                           NSForegroundColorAttributeName: [UIColor blackColor]
//                                           };
//    NSDictionary *selectedTextAttributes = @{
//                                             NSFontAttributeName: [UIFont systemFontOfSize:10],
//                                             NSForegroundColorAttributeName: [UIColor redColor]
//                                             };
//    [vc.tabBarItem setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
//    [vc.tabBarItem setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    
    XNavigationController *nav = [[XNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    XNavigationController *navgaViewCtrl = (XNavigationController*)viewController;
    if([navgaViewCtrl.topViewController isKindOfClass:[XMineViewController class]]) {
        
        if(![UserManager User].token) {
            XLoginViewController *loginVC = [[XLoginViewController alloc] init];
            //获取当前在的页面的根控制器
            XNavigationController *currentViewCtrl = tabBarController.selectedViewController;
            [currentViewCtrl pushViewController:loginVC animated:YES];
            return false;
        }
    }
    return true;
}

@end
