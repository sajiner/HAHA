//
//  XMyMagicHeaderView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyMagicHeaderView.h"
#import "UIView+XExtension.h"

static NSString *ID = @"XMyMagicHeaderView";

@implementation XMyMagicHeaderView {
    UILabel *_mtBalanceLabel;
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    
    XMyMagicHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView = [[XMyMagicHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [XAppContext appColors].whiteColor;
        [self initElement];
    }
    return self;
}

#pragma mark - 初始化方法
- (void)initElement {
    // 魔投可用余额
    UILabel *mtBalanceLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"魔投可用余额（元）" textColor:[XAppContext appColors].grayBlackColor];
    mtBalanceLabel.numberOfLines = 0;
    mtBalanceLabel.frame = CGRectMake(0, 0, ScreenWidth, 80);
    [self.contentView addSubview:mtBalanceLabel];
    _mtBalanceLabel = mtBalanceLabel;
}

- (void)setBalance:(NSString *)balance {
    _balance = balance;
    [self label:_mtBalanceLabel withTitle:@"魔投可用余额（元）" content:(balance ? balance : @"0.00") contentFont:[XAppContext appFonts].font_20 contentColor:[XAppContext appColors].orangeColor];
}

@end
