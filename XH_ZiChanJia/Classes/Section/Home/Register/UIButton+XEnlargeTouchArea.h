//
//  UIButton+XEnlargeTouchArea.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//扩大UIButton的点击相应范围
@interface UIButton (XEnlargeTouchArea)
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
