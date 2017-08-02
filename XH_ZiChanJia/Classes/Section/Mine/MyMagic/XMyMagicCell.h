//
//  XMyMagicCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMyMagicModel;
@interface XMyMagicCell : UITableViewCell
// 索引
@property (nonatomic, assign) NSIndexPath *indexPath;
// 模型数据
@property (nonatomic, strong) XMyMagicModel *magicModel;

/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
