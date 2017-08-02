//
//  XMyJiaYingDetailHeaderView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingDetailHeaderView.h"
#import "XMyJiaYingModel.h"

@implementation XMyJiaYingDetailHeaderView {
    UILabel *_titleLabel;
    UILabel *_markLabel;    // 匹配笔数
    UILabel *_profitLabel;  // 收益方式
    UILabel *_preProfitLabel;  // 代收收益
    UILabel *_sectionTitleLabel;  // 每组的组名
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [XAppContext appColors].backgroundColor;
        [self initElement];
    }
    return self;
}

- (void)initElement {
   
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [XAppContext appColors].whiteColor;
    [self addSubview:bgView];
    
    UILabel *titleLabel = [UILabel labelWithFont:[XAppContext appFonts].font_16 text:@"" textColor:[XAppContext appColors].grayBlackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel *preProfitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    preProfitLabel.textAlignment = NSTextAlignmentCenter;
    preProfitLabel.numberOfLines = 0;
    [bgView addSubview:preProfitLabel];
    _preProfitLabel = preProfitLabel;
    
    UILabel *markLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    markLabel.textAlignment = NSTextAlignmentCenter;
    markLabel.numberOfLines = 0;
    [bgView addSubview:markLabel];
    _markLabel = markLabel;
    
    UILabel *profitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    profitLabel.textAlignment = NSTextAlignmentCenter;
    profitLabel.numberOfLines = 0;
    [bgView addSubview:profitLabel];
    _profitLabel = profitLabel;
    
    CAShapeLayer *shapeLayer0 = [CAShapeLayer layer];
    UIBezierPath *path0 = [UIBezierPath bezierPathWithRect:CGRectMake(15, 40, (ScreenWidth - 76) / 3, 80)];
    shapeLayer0.path = path0.CGPath;
    shapeLayer0.fillColor = [UIColor clearColor].CGColor;
    shapeLayer0.strokeColor = [XAppContext appColors].lineColor.CGColor;
    [bgView.layer addSublayer:shapeLayer0];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:CGRectMake((ScreenWidth + 14) / 3, 40, (ScreenWidth - 76) / 3, 80)];
    shapeLayer1.path = path1.CGPath;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.strokeColor = [XAppContext appColors].lineColor.CGColor;
    [bgView.layer addSublayer:shapeLayer1];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake((2 * ScreenWidth - 17) / 3, 40, (ScreenWidth - 76) / 3, 80)];
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.strokeColor = [XAppContext appColors].lineColor.CGColor;
    [bgView.layer addSublayer:shapeLayer2];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.leading.mas_equalTo(8);
        make.trailing.mas_equalTo(-8);
        make.height.mas_equalTo(132);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [preProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(0);
        make.bottom.mas_equalTo(-12);
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo((ScreenWidth - 76) / 3);
    }];
    
    [markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(0);
        make.bottom.mas_equalTo(-12);
        make.leading.mas_equalTo(preProfitLabel.mas_trailing).offset(15);
        make.width.mas_equalTo((ScreenWidth - 76) / 3);
    }];
    
    [profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(0);
        make.bottom.mas_equalTo(-12);
        make.leading.mas_equalTo(markLabel.mas_trailing).offset(15);
        make.width.mas_equalTo((ScreenWidth - 76) / 3);
    }];
}

- (void)setJiaYingModel:(XMyJiaYingModel *)jiaYingModel {
    _jiaYingModel = jiaYingModel;
    
    _titleLabel.text = [NSString stringWithFormat:@"%@", jiaYingModel.projectname];
//    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:_titleLabel.text];
//    [strM addAttributes:@{
//                         NSFontAttributeName: [XAppContext appFonts].font_13,
//                         NSForegroundColorAttributeName: [XAppContext appColors].lightGrayColor
//                         }range:NSMakeRange(_titleLabel.text.length - jiaYingModel.investid.length, jiaYingModel.investid.length)];
//    _titleLabel.attributedText = strM;
    
    [self label:_preProfitLabel withTitle:@"待收收益（元）" content:jiaYingModel.predict0 ? jiaYingModel.predict0 : @"0"  contentFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].orangeColor];
    
    [self label:_markLabel withTitle:@"匹配笔数" content:jiaYingModel.marknum0 ? jiaYingModel.marknum0 : @"0"  contentFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].orangeColor];
    
    [self label:_profitLabel withTitle:@"收益方式" content:@"收益复投"  contentFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].orangeColor];
}

@end
