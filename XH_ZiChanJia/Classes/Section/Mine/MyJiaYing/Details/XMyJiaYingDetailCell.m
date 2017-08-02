//
//  XMyJiaYingDetailCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingDetailCell.h"
#import "XMyJiaYingDetailModel.h"

static NSString * const ID = @"XMyJiaYingDetailCell";

@implementation XMyJiaYingDetailCell {
    // 项目名称
    UILabel *_projectNameLabel;
    // 投资项目ID
    UILabel *_projectIdLabel;
    // 投资资金
    UILabel *_investAmountLabel;
    // daishou收益
    UILabel *_predictMoneyLabel;
    // 标的期限
//    UILabel *_limitLabel;
}

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XMyJiaYingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XMyJiaYingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initElement];
    }
    return self;
}

- (void)initElement {
    // 设置背景颜色
    self.contentView.backgroundColor = [XAppContext appColors].backgroundColor;
    
    // 背景图片
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"sanBiao_background"];
    [self.contentView addSubview:backImageView];
    backImageView.userInteractionEnabled = YES;
    
    // 项目名称
    UILabel *projectNameLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].blackColor];
    projectNameLabel.preferredMaxLayoutWidth = ScreenWidth - 200;
    _projectNameLabel = projectNameLabel;
    [backImageView addSubview:projectNameLabel];
    
    // 投资项目ID
    UILabel *projectIdLabel = [UILabel labelWithFont:[XAppContext appFonts].font_12 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _projectIdLabel = projectIdLabel;
    [backImageView addSubview:projectIdLabel];
    
    // 下划线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    [backImageView addSubview:lineView];
    
    // 投资资金
    UILabel *investAmountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _investAmountLabel = investAmountLabel;
    _investAmountLabel.numberOfLines = 0;
    [backImageView addSubview:investAmountLabel];
   
    // 标的期限
    UILabel *predictMoneyLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _predictMoneyLabel = predictMoneyLabel;
    _predictMoneyLabel.numberOfLines = 0;
    [backImageView addSubview:predictMoneyLabel];
    
    // 标的期限
//    UILabel *limitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
//    _limitLabel = limitLabel;
//    limitLabel.numberOfLines = 0;
//    [backImageView addSubview:limitLabel];
    
    // 借款协议
    UIButton *loanAgreement = [UIButton buttonWithTitle:@"《借款协议》" target:self action:@selector(checkLoanAgreement:)];
    [loanAgreement setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    loanAgreement.titleLabel.font = [XAppContext appFonts].font_15;
    loanAgreement.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backImageView addSubview:loanAgreement];
    
    // frame
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(8);
        make.top.mas_equalTo(12);
        make.trailing.mas_equalTo(-8);
        make.bottom.mas_equalTo(0);
    }];
    
    [projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(39);
        /// 设置其最大宽度不能大于ScreenWidth - 200
        make.width.lessThanOrEqualTo(@(ScreenWidth - 200));
    }];
    
    [projectIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(projectNameLabel.mas_trailing).offset(10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(39);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.trailing.mas_equalTo(-17);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(projectNameLabel.mas_bottom).offset(0);
    }];
    
    [investAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
    [predictMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(investAmountLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
//    [limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(17);
//        make.top.mas_equalTo(investAmountLabel.mas_bottom).offset(15);
//        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
//        make.height.mas_equalTo(60);
//    }];
    
    [loanAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(investAmountLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(investAmountLabel.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark - 借款协议
- (void)checkLoanAgreement: (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(jiaYingDetailCell:didClickOfLoanAgreement: linkString:)]) {
        [self.delegate jiaYingDetailCell:self didClickOfLoanAgreement:sender linkString:_detailModel.contracturl];
    }
}

#pragma mark - lazy
- (void)setDetailModel:(XMyJiaYingDetailModel *)detailModel {
    _detailModel = detailModel;
    
    _projectNameLabel.text = detailModel.markname;
    _projectIdLabel.text = [NSString stringWithFormat:@"ID %@", detailModel.marknum];
    
    [self label:_investAmountLabel withTitle:@"投资资金（元）" content:(detailModel.amount0 ? detailModel.amount0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    [self label:_predictMoneyLabel withTitle:@"标的期限（月）" content:(detailModel.markdeadline ? detailModel.markdeadline : @"0") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
//    [self label: _predictMoneyLabel withTitle:@"待收收益（元）" content:(detailModel.amount0 ? detailModel.amount0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    _investAmountLabel.textAlignment = NSTextAlignmentLeft;
    _predictMoneyLabel.textAlignment = NSTextAlignmentCenter;
//    _limitLabel.textAlignment = NSTextAlignmentLeft;
}




@end
