//
//  XButton.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/30.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XButton.h"

@implementation XButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 20, self.width, self.height * 0.6 - 20);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(0, self.height * 0.6, self.width, self.height * 0.4);
}

@end
