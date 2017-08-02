//
//  XSettingFooterView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSettingFooterView;
@protocol XSettingFooterViewDelegate <NSObject>

- (void)settingFooterView: (XSettingFooterView *)settingFooterView didClickOfLogoutButton: (UIButton *)logoutButton;

@end

@interface XSettingFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<XSettingFooterViewDelegate> settingFooterViewDelegate;

/**  创建footerView */
+ (instancetype)footerViewWithTableView: (UITableView *)tableView;

@end
