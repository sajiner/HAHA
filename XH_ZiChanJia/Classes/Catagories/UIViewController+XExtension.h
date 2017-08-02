//
//  UIViewController+XExtension.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"

@class HUDView;
@interface UIViewController (XExtension)

@property (nonatomic, strong, readonly) HUDView *animateBgView;
@property (nonatomic, strong, readonly) HUDView *activityBgView;
@property (nonatomic, strong, readonly) HUDView *completeBgView;

//加载动画
-(void)showAnimateView;

//加载小菊花
- (void)showActivityViewWithTitle:(NSString *)title;

//加载完成视图
-(void)completeLoadWithTitle:(NSString *)title;

//MBProgress加载完成视图
- (void)mbCompleteLoadWithTitle:(NSString *)title;

- (void)mbCompleteLoadWithTitle:(NSString *)title afterDelay:(int )time;

// 弹出提示信息
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message letfButtonTitle:(NSString *)left rightBtn:(NSString *)right;

@end


@interface HUDView : UIView

-(instancetype)initWithFrame:(CGRect)frame withActivity:(BOOL)isActivity;

@end
