//
//  XCapitalManageDetailCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XCapitalManageDetailCell.h"
#import "XLeftAndRightLabelView.h"

@implementation XCapitalManageDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElement];
    }
    return self;
}

- (void)initElement {
    
    XLeftAndRightLabelView *serialView = [XLeftAndRightLabelView viewWithTitleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].grayBlackColor contentFont:[XAppContext appFonts].font_15 title:@"交易流水号"];
    serialView.backgroundColor = [XAppContext appColors].lightBlueColor;
    [self addSubview:serialView];
    _serialView = serialView;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView];
    
    XLeftAndRightLabelView *statusView = [XLeftAndRightLabelView viewWithTitleColor:[XAppContext appColors].grayBlackColor titleFont:[XAppContext appFonts].font_15 contentColor:[XAppContext appColors].grayBlackColor contentFont:[XAppContext appFonts].font_15 title:@"交易状态"];
    statusView.backgroundColor = [XAppContext appColors].lightBlueColor;
    [self addSubview:statusView];
    _statusView = statusView;
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:lineView1];
    
    [serialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serialView.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(statusView.mas_bottom).offset(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

@end
