//
//  XMySanBiaoCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoCell.h"
#import "XMySanBiaoModel.h"
#import "XMyJiaYingModel.h"

static NSString * const ID = @"XMySanBiaoCell";
@implementation XMySanBiaoCell {
    // 项目名称
    UILabel *_projectNameLabel;
    // 投资项目ID
    UILabel *_projectIdLabel;
    // 投资资金
    UILabel *_investAmountLabel;
    // 预计收益
    UILabel *_predictMoneyLabel;
    // 到期日期
    UILabel *_lastDateLabel;
    // 已回款
    UILabel *_repayMoneyLabel;
    // 投资状态图表
    UIImageView *_stateIconView;
    // 点击查看详情
    UIImageView *_checkDetailView;
}

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XMySanBiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XMySanBiaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    
    // 投资状态图表
    UIImageView *stateIconView = [[UIImageView alloc] init];
    _stateIconView = stateIconView;
    [stateIconView sizeToFit];
    [backImageView addSubview:stateIconView];
    
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
    
    // 到期日期
    UILabel *lastDateLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _lastDateLabel = lastDateLabel;
    _lastDateLabel.numberOfLines = 0;
    [backImageView addSubview:lastDateLabel];
    
    // 预计收益
    UILabel *predictMoneyLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _predictMoneyLabel = predictMoneyLabel;
    _predictMoneyLabel.numberOfLines = 0;
    [backImageView addSubview:predictMoneyLabel];
    
    // 已回款
    UILabel *repayMoneyLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    _repayMoneyLabel = repayMoneyLabel;
    _repayMoneyLabel.numberOfLines = 0;
    [backImageView addSubview:repayMoneyLabel];
    // 点击查看详情
    UIImageView *checkDetailView = [[UIImageView alloc] init];
    checkDetailView.image = [UIImage imageNamed:@"mine_sanBiaoDetail"];
    [backImageView addSubview:checkDetailView];
    _checkDetailView = checkDetailView;
    
    // frame
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(8);
        make.top.mas_equalTo(12);
        make.trailing.mas_equalTo(-8);
        make.bottom.mas_equalTo(0);
    }];
    
    [stateIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
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
    
    [lastDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(investAmountLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
    [predictMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(17);
        make.top.mas_equalTo(investAmountLabel.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
    [repayMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(predictMoneyLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(lastDateLabel.mas_bottom).offset(15);
        make.width.mas_equalTo((ScreenWidth - 34) * 0.5);
        make.height.mas_equalTo(60);
    }];
    
    [checkDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(predictMoneyLabel.mas_bottom).offset(26);
        make.leading.mas_equalTo(17);
        make.trailing.mas_equalTo(-17);
        make.height.mas_equalTo(13);
    }];
}

- (void)setSanBiaoModel:(XMySanBiaoModel *)sanBiaoModel {
    _sanBiaoModel = sanBiaoModel;
    
    _projectNameLabel.text = sanBiaoModel.projectName;
    _projectIdLabel.text = [NSString stringWithFormat:@"ID %@", sanBiaoModel.markNumber];
    
    [self label:_investAmountLabel withTitle:@"投资资金" content:(sanBiaoModel.investAmount0 ? sanBiaoModel.investAmount0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    [self label:_predictMoneyLabel withTitle:@"预期收益" content:(sanBiaoModel.predictMoney0 ? sanBiaoModel.predictMoney0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    [self label:_repayMoneyLabel withTitle:@"已回款" content:(sanBiaoModel.repayMoney0 ? sanBiaoModel.repayMoney0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    
    if ([sanBiaoModel.projectStatus integerValue] == 10) {
        _checkDetailView.hidden = YES;
        _stateIconView.image = [UIImage imageNamed:@"mine_fail"];
        [self label:_lastDateLabel withTitle:@"期数" content:(sanBiaoModel.projectDeadline ? [NSString stringWithFormat:@"0/%@", sanBiaoModel.projectDeadline] : @"0/0") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    } else {
        [self label:_lastDateLabel withTitle:@"到期日期" content:(sanBiaoModel.lastDate0 ? sanBiaoModel.lastDate0 : @"- - -") contentFont:[XAppContext appFonts].font_15 contentColor: [XAppContext appColors].lightGrayColor];
        // 投资状态 (1-投资中，2-回款中，3-已结束, -1表示全部)
        switch ([sanBiaoModel.investStatus integerValue]) {
            case 1:
                _checkDetailView.hidden = YES;
                _stateIconView.image = [UIImage imageNamed:@"mine_invest"];
                break;
            case 2:
                _checkDetailView.hidden = NO;
                _stateIconView.image = [UIImage imageNamed:@"mine_payBack"];
                break;
            case 3:
                _checkDetailView.hidden = NO;
                _stateIconView.image = [UIImage imageNamed:@"mine_end"];
                break;
        }
    }
    _investAmountLabel.textAlignment = NSTextAlignmentLeft;
    _predictMoneyLabel.textAlignment = NSTextAlignmentLeft;
    _lastDateLabel.textAlignment = NSTextAlignmentLeft;
    _repayMoneyLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)setJiaYingModel:(XMyJiaYingModel *)jiaYingModel {
    _jiaYingModel = jiaYingModel;
    
    _projectNameLabel.text = jiaYingModel.projectname;
//    _projectIdLabel.text = [NSString stringWithFormat:@"%@", jiaYingModel.investid];
    
    [self label:_investAmountLabel withTitle:@"投资金额（元）" content:(jiaYingModel.amount0 ? jiaYingModel.amount0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    [self label:_predictMoneyLabel withTitle:@"过往年化收益率" content:(jiaYingModel.rate0 ? jiaYingModel.rate0 : @"0.00") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    [self label:_lastDateLabel withTitle:@"到期日期" content:(jiaYingModel.lastdate ? jiaYingModel.lastdate : @"- - -") contentFont:[XAppContext appFonts].font_15 contentColor: [XAppContext appColors].lightGrayColor]; 
    [self label:_repayMoneyLabel withTitle:@"项目期限" content:(jiaYingModel.projecyline0 ? jiaYingModel.projecyline0 : @"0个月") contentFont:[XAppContext appFonts].font_25 contentColor: [XAppContext appColors].orangeColor];
    _investAmountLabel.textAlignment = NSTextAlignmentLeft;
    _predictMoneyLabel.textAlignment = NSTextAlignmentLeft;
    _lastDateLabel.textAlignment = NSTextAlignmentLeft;
    _repayMoneyLabel.textAlignment = NSTextAlignmentLeft;
    
    // 投资状态 (1-投资中，2-回款中，3-已结束, -1表示全部)
    switch ([jiaYingModel.investstatus integerValue]) {
        case 1:
            _stateIconView.image = [UIImage imageNamed:@"mine_invest"];
            break;
        case 2:
            _stateIconView.image = [UIImage imageNamed:@"mine_payBack"];
            break;
        case 3:
            _stateIconView.image = [UIImage imageNamed:@"mine_end"];
            break;
    }
}

@end
