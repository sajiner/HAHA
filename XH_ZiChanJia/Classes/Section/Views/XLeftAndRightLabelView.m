//
//  XLeftAndRightLabelView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XLeftAndRightLabelView.h"

@implementation XLeftAndRightLabelView {
    UILabel *_titleLabel;
    UILabel *_contentLabel;
}

#pragma mark - 实例化类方法
+ (instancetype)viewWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont contentColor:(UIColor *)contentColor contentFont:(UIFont *)contentFont title: (NSString *)title {
    
    return [[XLeftAndRightLabelView alloc] initWithTitleColor:titleColor titleFont:titleFont contentColor:contentColor contentFont:contentFont title:title];
}

- (instancetype)initWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont contentColor:(UIColor *)contentColor contentFont:(UIFont *)contentFont title: (NSString *)title {
    self = [super initWithFrame:self.bounds];
    if (self) {
        UILabel *titleLabel = [UILabel labelWithFont:titleFont text:title textColor:titleColor];
        _titleLabel = titleLabel;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        
        UILabel *contentLabel = [UILabel labelWithFont:contentFont text:@"" textColor:contentColor];
        _contentLabel = contentLabel;
        contentLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:contentLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.leading.mas_equalTo(15);
        }];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    _contentLabel.text = content;
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    _contentLabel.textColor = contentColor;
}

@end
