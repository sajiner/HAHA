//
//  XCapitalManageCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCapitalManageCellModel;
@interface XCapitalManageCell : UITableViewCell

@property (nonatomic, strong) XCapitalManageCellModel *cellModel;
/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
