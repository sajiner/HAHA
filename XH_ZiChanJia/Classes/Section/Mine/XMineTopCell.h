//
//  XMineTopCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMineModel.h"

@class XMineTopCell;
@protocol XMineTopCellDelegate <NSObject>

- (void)topCell: (XMineTopCell *)topCell didClickOfCheckMyMagicButton: (UIButton *)checkMyMagicButton;

@end

@interface XMineTopCell : UITableViewCell

@property (nonatomic, strong) XMineModel *mineModel;

@property (nonatomic, weak) id<XMineTopCellDelegate> topCellDelegate;

/**
 魔投可用余额
 */
@property (nonatomic, copy) NSString *mtBalance;

/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
