//
//  XAppColor.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

/*****************************************
 *
 * 系统用到的颜色类
 *
 *****************************************/
@interface XAppColor : NSObject
// RGB(2, 100, 207)
@property (nonatomic, strong) UIColor *blueColor;
// RGB(228, 228, 228)
@property (nonatomic, strong) UIColor *lineColor;
// RGB(255, 255, 255)
@property (nonatomic, strong) UIColor *whiteColor;
// RGB(23, 26, 35) 黑
@property (nonatomic, strong) UIColor *blackColor;
// RGB(57, 70, 89) 黑灰
@property (nonatomic, strong) UIColor *grayBlackColor;
// RGB(145, 154, 167) 浅灰
@property (nonatomic, strong) UIColor *lightGrayColor;
// RGB(253, 130, 56) 橙色
@property (nonatomic, strong) UIColor *orangeColor;
// RGB(201, 201, 201) placeholderColor
@property (nonatomic, strong) UIColor *placeholderColor;
// RGB(201, 201, 201) backgroundColor
@property (nonatomic, strong) UIColor *backgroundColor;
// RGB(76, 217, 100) greenColor
@property (nonatomic, strong) UIColor *greenColor;
// RGB(243, 250, 254) lightBlueColor
@property (nonatomic, strong) UIColor *lightBlueColor;
// RGB(255, 254, 243) yellowColor
@property(nonatomic,strong)UIColor *yellowColor;
// RGB(245, 79, 79) 红色
@property (nonatomic, strong) UIColor *redColor;


@end
