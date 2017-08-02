//
//  XAssetBaoDetailScrollView.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/21.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAssetBaoDetailScrollView.h"
#import "NSNumber+XDecimalString.h"

static const  CGFloat leftMargin = 15;
static const  CGFloat labelHeight = 40;
static const  CGFloat labelWidth = 100;

@interface XAssetBaoDetailScrollView(){
    NSInteger _p_project_status;
}
@property (nonatomic,strong)XSanBiaoDetailBottomWindInfoView * windInfoview;
@property (nonatomic,strong)XAssetBaoListView *listView;
@end

@implementation XAssetBaoDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame statusFlag:(NSInteger)p_project_status{
    self = [super initWithFrame:frame];
    if (self) {
        _p_project_status = p_project_status;
        if (_p_project_status == XAssetStatueCompleted || _p_project_status == XAssetStatueFinish) {
            self.contentSize = is_iPhone5?CGSizeMake(ScreenWidth, 1370): CGSizeMake(ScreenWidth, 1300);//60 button的高度
        }else{
            self.contentSize = is_iPhone5?CGSizeMake(ScreenWidth, 1330): CGSizeMake(ScreenWidth, 1260);//60 button的高度
        }
        
        [self initElements];
        self.backgroundColor = [XAppContext appColors].backgroundColor;
    }
    return self;
}
- (void)initElements{
    //顶部视图
    [self addSubview:self.topView];
    
    //状态图片
    self.statusImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.statusImageV.frame = CGRectMake(ScreenWidth-75 , 10, 60, 19);
    [self.topView addSubview:self.statusImageV];
    
    //中间视图
    UIView *centerBgView =  (_p_project_status == XAssetStatueCompleted || _p_project_status == XAssetStatueFinish) ?
    [self centerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, 380)]:[self centerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, 340)];
    
    [self addSubview:centerBgView];
    
    UIView * projectCourseView = [self projectViewWithFrame:CGRectMake(0, CGRectGetMaxY(centerBgView.frame), ScreenWidth, 120)];
    [self addSubview:projectCourseView];
    
    //底部视图
    [self addSubview:self.windInfoview];
    CGFloat windInfoviewH = is_iPhone5?520:450;
    self.windInfoview.frame = CGRectMake(0, CGRectGetMaxY(projectCourseView.frame) , ScreenWidth, windInfoviewH);
}

- (void)setArrayList:(NSArray<XAssetBaoListModel*> *)arrayList{
    self.baoCountLabel.text = [NSString stringWithFormat:@"  匹配%ld个标的",arrayList.count];
    CGSize size = self.contentSize;
    self.contentSize = CGSizeMake(ScreenWidth, size.height+ arrayList.count*200 +20);
    self.listView = [[XAssetBaoListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.windInfoview.frame),ScreenWidth, arrayList.count*200 +20) listModelArr:arrayList];
    [self addSubview:self.listView];
}

#pragma mark - private method
- (UIView *)centerViewWithFrame:(CGRect)frame{
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [XAppContext appColors].backgroundColor;
    
    self.personLoanL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, 0, labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:self.personLoanL];
    
//    self.personLoanIDLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].lightGrayColor frame:CGRectMake(CGRectGetMaxX(self.personLoanL.frame), 0, ScreenWidth-70-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentLeft];
//    self.personLoanIDLabel.hidden = YES;
//    [bgView addSubview:self.personLoanIDLabel];
    
    self.baoCountLabel = [UILabel labelWithFont:[XAppContext appFonts].font_12 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(CGRectGetMaxX(self.frame)-labelWidth, 10, is_iPhone5 ?70:88, labelHeight/2) textAlignment:NSTextAlignmentLeft];
    self.baoCountLabel.layer.masksToBounds = YES;
    self.baoCountLabel.layer.cornerRadius = labelHeight/4;
    self.baoCountLabel.layer.borderWidth = 0.5;
    self.baoCountLabel.layer.borderColor = [XAppContext appColors].orangeColor.CGColor;
    self.baoCountLabel.font = is_iPhone5?[XAppContext appFonts].font_11:[XAppContext appFonts].font_12;
    [bgView addSubview:self.baoCountLabel];

    //centerView
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.personLoanL.frame)+10, ScreenWidth, 120)];
    centerView.backgroundColor = [XAppContext appColors].whiteColor;
    
    UILabel *loanMoney = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"项目金额（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, 0, labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:loanMoney];
    self.loanAmountLabel =  [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(loanMoney.frame), ScreenWidth-labelWidth - 2*leftMargin,labelHeight) textAlignment:NSTextAlignmentRight];
    [centerView addSubview:self.loanAmountLabel];
    
    
    UILabel *resetCast = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"剩余可投（元）" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, CGRectGetMaxY(loanMoney.frame), labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:resetCast];
    self.restCastLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14  text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(resetCast.frame), ScreenWidth-labelWidth - 2*leftMargin, centerView.height/3) textAlignment:NSTextAlignmentRight];
    [centerView addSubview:self.restCastLabel];
    
    UILabel *joinLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"加入条件" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, CGRectGetMaxY(resetCast.frame), labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:joinLabel];
    
    UILabel * joinConditionLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].orangeColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(joinLabel.frame), ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentRight];
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:@"100.00元起投，整数倍增加"];
    [mutableStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(0, 5)];
    joinConditionLabel.attributedText = mutableStr;
    [centerView addSubview:joinConditionLabel];
    
    [centerView addSubview:[self lineLabelWithX:0 Y:0]];
    [centerView addSubview:[self lineLabelWithX:leftMargin Y:loanMoney.y]];
    [centerView addSubview:[self lineLabelWithX:leftMargin Y:resetCast.y]];
    [centerView addSubview:[self lineLabelWithX:leftMargin Y:joinLabel.y]];
    [centerView addSubview:[self lineLabelWithX:0 Y:CGRectGetMaxY(joinLabel.frame)]];
    [bgView addSubview:centerView];
    
    //bottom
    UIView *bottomView  = [[UIView alloc] init];//initWithFrame:CGRectMake(0, CGRectGetMaxY(centerView.frame)+10, ScreenWidth, 120)];
    if (_p_project_status == XAssetStatueCompleted || _p_project_status == XAssetStatueFinish) {
        bottomView.frame = CGRectMake(0, CGRectGetMaxY(centerView.frame)+10, ScreenWidth, 120);
    }else{
        bottomView.frame = CGRectMake(0, CGRectGetMaxY(centerView.frame)+10, ScreenWidth, 80);
    }
    bottomView.backgroundColor = [XAppContext appColors].whiteColor;
    
    UILabel *paymetnConditionL = [UILabel labelWithFont:[XAppContext appFonts].font_14  text:@"还款方式" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, 0, labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:paymetnConditionL];
    UILabel *principalLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14  text:@"等额本息" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(paymetnConditionL.frame), ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentRight];
    [bottomView addSubview:principalLabel];
    
    UILabel *guarwayLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"保障方式" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, CGRectGetMaxY(principalLabel.frame), labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:guarwayLabel];
    UILabel *wayLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"风险备付金" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(guarwayLabel.frame), ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentRight];
    [bottomView addSubview:wayLabel];
    
    if (_p_project_status == XAssetStatueCompleted || _p_project_status == XAssetStatueFinish) {
        UILabel *deadLineLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"下线时间" textColor:[XAppContext appColors].blackColor frame:CGRectMake(leftMargin, CGRectGetMaxY(wayLabel.frame), labelWidth, labelHeight) textAlignment:NSTextAlignmentLeft];
        [bottomView addSubview:deadLineLabel];
        self.deadLineL = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].blackColor frame:CGRectMake(labelWidth+leftMargin, CGRectGetMinY(deadLineLabel.frame), ScreenWidth-labelWidth - 2*leftMargin, labelHeight) textAlignment:NSTextAlignmentRight];
        [bottomView addSubview:self.deadLineL];
        [bottomView addSubview:[self lineLabelWithX:0 Y:0]];
        [bottomView addSubview:[self lineLabelWithX:leftMargin Y:40]];
        [bottomView addSubview:[self lineLabelWithX:leftMargin Y:80]];
        [bottomView addSubview:[self lineLabelWithX:0 Y:120]];
    }else{
        [bottomView addSubview:[self lineLabelWithX:0 Y:0]];
        [bottomView addSubview:[self lineLabelWithX:leftMargin Y:40]];
        [bottomView addSubview:[self lineLabelWithX:0 Y:80]];
    }
    [bgView addSubview:bottomView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 200 - 13)/2, CGRectGetMaxY(bottomView.frame)+10, 13, 16)];
    iconImageView.image = [UIImage imageNamed:@"bank_certify"];
    [bgView addSubview:iconImageView];
    
    UILabel *customeAlterStr = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"客户资金由恒丰银行专业存管" textColor:[XAppContext appColors].blackColor];
    customeAlterStr.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame), CGRectGetMinY(iconImageView.frame), 200, 16);
    [bgView addSubview:customeAlterStr];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,  CGRectGetMaxY(customeAlterStr.frame)+10+8, ScreenWidth - 60, 0.5)];
    lineLabel.backgroundColor = [XAppContext appColors].lightGrayColor;
    [bgView addSubview:lineLabel];
    UILabel *loadMore = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@" 滑动查看更多 " textColor:[XAppContext appColors].blackColor];
    loadMore.frame = CGRectMake((ScreenWidth- 100)/2, CGRectGetMaxY(customeAlterStr.frame)+10, 100, 16);
    loadMore.textColor = [XAppContext appColors].blueColor;
    loadMore.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [bgView addSubview:loadMore];
    
    self.arrowImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_up"]];
    self.arrowImgV.frame =CGRectMake((ScreenWidth - 12)/2, CGRectGetMaxY(loadMore.frame)+5,12, 7.5);
    [bgView addSubview:self.arrowImgV];
    
    return bgView;
}

- (UILabel *)lineLabelWithX:(CGFloat)x Y:(CGFloat)y{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, ScreenWidth-x, 1)];
    label.backgroundColor =  [XAppContext appColors].lineColor;
    return label;
}

- (UIView *)projectViewWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [XAppContext appColors].whiteColor;
    //添加项目历程
    UILabel *projectCourseL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 3, 15)];
    projectCourseL.backgroundColor =[XAppContext appColors].blueColor;
    [view addSubview:projectCourseL];
    UILabel *basicInfo = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"项目历程" textColor:[XAppContext appColors].blackColor frame:CGRectMake(15*2, CGRectGetMinY(projectCourseL.frame), 100, 20) textAlignment:NSTextAlignmentLeft];
    [view addSubview:basicInfo];
    
    CGFloat imageViewHeight = is_iPhone5?50:66;
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(projectCourseL.frame)+20, ScreenWidth - 30, imageViewHeight)];
    bottomImageView.image = [UIImage imageNamed:@"asset_project_progress"];
    [view addSubview:bottomImageView];
    return view;
}
#pragma mark - set method
- (void)setDetailModel:(XSanBiaoDetailModel *)detailModel{
    _detailModel = detailModel;
    //赋值
    CGFloat rate =  _detailModel.p_project_money == 0? 0 : (double)_detailModel.p_rated_money/(double)_detailModel.p_project_money;
    self.topView.progressValue = rate;
    self.topView.text = [NSString stringWithFormat:@"%ld",(long)_detailModel.p_project_deadline];
    self.topView.percent = [NSString stringWithFormat:@"%.2f",_detailModel.p_project_rate];
    
    CGSize size = [_detailModel.p_project_name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(ScreenWidth-200, 30) lineBreakMode:NSLineBreakByTruncatingTail];
    self.personLoanL.frame = CGRectMake(leftMargin, 0, size.width, 40);
    self.personLoanL.text = _detailModel.p_project_name;
    
//    CGSize number_size = [_detailModel.m_number sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(ScreenWidth-200, 30) lineBreakMode:NSLineBreakByTruncatingTail];

//    self.personLoanIDLabel.frame =CGRectMake(CGRectGetMaxX(self.personLoanL.frame), 0, number_size.width, labelHeight);
//    self.baoCountLabel.frame = CGRectMake(CGRectGetMaxX(self.personLoanIDLabel.frame)+10, 10, is_iPhone5 ?70:88, labelHeight/2);
//    self.personLoanIDLabel.text = [NSString stringWithFormat:@"%@",_detailModel.m_number];
    self.loanAmountLabel.text = [NSString stringWithFormat:@"%.2f",_detailModel.p_project_money];
    self.restCastLabel.text = [NSString stringWithFormat:@"%@",[[NSNumber numberWithFloat:_detailModel.p_rating_money] decimalString]];
    
    if (_p_project_status == XAssetStatueCompleted || _p_project_status == XAssetStatueFinish) {
        self.deadLineL.text = [_detailModel.p_inserting_time isEqualToString:@""]?@"":[_detailModel.p_inserting_time substringToIndex:10];
    }
}
#pragma mark - lazy
- (XSanBiaoDetailTopView *)topView{
    if (!_topView) {
        _topView = [[XSanBiaoDetailTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,200)];
        _topView.progressTrackColor = [XAppContext appColors].lightBlueColor;
        _topView.progressColor = [XAppContext appColors].blueColor;
        _topView.progressStrokeWidth = 10;
        _topView.progressValue = 0.0;
        _topView.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return _topView;
}

- (XSanBiaoDetailBottomWindInfoView *)windInfoview{
    if (!_windInfoview) {
        _windInfoview = [[XSanBiaoDetailBottomWindInfoView alloc] init];
        _windInfoview.windInfoL.text = @"风控信息";
    }
    return _windInfoview;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
