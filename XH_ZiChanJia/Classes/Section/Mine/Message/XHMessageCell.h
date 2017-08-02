//
//  XHMessageCell.h
//  XinHe_JinRong
//
//  Created by sajiner on 16/7/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHMessageModel;
@interface XHMessageCell : UITableViewCell

@property (nonatomic, strong) XHMessageModel *model;
/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
