//
//  XMineMiddleCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XButtonType){
    XButtonTypeDrawCash,  // 提现
    XButtonTypeToppedUp   // 充值
};

@class XMineMiddleCell;
@protocol XMineMiddleCellDelegate <NSObject>

- (void)middleCell: (XMineMiddleCell *)middleCell didClickOfTypeButton: (XButtonType)type;

@end

@interface XMineMiddleCell : UITableViewCell

@property (nonatomic, weak) id<XMineMiddleCellDelegate> middleCellDelegate;
/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
