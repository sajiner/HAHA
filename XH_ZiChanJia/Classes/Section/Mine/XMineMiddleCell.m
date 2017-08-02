//
//  XMineMiddleCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMineMiddleCell.h"

static NSString *ID = @"XMineMiddleCell";
@implementation XMineMiddleCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XMineMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XMineMiddleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

#pragma mark - 初始化
- (void)initElement {
    //提现
    UIButton *withdrawCash = [UIButton buttonWithTitle:@"提现" target:self action:@selector(gotoWithdrawCash)];
    [withdrawCash setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
    [withdrawCash setBackgroundImage:[UIImage imageNamed:@"mine_withdrawCash"] forState:UIControlStateNormal];
    withdrawCash.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:withdrawCash];
    
    //充值
    UIButton *toppedUp = [UIButton buttonWithTitle:@"充值" target:self action:@selector(gotoToppedUp)];
    [toppedUp setTitleColor:[XAppContext appColors].whiteColor forState:UIControlStateNormal];
    [toppedUp setBackgroundImage:[UIImage imageNamed:@"mine_topped"] forState:UIControlStateNormal];
    toppedUp.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:toppedUp];
    
    [withdrawCash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(22);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(toppedUp.mas_width);
    }];
    
    [toppedUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(withdrawCash.mas_trailing).offset(15);
        make.top.mas_equalTo(22);
        make.height.mas_equalTo(44);
        make.trailing.mas_equalTo(-15);
    }];
}

#pragma mark - 充值、提现按钮点击
- (void)gotoWithdrawCash {
    if ([self.middleCellDelegate respondsToSelector:@selector(middleCell:didClickOfTypeButton:)]) {
        [self.middleCellDelegate middleCell:self didClickOfTypeButton:XButtonTypeDrawCash];
    }
}

- (void)gotoToppedUp {
    if ([self.middleCellDelegate respondsToSelector:@selector(middleCell:didClickOfTypeButton:)]) {
        [self.middleCellDelegate middleCell:self didClickOfTypeButton:XButtonTypeToppedUp];
    }
}

@end
