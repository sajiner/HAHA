//
//  XSettingCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSettingCell.h"

static NSString *ID = @"XSettingCell";

@interface XSettingCell ()

// 标题
@property (nonatomic, strong) NSArray *titles;
// 图标
@property (nonatomic, strong) NSArray *icons;

@end

@implementation XSettingCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - lazy
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"实名认证", @"修改登录密码", @"手势密码管理"];
    }
    return _titles;
}

- (NSArray *)icons {
    if (!_icons) {
        _icons = @[@"setting_trueName", @"setting_loginPassword", @"setting_gesture"];
    }
    return _icons;
}

#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (_indexPath.row == 0) {
        self.backgroundColor = [XAppContext appColors].lineColor;
    } else {
        if (_indexPath.row == 1) {
            if([[UserManager User].nameChecked isEqualToString:@"1"]){
                self.detailTextLabel.text = @"已认证";
                self.detailTextLabel.textColor = [XAppContext appColors].greenColor;
            }else{
                self.detailTextLabel.text = @"未认证";
                self.detailTextLabel.textColor = [XAppContext appColors].orangeColor;
            }
        }
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.text = self.titles[_indexPath.row - 1];
        self.textLabel.textColor = [XAppContext appColors].grayBlackColor;
        self.imageView.image = [UIImage imageNamed:self.icons[_indexPath.row - 1]];
    }
}

@end
