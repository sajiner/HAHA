//
//  XMyMagicFooterView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMyMagicFooterView;
@protocol XMyMagicFooterViewDelegate <NSObject>

- (void)myMagicFooterView: (XMyMagicFooterView *)myMagicFooterView didClickOfButton: (UIButton *)sneder;

@end

@interface XMyMagicFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<XMyMagicFooterViewDelegate> myMagicFooterViewDelegate;
/**  创建footerView */
+ (instancetype)footerViewWithTableView: (UITableView *)tableView;

@end
