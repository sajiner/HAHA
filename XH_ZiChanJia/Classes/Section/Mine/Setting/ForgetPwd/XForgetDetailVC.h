//
//  XForgetDetailVC.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//重置登录密码DetailVC
@interface XForgetDetailVC : UIViewController
//手机号
@property(nonatomic,copy)NSString *phoneNumber;
//短信验证码
@property(nonatomic,copy)NSString *smsCode;
//真是姓名
@property(nonatomic,strong)NSString *realName;

//用于判断是重置密码/修改密码（1修改2重置）
@property(nonatomic,copy)NSString *resetOrChange;

@end
