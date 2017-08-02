//
//  NSString+XExtension.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface NSString (XExtension)

/**
 *  包含元的字符串
 */
- (NSMutableAttributedString *)stringWithFont: (UIFont *)stringFont yuanFont: (UIFont *)yuanFont stringColor: (UIColor *)stringColor yuanColor: (UIColor *)yuanColor;

- (NSMutableAttributedString *)stringWithContent: (NSString *)content title: (NSString *)title contentFont: (UIFont *)contentFont contentColor: (UIColor *)contentColor;

/**
 *  转换为以逗号分隔的字符串
 */
-(NSString *)decimalString;

/**
 获取本机ip

 @param preferIPv4 是否希望ipv4返回地址

 @return 本机ip
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/**
 * 请求参数url encode
 */
-(NSString*)UrlValueEncode:(NSString*)str;

@end
