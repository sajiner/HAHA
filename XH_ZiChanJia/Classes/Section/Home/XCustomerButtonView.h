//
//  XCustomerButtonView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//首页四个点击的按钮View（上面图片下面文字）
@interface XCustomerButtonView : UIView
- (void)setupTitle: (NSString *)title imgName:(NSString *)imgName target: (id)target action: (SEL)action;
@end
