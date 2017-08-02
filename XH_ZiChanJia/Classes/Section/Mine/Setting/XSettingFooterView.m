//
//  XSettingFooterView.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSettingFooterView.h"

static NSString *ID = @"XSettingFooterView";

@implementation XSettingFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    
    XSettingFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!footerView) {
        footerView = [[XSettingFooterView alloc] initWithReuseIdentifier:ID];
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
    
    // 安全退出
    UIButton *logoutButton = [UIButton buttonWithTitle:@"安全退出" target:self action:@selector(logout:)];
    logoutButton.frame = CGRectMake(15, lineView.bottom + 22, ScreenWidth - 30, 44);
    [logoutButton setTitleColor:[XAppContext appColors].whiteColor forState:UIControlStateNormal];
    [logoutButton.titleLabel setFont:[XAppContext appFonts].font_18];
    [logoutButton setBackgroundColor:[XAppContext appColors].blueColor];
    logoutButton.layer.cornerRadius = 5;
    [self.contentView addSubview:logoutButton];
}

#pragma mark - 安全退出
- (void)logout: (UIButton *)sender {
    if ([self.settingFooterViewDelegate respondsToSelector:@selector(settingFooterView:didClickOfLogoutButton:)]) {
        [self.settingFooterViewDelegate settingFooterView:self didClickOfLogoutButton:sender];
    }
}

@end
