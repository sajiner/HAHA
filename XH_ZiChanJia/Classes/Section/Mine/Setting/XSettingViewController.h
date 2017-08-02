//
//  XSettingViewController.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSettingViewController : UIViewController
//如果实名认证，获取从“我”获得的姓名和身份证号
//姓名
@property(nonatomic,copy)NSString *u_id_number;
//身份证号
@property(nonatomic,copy)NSString *u_real_name;
@end
