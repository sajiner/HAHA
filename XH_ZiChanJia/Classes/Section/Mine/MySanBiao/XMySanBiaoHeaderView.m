//
//  XMySanBiaoHeaderView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoHeaderView.h"
#import "UIView+XExtension.h"
#import "XMySanBiaoHeaderModel.h"
#import "XMyJiaYingHeaderModel.h"

static NSString * const ID = @"XMySanBiaoHeaderView";

@implementation XMySanBiaoHeaderView {
    // 资产总额
    UILabel *_totalAmountLabel;
    // 待收收益
    UILabel *_waitProfitLabel;
    // 累计收益
    UILabel *_addProfitLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [XAppContext appColors].whiteColor;
        [self initElement];
    }
    return self;
}

+ (instancetype)headerViewWithTableView: (UITableView *)tableView {
    XMySanBiaoHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView = [[XMySanBiaoHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

- (void)initElement {
    // 待收本金
    UILabel *totalAmountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"待收本金（元）" textColor:[XAppContext appColors].grayBlackColor];
    totalAmountLabel.numberOfLines = 0;
    [self.contentView addSubview:totalAmountLabel];
    _totalAmountLabel = totalAmountLabel;
    
    // 待收收益
    UILabel *waitProfitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"待收收益（元）" textColor:[XAppContext appColors].grayBlackColor];
    waitProfitLabel.numberOfLines = 0;
    [self.contentView addSubview:waitProfitLabel];
    _waitProfitLabel = waitProfitLabel;
    
    // 累计收益
    UILabel *addProfitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"累计收益（元）" textColor:[XAppContext appColors].grayBlackColor];
    addProfitLabel.numberOfLines = 0;
    [self.contentView addSubview:addProfitLabel];
    _addProfitLabel = addProfitLabel;
    
    // 两条竖线
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.contentView addSubview:leftLine];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [XAppContext appColors].lineColor;
    [self.contentView addSubview:rightLine];
    
    [totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((ScreenWidth - 2) / 3);
        make.bottom.mas_equalTo(0);
    }];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(totalAmountLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(-15);
    }];
    
    [waitProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(leftLine.mas_trailing).offset(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((ScreenWidth - 2) / 3);
        make.bottom.mas_equalTo(0);
    }];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(waitProfitLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(-15);
    }];
    
    [addProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(rightLine.mas_trailing).offset(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((ScreenWidth - 2) / 3);
        make.bottom.mas_equalTo(0);;
    }];
}

- (void)setHeaderModel:(XMySanBiaoHeaderModel *)headerModel {
    _headerModel = headerModel;
    
    [self label:_totalAmountLabel withTitle:@"待收本金（元）" content:(headerModel.waitPaymentAmount0 ? headerModel.waitPaymentAmount0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
    [self label:_waitProfitLabel withTitle:@"待收收益（元）" content:(headerModel.waitPaymentInterest0 ? headerModel.waitPaymentInterest0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
    [self label:_addProfitLabel withTitle:@"累计收益（元）" content:(headerModel.endPaymentInterest0 ? headerModel.endPaymentInterest0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
}

- (void)setJiaYingHeaderModel:(XMyJiaYingHeaderModel *)jiaYingHeaderModel {
    _jiaYingHeaderModel = jiaYingHeaderModel;
    
    [self label:_totalAmountLabel withTitle:@"待收本金（元）" content:(jiaYingHeaderModel.investamonut0 ? jiaYingHeaderModel.investamonut0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
    [self label:_waitProfitLabel withTitle:@"待收收益（元）" content:(jiaYingHeaderModel.predictMoney0 ? jiaYingHeaderModel.predictMoney0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
    [self label:_addProfitLabel withTitle:@"累计收益（元）" content:(jiaYingHeaderModel.endPredictMoney0 ? jiaYingHeaderModel.endPredictMoney0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
}

@end
