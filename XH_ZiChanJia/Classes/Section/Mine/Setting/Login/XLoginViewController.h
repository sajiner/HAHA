//
//  XLoginViewController.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/14.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoginBlock)();
//登录界面VC
@interface XLoginViewController : UIViewController
//点击忘记手势密码block属性
@property(nonatomic,copy)LoginBlock backBlock;
//是否从后台进前台
@property(nonatomic,assign)BOOL isFromBackground;

@end
