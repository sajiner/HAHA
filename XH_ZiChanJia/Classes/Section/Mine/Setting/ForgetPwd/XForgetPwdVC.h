//
//  XForgetPwdVC.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//重置登录密码VC
@interface XForgetPwdVC : UIViewController
//用于判断是重置密码/修改密码（2修改3重置）
@property(nonatomic,copy)NSString *resetOrChange;
@end
