//
//  XSanBiaoInvestFormViewController.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSanBiaoDetailModel.h"

@interface XSanBiaoInvestFormViewController : UIViewController
//pid
@property (nonatomic,assign)NSInteger pid;
@property (nonatomic,strong) XSanBiaoDetailModel *model;
@end
