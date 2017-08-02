//
//  XSanBiaoTableViewCell.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSanBiaoModel.h"
@class XSanBiaoRobTimeView;

@interface XSanBiaoTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *personalLoanLabel;//借款标志
@property (nonatomic,strong) UILabel *IDLabel;//信贷ID
@property (nonatomic,strong) UILabel *profitLabel;//收益率
@property (nonatomic,strong) UILabel *deadlineLabel;//借贷期限
@property (nonatomic,strong) UILabel *deadlineDownLabel;//借贷期限下文字
@property (nonatomic,strong) UILabel *percentLabel;//比例
@property (nonatomic,strong) UILabel *percentBottomLabel;//比例下的灰色背景
@property (nonatomic,strong) UILabel *percentStrLabel;//比例文字
@property (nonatomic,strong) UILabel *residualAmountLabel;//剩余金额
@property (nonatomic,strong) UIImageView *residualAmountImageview;//投资完成前图标
@property (nonatomic,strong) UIImageView *paymentImageView;//还款还是结束图标
//@property (nonatomic,strong) XSanBiaoRobTimeView *ropTimeImageView;//开抢图片
@property (nonatomic,strong) XSanBiaoRobTimeView *ropTimeView;
@property (nonatomic,strong) XSanBiaoModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/*
 * flag 传入YES是散标页面 NO是资产包页面
 */
- (void)setModel:(XSanBiaoModel *)model flag:(BOOL)flag;
@end


@interface XSanBiaoRobTimeView : UIView
@property (nonatomic,strong)UILabel *timeLable;

@end
