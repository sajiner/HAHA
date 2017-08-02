//
//  XAssetBaoDetailScrollView.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSanBiaoDetailTopView.h"
#import "XSanBiaoDetailBottomButtonView.h"
#import "XSanBiaoDetailModel.h"
#import "XSanBiaoModel.h"

@interface XAssetBaoDetailScrollView : UIScrollView

@property (nonatomic,strong)XSanBiaoDetailModel *detailModel;

//上
@property (nonatomic,strong) XSanBiaoDetailTopView *topView;

//状态图片
@property (nonatomic,strong) UIImageView *statusImageV;

//加载更多
@property (nonatomic,strong) UILabel *loadMoreLabel;

//项目名称
@property (nonatomic,strong) UILabel *personLoanL;

//信贷ID
//@property (nonatomic,strong) UILabel *personLoanIDLabel;

//匹配的标
@property (nonatomic,strong) UILabel *baoCountLabel;

//借款金额
@property (nonatomic,strong) UILabel *loanAmountLabel;

//剩余可投
@property (nonatomic,strong) UILabel *restCastLabel;

//下线时间
@property (nonatomic,strong) UILabel *deadLineL;

//加载更多按钮
@property (nonatomic,strong) UIButton *loadMoreBtn;

//更多的上下箭头
@property (nonatomic,strong) UIImageView *arrowImgV;

//标的组成
@property (nonatomic,strong)NSArray<XAssetBaoListModel *> *arrayList;

- (instancetype)initWithFrame:(CGRect)frame statusFlag:(NSInteger)p_project_status;

@end
