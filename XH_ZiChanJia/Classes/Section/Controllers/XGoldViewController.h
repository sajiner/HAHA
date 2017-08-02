//
//  XGoldViewController.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

/*****************************************
 *
 * post请求的webView容器
 *
 *****************************************/
@interface XGoldViewController : UIViewController

// 请求参数
@property (nonatomic, copy) NSString *params;
//是否从实名认证跳转进来的
@property(nonatomic,assign)BOOL isFromNameVerifi;
//是否从后台进来的
@property(nonatomic,assign)BOOL isFromBackground;
//是否从登录直接跳转进来的
@property(nonatomic,assign)BOOL isFromLogin;

@end
