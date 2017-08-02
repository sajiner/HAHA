//
//  XSettingCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSettingCell : UITableViewCell

@property (nonatomic, assign) NSIndexPath *indexPath;

/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
