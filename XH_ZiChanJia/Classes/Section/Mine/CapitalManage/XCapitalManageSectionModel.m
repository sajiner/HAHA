//
//  XCapitalManageSectionModel.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XCapitalManageSectionModel.h"
#import "XCapitalManageCellModel.h"

@implementation XCapitalManageSectionModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"sublist":[XCapitalManageCellModel class]
             };
}

- (NSString *)month0 {
    NSMutableString *strM = [[NSMutableString alloc] initWithString:_month];
    [strM insertString:@"年" atIndex:4];
    [strM insertString:@"月" atIndex:strM.length];
    return strM;
}

@end
