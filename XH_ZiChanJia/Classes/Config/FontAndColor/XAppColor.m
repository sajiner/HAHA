//
//  XAppColor.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAppColor.h"

@implementation XAppColor

- (UIColor *)blueColor {
    if (!_blueColor) {
        _blueColor = RGB(2, 100, 207);
    }
    return _blueColor;
}

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = RGB(228, 228, 228);
    }
    return _lineColor;
}

- (UIColor *)whiteColor {
    if (!_whiteColor) {
        _whiteColor = RGB(255, 255, 255);
    }
    return _whiteColor;
}

- (UIColor *)blackColor {
    if (!_blackColor) {
        _blackColor = RGB(23, 26, 35);
    }
    return _blackColor;
}

- (UIColor *)grayBlackColor {
    if (!_grayBlackColor) {
        _grayBlackColor = RGB(57, 70, 89);
    }
    return _grayBlackColor;
}

- (UIColor *)lightGrayColor {
    if (!_lightGrayColor) {
        _lightGrayColor = RGB(145, 154, 167);
    }
    return _lightGrayColor;
}

- (UIColor *)orangeColor {
    if (!_orangeColor) {
        _orangeColor = RGB(253, 130, 56);
    }
    return _orangeColor;
}

- (UIColor *)placeholderColor {
    if (!_placeholderColor) {
        _placeholderColor = RGB(201, 201, 201);
    }
    return _placeholderColor;
}

- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = RGB(245, 245, 245);
    }
    return _backgroundColor;
}

- (UIColor *)greenColor {
    if (!_greenColor) {
        _greenColor = RGB(76, 217, 100);
    }
    return _greenColor;
}

- (UIColor *)lightBlueColor {
    if (!_lightBlueColor) {
        _lightBlueColor = RGB(243, 250, 254);
    }
    return _lightBlueColor;
}

-(UIColor *)yellowColor{
    if(!_yellowColor){
        _yellowColor = RGB(255, 254, 243);
    }
    return _yellowColor;
}

- (UIColor *)redColor {
    if (!_redColor) {
        _redColor = RGB(245, 79, 79);
    }
    return _redColor;
}

@end
