//
//  UIBarButtonItem+XExtension.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/30.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XExtension)

+ (instancetype)itemWithNorImageName: (NSString *)norImageName selImageName: (NSString *)selImageName target: (id)target action: (SEL)action;

@end
