//
//  XMineBottomCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMineBottomCell;
@protocol XMineBottomCellDelegate <NSObject>
// 代理方法
- (void)bottomCell: (XMineBottomCell *)bottomCell didSelectedItemAtTag: (NSInteger)tag;

@end

@interface XMineBottomCell : UITableViewCell

@property (nonatomic, weak) id<XMineBottomCellDelegate> bottomCellDelegate;
/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
