//
//  XRealNameVerifiVC.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//无参无返回值的block
//实名认证界面VC
@interface XRealNameVerifiVC : UIViewController
//如果实名认证，获取从“我”获得的姓名和身份证号
//姓名
@property(nonatomic,copy)NSString *u_id_number;
//身份证号
@property(nonatomic,copy)NSString *u_real_name;
//是否从后台进前台
@property(nonatomic,assign)BOOL isFromBackground;
@end
