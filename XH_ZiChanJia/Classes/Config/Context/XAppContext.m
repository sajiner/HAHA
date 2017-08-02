//
//  XAppContext.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAppContext.h"

/*****************************************
 *
 * 系统上下文常用变量、方法
 *
 *****************************************/
@implementation XAppContext

// 系统版本号
static NSString *_version;
// 持久化系统颜色配置
static XAppColor *_appColors = nil;
// 持久化系统字体配置
static XAppFont*_appFonts = nil;

#pragma mark - 获取当前的系统版本号
+ (NSString *)appVersion {
    if (!_version) {
        _version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return _version;
}

#pragma mark - app是否安装第一次启动或更新后第一次启动
+ (BOOL)appFirstInstall {
    NSString *firstPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/first.plist"];
    NSDictionary *firstDict = [NSDictionary dictionaryWithContentsOfFile:firstPath];
    if (!firstDict) {
        return YES;
    }
    return NO;
}

#pragma mark - 系统配置的通用颜色类 
+ (XAppColor *)appColors {
    if (!_appColors) {
        _appColors = [[XAppColor alloc] init];
    }
    return _appColors;
}

#pragma mark - 系统配置的通用字体类 
+ (XAppFont *)appFonts {
    if (!_appFonts) {
        _appFonts = [[XAppFont alloc] init];
    }
    return _appFonts;
}

//-----------------以下是单例的写法---------------------------
static XAppContext *_context;
+ (XAppContext *)context {
    if (_context == nil) {
        _context = [[self alloc] init];
    }
    return _context;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_context) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _context = [super allocWithZone:zone];
        });
    }
    return _context;
}

- (id)copyWithZone:(NSZone *)zone {
    return _context;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _context;
}
//-----------------以上是单例的写法---------------------------

@end
