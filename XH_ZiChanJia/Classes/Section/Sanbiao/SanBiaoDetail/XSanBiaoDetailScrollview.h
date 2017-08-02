
//  XSanBiaoDetailScrollview.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSanBiaoDetailTopView.h"
#import "XSanBiaoDetailBottomButtonView.h"
#import "XSanBiaoDetailModel.h"


@interface XSanBiaoDetailScrollview : UIScrollView

@property (nonatomic,strong) XSanBiaoDetailTopView *topView;

@property (nonatomic,strong) XSanBiaoDetailBottomButtonView *bottomView;

@property (nonatomic,strong)XSanBiaoDetailModel *detailModel;

@property (nonatomic,strong)XSanBiaoDetailPersonModel *personModel;

//加载更多
@property (nonatomic,strong) UILabel *loadMoreLabel;
//项目名称
@property (nonatomic,strong) UILabel *personLoanL;

//信贷ID
@property (nonatomic,strong) UILabel *personLoanIDLabel;

//借款金额
@property (nonatomic,strong) UILabel *loanAmountLabel;

//剩余可投
@property (nonatomic,strong) UILabel *restCastLabel;

//加载更多按钮
@property (nonatomic,strong) UIButton *loadMoreBtn;

@property (nonatomic,strong) UIImageView *arrowImgV;
@end
