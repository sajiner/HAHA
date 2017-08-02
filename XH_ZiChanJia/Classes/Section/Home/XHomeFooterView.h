//
//  XHomeFooterView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//首页底部的安全运营时间FooterView
@interface XHomeFooterView : UIView
//年
@property(nonatomic,copy)NSString *yearString;
//天
@property(nonatomic,copy)NSString *dayString;
//时
@property(nonatomic,copy)NSString *hourString;
//分
@property(nonatomic,copy)NSString *minuteString;
@end
