//
//  UINavigationController+XExtension.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "UINavigationController+XExtension.h"

static const void *HiddenLineViewKey = &HiddenLineViewKey;

@implementation UINavigationController (XExtension)

#pragma mark - 给分类添加属性
- (void)setHiddenLineView:(BOOL)hiddenLineView {
    objc_setAssociatedObject(self, HiddenLineViewKey, @(hiddenLineView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isHiddenLineView {
    return objc_getAssociatedObject(self, HiddenLineViewKey);
}

@end
