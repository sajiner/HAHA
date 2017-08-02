//
//  XMySanBiaoHeaderView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMySanBiaoHeaderModel, XMyJiaYingHeaderModel;
@interface XMySanBiaoHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) XMySanBiaoHeaderModel *headerModel;

@property (nonatomic, strong) XMyJiaYingHeaderModel *jiaYingHeaderModel;

+ (instancetype)headerViewWithTableView: (UITableView *)tableView;

@end
