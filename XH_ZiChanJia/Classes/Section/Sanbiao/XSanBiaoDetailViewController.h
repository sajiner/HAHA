//
//  XSanBiaoDetailViewController.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSanBiaoDetailViewController : UIViewController
//pid
@property (nonatomic,assign)NSInteger pid;
//状态
@property (nonatomic,assign)NSInteger m_project_status;
//开抢时间
@property (nonatomic,copy)NSString *start_time;

@end
