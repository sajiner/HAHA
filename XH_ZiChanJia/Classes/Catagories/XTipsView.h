//
//  XTipsView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/11/23.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTipsView : UIView
@property(nonatomic,strong)UILabel *noticeLabel;
@property(nonatomic,strong)UILabel *noticeTextLabel;
@property(nonatomic,strong)UIImageView *noticeImageView;
- (void)setTitle:(NSString *)noticeTitle tipsContent:(NSString *)tipsContent;
@end
