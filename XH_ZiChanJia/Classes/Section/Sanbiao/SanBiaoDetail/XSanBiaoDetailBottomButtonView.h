//
//  XSanBiaoDetailBottomButtonView.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSanBiaoInvestModel.h"
#import "XSanBiaoPayListModel.h"
#import "XAssetBaoListModel.h"

@class XSanBiaoDetailBottomProjectView;
@class XSanBiaoDetailBottomWindInfoView;
@class XSanBiaoDetailBottomInvestListView;
@class XSanBiaoDetailBottomPayPlanView;

static const CGFloat XSanBiaoDetailLableWidth = 100;
static const CGFloat XSanBiaoDetailLableHeight = 40;
static const CGFloat XSanBiaoDetailLeftMargin = 15;

static inline UILabel *blueHorizenLabelWithY(CGFloat y){
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, y, 3, 20)];
    label.backgroundColor =[XAppContext appColors].blueColor;
    return label;
}



@protocol XSanBiaoDetailBottomButtonViewDelegate <NSObject>
@required
- (void)changeHeightWtihBottom:(CGFloat)bottom;
@end

@interface XSanBiaoDetailBottomButtonView : UIView

@property (nonatomic,weak) id<XSanBiaoDetailBottomButtonViewDelegate> delegate;

@property (nonatomic,strong)UIView * showView;
@property (nonatomic,strong)XSanBiaoDetailBottomProjectView *projectView;
@property (nonatomic,strong)XSanBiaoDetailBottomWindInfoView *windInfoView;
@property (nonatomic,strong)XSanBiaoDetailBottomInvestListView *investView;
@property (nonatomic,strong)XSanBiaoDetailBottomPayPlanView *planView;
@property (nonatomic,strong)XSanBiaoInvestModel *investModel;
@property (nonatomic,strong)NSArray<XSanBiaoPayListModel *> *payListArr;
@property (nonatomic,assign)BOOL showPlanViewWord;
@end

#pragma mark -  项目信息
@interface XSanBiaoDetailBottomProjectView : UIView

//借款事由
@property (nonatomic,strong)UILabel *borrowReasonLabel;

//借款金额
@property (nonatomic,strong)UILabel *loanAmountLabel;

//借款期限
@property (nonatomic,strong)UILabel *deadLineLabel;

//信用级别
@property (nonatomic,strong)UILabel *creditLevelLabel;

//还款方式
@property (nonatomic,strong)UILabel *paymentWayLabel;

//姓名
@property (nonatomic,strong)UILabel *nameLabel;

//性别
@property (nonatomic,strong)UILabel *sexLabel;

//年龄
@property (nonatomic,strong)UILabel *ageLabel;

//学历
@property (nonatomic,strong)UILabel *educationLabel;

//婚姻状况
@property (nonatomic,strong)UILabel *marriedLabel;

//现居住地
@property (nonatomic,strong)UILabel *livePlaceLabel;

//身份证信息
@property (nonatomic,strong)UILabel *IDCardLabel;

//银行信息
@property (nonatomic,strong)UILabel *bankInfoLabel;

//信用报告
@property (nonatomic,strong)UILabel *creditReportLabel;

//联系人信息
@property (nonatomic,strong)UILabel *contactsLabel;

//收入认证
@property (nonatomic,strong)UILabel *inCommonCertificationLabel;

//房产证明
@property (nonatomic,strong)UILabel *houseCertificationLabel;

//车产证明
@property (nonatomic,strong)UILabel *carCertificationLabel;

@end

#pragma mark - 风险保障计划
@interface XSanBiaoDetailBottomWindInfoView : UIView
//风控信息
@property (nonatomic,strong)UILabel *windInfoL;

@end



#pragma mark - 投资列表
@interface XSanBiaoDetailBottomInvestListView : UIView
//投资信息
@property (nonatomic,strong)UILabel *investInfoLabel;
@property (nonatomic,strong)XSanBiaoInvestModel *investModel;

@end

#pragma mark - 还款计划

@interface XSanBiaoDetailBottomPayPlanView : UIView

@property (nonatomic,strong)NSArray<XSanBiaoPayListModel *> *payListModelArr;
- (void)showPayPlanViewAlterWord;

@end


#pragma mark - 标的组成

@interface XAssetBaoListView : UIView
- (instancetype)initWithFrame:(CGRect)frame listModelArr:(NSArray<XAssetBaoListModel *> *)listModelArr;

@end




