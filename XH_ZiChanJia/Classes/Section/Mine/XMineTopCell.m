//
//  XMineTopCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMineTopCell.h"
#import "UILabel+XCustomMethod.h"
#import "XMineModel.h"
#import "UIView+XExtension.h"

static NSString *ID = @"XMineTopCell";

@implementation XMineTopCell {
    // 可用余额
    UILabel *_balanceLabel;
    // 资产总额
    UILabel *_totalAmountLabel;
    // 待收收益
    UILabel *_waitProfitLabel;
    // 累计收益
    UILabel *_addProfitLabel;
    // 魔投可用余额
    UILabel *_mtBalanceLabel;
}

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XMineTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XMineTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        [self initElement];
    }
    return self;
}

#pragma mark - 初始化
- (void)initElement {
    // 可用余额
    UILabel *balanceLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"可用余额（元）" textColor:[XAppContext appColors].grayBlackColor];
    balanceLabel.numberOfLines = 0;
    [self.contentView addSubview:balanceLabel];
    _balanceLabel = balanceLabel;
    
    // 资产总额
    UILabel *totalAmountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"资产总额" textColor:[XAppContext appColors].grayBlackColor];
    totalAmountLabel.numberOfLines = 0;
    [self.contentView addSubview:totalAmountLabel];
    _totalAmountLabel = totalAmountLabel;
    
    // 待收收益
    UILabel *waitProfitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"待收收益" textColor:[XAppContext appColors].grayBlackColor];
    waitProfitLabel.numberOfLines = 0;
    [self.contentView addSubview:waitProfitLabel];
    _waitProfitLabel = waitProfitLabel;
    
    // 累计收益
    UILabel *addProfitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"累计收益" textColor:[XAppContext appColors].grayBlackColor];
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
    
    // 灰色背景色
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [XAppContext appColors].backgroundColor;
    [self.contentView addSubview:grayView];
    
    // 两条横线
    UIView *upLine = [[UIView alloc] init];
    upLine.backgroundColor = [XAppContext appColors].lineColor;
    [grayView addSubview:upLine];
    
    UIView *downLine = [[UIView alloc] init];
    downLine.backgroundColor = [XAppContext appColors].lineColor;
    [grayView addSubview:downLine];
    
    // 魔投可用余额
    UILabel *mtBalanceLabel = [[UILabel alloc] init];
    mtBalanceLabel.text = [NSString stringWithFormat:@"魔投可用余额（元）"];
    mtBalanceLabel.textColor = [XAppContext appColors].grayBlackColor;
    mtBalanceLabel.font = [XAppContext appFonts].font_13;
    [grayView addSubview:mtBalanceLabel];
    _mtBalanceLabel = mtBalanceLabel;
    
    // 查看我的魔投
    UIButton *checkMyMagic = [UIButton buttonWithTitle:@"查看我的魔投" target:self action:@selector(gotoMyMagic:)];
    [checkMyMagic setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    checkMyMagic.titleLabel.font = [XAppContext appFonts].font_13;
    [checkMyMagic setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
    [grayView addSubview:checkMyMagic];
    
    // frame
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(52);
    }];
    
    [totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.top.mas_equalTo(balanceLabel.mas_bottom).offset(5);
        make.width.mas_equalTo((ScreenWidth - 2) / 3);
        make.height.mas_equalTo(50);
    }];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(totalAmountLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(balanceLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(totalAmountLabel.mas_bottom).offset(-10);
    }];
    
    [waitProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(leftLine.mas_trailing).offset(0);
        make.top.mas_equalTo(balanceLabel.mas_bottom).offset(5);
        make.width.mas_equalTo((ScreenWidth - 2) / 3);
        make.height.mas_equalTo(50);
    }];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(waitProfitLabel.mas_trailing).offset(0);
        make.top.mas_equalTo(balanceLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(totalAmountLabel.mas_bottom).offset(-10);
    }];
    
    [addProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(rightLine.mas_trailing).offset(0);
        make.top.mas_equalTo(balanceLabel.mas_bottom).offset(5);
        make.width.mas_equalTo((ScreenWidth - 2) / 3);
        make.height.mas_equalTo(50);
    }];
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(46);
        make.top.mas_equalTo(totalAmountLabel.mas_bottom).offset(10);
    }];
    
    [upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [mtBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.trailing.mas_equalTo(checkMyMagic.mas_leading).offset(0);
    }];
    
    [checkMyMagic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(mtBalanceLabel.mas_height).offset(0);
        make.width.mas_equalTo(100);
    }];
}

#pragma mark - 跳转到我的魔投
- (void)gotoMyMagic: (UIButton *)sender {
    if ([self.topCellDelegate respondsToSelector:@selector(topCell:didClickOfCheckMyMagicButton:)]) {
        [self.topCellDelegate topCell:self didClickOfCheckMyMagicButton:sender];
    }
}

#pragma mark - lazy
- (void)setMineModel:(XMineModel *)mineModel {
    _mineModel = mineModel;
    [self label:_balanceLabel withTitle:@"可用余额（元）" content:(mineModel.a_balance0 ? mineModel.a_balance0 : @"0.00") contentFont:[XAppContext appFonts].font_20 contentColor: [XAppContext appColors].orangeColor];
    /// 为了其他页面做的保存
    XUserModel *user = [UserManager User];
    user.balance = mineModel.a_balance0;
    user.magicUser = mineModel.u_is_magic_user;
    user.nameChecked = mineModel.u_is_real_name_checked;
    [UserManager saveWithUser:user];
    
    [self label:_totalAmountLabel withTitle:@"资产总额" content:(mineModel.a_total0 ? mineModel.a_total0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
    
    [self label:_waitProfitLabel withTitle:@"待收收益" content:(mineModel.a_interest_total_w0 ? mineModel.a_interest_total_w0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
    
    [self label:_addProfitLabel withTitle:@"累计收益" content:(mineModel.a_interest_a0 ? mineModel.a_interest_a0 : @"0.00") contentFont:[XAppContext appFonts].font_13 contentColor: [XAppContext appColors].orangeColor];
}

- (void)setMtBalance:(NSString *)mtBalance {
    _mtBalance = mtBalance;
    _mtBalanceLabel.text = [NSString stringWithFormat:@"魔投可用余额（元） %@", (mtBalance ? mtBalance : @"0.00")];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:_mtBalanceLabel.text];
    [strM addAttributes:@{
                         NSForegroundColorAttributeName: [XAppContext appColors].orangeColor
                         }range:NSMakeRange(_mtBalanceLabel.text.length - (mtBalance ? mtBalance.length : 4), (mtBalance ? mtBalance.length : 4))];
    _mtBalanceLabel.attributedText = strM;
}

@end
