//
//  XAssetInvestViewController.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XSanBiaoDetailModel;

@interface XAssetInvestViewController : UIViewController
//pid
@property (nonatomic,assign)NSInteger pid;
@property (nonatomic,strong) XSanBiaoDetailModel *model;

@end
