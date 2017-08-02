//
//  XMySanBiaoDetailView.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/13.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMySanBiaoDetailView, XMySanBiaoModel, XMySanBiaoDetailModel, XMySanBiaoReturnPlanModel;
@protocol XMySanBiaoDetailViewDelegate <NSObject>

- (void)mySanBiaoDetailView: (XMySanBiaoDetailView *)mySanBiaoDetailView didClickOfLoanProtocol: (UIButton *)LoanProtocolBtn;

@end

@interface XMySanBiaoDetailView : UIScrollView

@property (nonatomic, weak) id<XMySanBiaoDetailViewDelegate> mySanBiaoDetailViewDelegate;
// 散标列表model
@property (nonatomic, strong) XMySanBiaoModel *sanBiaoModel;
// 散标详情model
@property (nonatomic, strong) XMySanBiaoDetailModel *detailModel;
// 汇款计划model
@property (nonatomic, strong) XMySanBiaoReturnPlanModel *planModel;
// view的高度
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithFrame:(CGRect)frame planNums: (NSUInteger)planNums;

@end
