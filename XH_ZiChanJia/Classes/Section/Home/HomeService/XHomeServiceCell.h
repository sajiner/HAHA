//
//  XHomeServiceCell.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//首页的资产家服务Cell
@interface XHomeServiceCell : UITableViewCell
//detailLabel
@property(nonatomic,strong)UILabel *detailLabel;
- (void)setupIcon:(NSString *)iconName title:(NSString *)titleName havrArrow:(BOOL)haveArrow haveDetailTitle:(BOOL)haveDetailTitle;
@end
