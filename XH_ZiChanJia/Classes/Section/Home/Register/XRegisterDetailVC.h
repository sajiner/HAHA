//
//  XRegisterDetailVC.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//注册页面DetailVC
@interface XRegisterDetailVC : UIViewController
//手机号码
@property(nonatomic,copy)NSString *phoneNumber;
//邀请码
@property(nonatomic,copy)NSString *inviteCode;
//手机验证码
@property(nonatomic,copy)NSString *smsVerifiCode;
//是否从登录跳转过来的
@property(nonatomic,assign)BOOL ifFromLoginVC;
@end
