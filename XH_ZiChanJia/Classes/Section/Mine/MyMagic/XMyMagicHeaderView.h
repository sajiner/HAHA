//
//  XMyMagicHeaderView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMyMagicHeaderView : UITableViewHeaderFooterView

/**  创建headerView */
+ (instancetype)headerViewWithTableView: (UITableView *)tableView;

// 可用余额
@property (nonatomic, copy) NSString *balance;

@end
