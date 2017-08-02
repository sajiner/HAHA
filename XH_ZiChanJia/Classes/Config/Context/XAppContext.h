//
//  XAppContext.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAppFont.h"
#import "XAppColor.h"

#define X_AppContext [[XAppContext context] appColors]
/*****************************************
 *
 * 系统上下文常用变量、方法
 *
 *****************************************/
@interface XAppContext : NSObject<NSCopying, NSMutableCopying>

/** 根控制器 */
@property (nonatomic, strong) UIViewController *rootPage;

/** 单例的实现方式 */
+(XAppContext *) context;

/** 系统配置的通用颜色类 */
+(XAppColor *)appColors;

/** 系统配置的通用字体类 */
+(XAppFont *)appFonts;

/** 获取当前的系统版本号（build号) */
+(NSString *)appVersion;

/** app是否安装第一次启动或更新后第一次启动 */
+ (BOOL)appFirstInstall;

@end
