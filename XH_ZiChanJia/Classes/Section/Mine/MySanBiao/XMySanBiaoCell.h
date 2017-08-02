//
//  XMySanBiaoCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMySanBiaoModel, XMyJiaYingModel;
@interface XMySanBiaoCell : UITableViewCell

@property (nonatomic, strong) XMySanBiaoModel *sanBiaoModel;

@property (nonatomic, strong) XMyJiaYingModel *jiaYingModel;

/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
