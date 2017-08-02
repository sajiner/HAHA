//
//  XFormView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/14.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XFormView.h"

@implementation XFormView {
    UILabel *_label3;
    UILabel *_label4;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElement];
    }
    return self;
}

- (void)initElement {
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc] init];
    lineView4.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView4];
    
    UIView *lineView5 = [[UIView alloc] init];
    lineView5.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView5];
    
    _label1 = [UILabel labelWithFont:_contentFont text:@"" textColor:_contentColor];
    [self addSubview:_label1];
    _label1.numberOfLines = 0;
    
    _label2 = [UILabel labelWithFont:_contentFont text:@"" textColor:_contentColor];
    [self addSubview:_label2];
    _label2.numberOfLines = 0;
    
    _label3 = [UILabel labelWithFont:_contentFont text:@"" textColor:_contentColor];
    [self addSubview:_label3];
    _label3.numberOfLines = 0;
    
    _label4 = [UILabel labelWithFont:_contentFont text:@"" textColor:_contentColor];
    [self addSubview:_label4];
    _label4.numberOfLines = 0;
    
    // frame
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(43);
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.leading.mas_equalTo(lineView1.mas_trailing).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(43);
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
         make.leading.mas_equalTo(_label1.mas_trailing).offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(43);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.leading.mas_equalTo(lineView2.mas_trailing).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(43);
    }];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.leading.mas_equalTo(_label2.mas_trailing).offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(43);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.leading.mas_equalTo(lineView3.mas_trailing).offset(0);
        make.trailing.mas_equalTo(lineView4.mas_leading).offset(0);
        make.height.mas_equalTo(43);
    }];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.trailing.mas_equalTo(_label4.mas_leading).offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(43);
    }];
    
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.trailing.mas_equalTo(lineView5.mas_leading).offset(0);
        make.height.mas_equalTo(43);
        make.width.mas_equalTo(80);
    }];
    
    [lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.trailing.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(43);
    }];
}

#pragma mark - setter
- (void)setContent1:(NSString *)content1 {
    _content1 = content1;
    _label1.text = content1;
}

- (void)setContent2:(NSString *)content2 {
    _content2 = content2;
    _label2.text = content2;
}

- (void)setContent3:(NSString *)content3 {
    _content3 = content3;
    _label3.text = content3;
}

- (void)setContent4:(NSString *)content4 {
    _content4 = content4;
    _label4.text = content4;
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    _label1.textColor = contentColor;
    _label2.textColor = contentColor;
    _label3.textColor = contentColor;
    _label4.textColor = contentColor;
}

- (void)setContentFont:(UIFont *)contentFont {
    _contentFont = contentFont;
    _label4.font = contentFont;
    _label3.font = contentFont;
    _label2.font = contentFont;
    _label1.font = contentFont;
}

@end
