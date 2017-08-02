//
//  XMyMagicFooterView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyMagicFooterView.h"

static NSString *ID = @"XMyMagicFooterView";

@implementation XMyMagicFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    
    XMyMagicFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!footerView) {
        footerView = [[XMyMagicFooterView alloc] initWithReuseIdentifier:ID];
    }
    return footerView;
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
    // 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    [self.contentView addSubview:lineView];
    
    // 转出到资产家
    UIButton *logoutButton = [UIButton buttonWithTitle:@"转出到资产家" target:self action:@selector(gotoZiChanJia:)];
    logoutButton.frame = CGRectMake(15, lineView.bottom + 22, ScreenWidth - 30, 44);
    [logoutButton setTitleColor:[XAppContext appColors].whiteColor forState:UIControlStateNormal];
    [logoutButton.titleLabel setFont:[XAppContext appFonts].font_18];
    [logoutButton setBackgroundColor:[XAppContext appColors].blueColor];
    logoutButton.layer.cornerRadius = 5;
    [self.contentView addSubview:logoutButton];
}

#pragma mark - 转出到资产家
- (void)gotoZiChanJia: (UIButton *)sender {
    if ([self.myMagicFooterViewDelegate respondsToSelector:@selector(myMagicFooterView:didClickOfButton:)]) {
        [self.myMagicFooterViewDelegate myMagicFooterView:self didClickOfButton:sender];
    }
}


@end
