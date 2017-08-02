//
//  NSString+XExtension.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "NSString+XExtension.h"

@implementation NSString (XExtension)

- (NSMutableAttributedString *)stringWithFont: (UIFont *)stringFont yuanFont: (UIFont *)yuanFont stringColor: (UIColor *)stringColor yuanColor: (UIColor *)yuanColor {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttributes:@{
                            NSFontAttributeName: stringFont,
                            NSForegroundColorAttributeName: stringColor
                            }range:NSMakeRange(0, self.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName: yuanFont,
                             NSForegroundColorAttributeName: yuanColor
                             }range:NSMakeRange(self.length - 3, 3)];
    return attrStr;
}

- (NSMutableAttributedString *)stringWithContent:(NSString *)content title:(NSString *)title contentFont:(UIFont *)contentFont contentColor:(UIColor *)contentColor {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    // 设置行间距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 7;
    NSLog(@"%@", self);
    [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
    if ([content containsString:@"个月"]) {
        [attrStr addAttributes:@{
                                 NSFontAttributeName: contentFont,
                                 NSForegroundColorAttributeName: contentColor
                                 }range:NSMakeRange(0, content.length - 2)];
    } else if ([content containsString:@"%"]) {
        [attrStr addAttributes:@{
                                 NSFontAttributeName: contentFont
                                 }range:NSMakeRange(0, content.length - 1)];
        [attrStr addAttributes:@{
                                 NSForegroundColorAttributeName: contentColor
                                 }range:NSMakeRange(0, content.length)];
    } else {
        [attrStr addAttributes:@{
                                 NSFontAttributeName: contentFont,
                                 NSForegroundColorAttributeName: contentColor
                                 }range:NSMakeRange(0, content.length)];
    }
    if ([title containsString:@"（元）"]) {
        [attrStr addAttributes:@{
                                 NSFontAttributeName: [XAppContext appFonts].font_12,
                                 NSForegroundColorAttributeName: [XAppContext appColors].lightGrayColor
                                 }range:NSMakeRange(self.length - 3, 3)];
    }
    return attrStr;
}

#pragma mark - 转换为以逗号分隔的字符串
- (NSString *)decimalString {
    NSString *numString = [NSString stringWithFormat:@"%.2f", [self doubleValue]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    NSString *string = [formatter stringFromNumber:number];
    string = [string substringFromIndex:1];
    return string;
}

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([self isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

#pragma mark - 请求参数url encode
-(NSString*)UrlValueEncode:(NSString*)str {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    return result;
}

@end
