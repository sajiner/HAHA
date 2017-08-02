//
//  XHomeHeaderView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeHeaderView.h"
@interface XHomeHeaderView()
//累计成交规模ContentLabel
@property(nonatomic,strong)UILabel *turnoverContentLabel;
//累计成交规模TitleLabel
@property(nonatomic,strong)UILabel *turnoverTitleLabel;
//累计总用户数ContentLabel
@property(nonatomic,strong)UILabel *userNumberContentLabel;
//累计总用户数TitleLabel
@property(nonatomic,strong)UILabel *userNumberTitleLabel;
//公告栏标题Label
@property(nonatomic,strong)UILabel *notifyTitleLabel;
@end
@implementation XHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubViews];
        self.backgroundColor = [XAppContext appColors].backgroundColor;
    }
    return self;
}

- (void)setupSubViews {
    //顶部的滚动视图
    self.cycleScrollView = [[XCycleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
    [self addSubview:self.cycleScrollView];
    //带弧形的背景图片
    UIImageView *imgview = [[UIImageView alloc]init];
    imgview.userInteractionEnabled = YES;
    imgview.image = [UIImage imageNamed:@"btnBackImg"];
    [self addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(-31);
        make.height.equalTo(@110);
    }];
    //四个按钮。暂时写死
    //银行存管
    self.btn1 = [[XCustomerButtonView alloc]init];
    self.btn1.tag = 0;
    [imgview addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgview.mas_top).offset(30);
        make.left.equalTo(imgview.mas_left);
        make.width.equalTo(@(ScreenWidth / 4));
        make.height.equalTo(@73);
    }];
    //备付金
    self.btn2 = [[XCustomerButtonView alloc]init];
    self.btn2.tag = 1;
    [imgview addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_top);
        make.left.equalTo(self.btn1.mas_right);
        make.width.equalTo(@(ScreenWidth / 4));
        make.height.equalTo(@73);
    }];
    //技术安全
    self.btn3 = [[XCustomerButtonView alloc]init];
    self.btn3.tag = 2;
    [imgview addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_top);
        make.left.equalTo(self.btn2.mas_right);
        make.width.equalTo(@(ScreenWidth / 4));
        make.height.equalTo(@73);
    }];
    //资产无忧
    self.btn4 = [[XCustomerButtonView alloc]init];
    self.btn4.tag = 3;
    [imgview addSubview:self.btn4];
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_top);
        make.left.equalTo(self.btn3.mas_right);
        make.width.equalTo(@(ScreenWidth / 4));
        make.height.equalTo(@73);
    }];
    //累计成交规模-累计总用户数
    UIView *containerView = [[UIView alloc]init];
    containerView.backgroundColor = [XAppContext appColors].whiteColor;
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgview.mas_bottom).offset(12);
        make.left.equalTo(self.mas_left).offset(8);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.equalTo(@54);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [XAppContext appColors].lineColor;
    [containerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).offset(8);
        make.bottom.equalTo(containerView.mas_bottom).offset(-8);
        make.centerX.equalTo(containerView.mas_centerX);
        make.width.equalTo(@1);
    }];
    //成交规模
    self.turnoverContentLabel = [[UILabel alloc]init];
    self.turnoverContentLabel.textColor = [XAppContext appColors].orangeColor;
    self.turnoverContentLabel.font = [XAppContext appFonts].font_13;
    [containerView addSubview:self.turnoverContentLabel];
    [self.turnoverContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).offset(6.5);
        make.centerX.equalTo(line.mas_centerX).multipliedBy(0.5);
    }];
    self.turnoverTitleLabel = [[UILabel alloc]init];
    self.turnoverTitleLabel.text = @"累计成交规模(元)";
    self.turnoverTitleLabel.textColor = [XAppContext appColors].lightGrayColor;
    self.turnoverTitleLabel.font = [XAppContext appFonts].font_13;
    [containerView addSubview:self.turnoverTitleLabel];
    [self.turnoverTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.turnoverContentLabel.mas_bottom).offset(9);
        make.centerX.equalTo(self.turnoverContentLabel.mas_centerX);
    }];
    //总用户数
    self.userNumberContentLabel = [[UILabel alloc]init];
    self.userNumberContentLabel.textColor = [XAppContext appColors].orangeColor;
    self.userNumberContentLabel.font = [XAppContext appFonts].font_13;
    [containerView addSubview:self.userNumberContentLabel];
    [self.userNumberContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containerView.mas_centerX).multipliedBy(1.5);
        make.top.equalTo(self.turnoverContentLabel.mas_top);
    }];
    self.userNumberTitleLabel = [[UILabel alloc]init];
    self.userNumberTitleLabel.text = @"累计总用户数(位)";
    self.userNumberTitleLabel.textColor = [XAppContext appColors].lightGrayColor;
    self.userNumberTitleLabel.font = [XAppContext appFonts].font_13;
    [containerView addSubview:self.userNumberTitleLabel];
    [self.userNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.turnoverTitleLabel.mas_top);
        make.centerX.equalTo(self.userNumberContentLabel.mas_centerX);
    }];
    //公告栏View
    self.notifyView = [[UIButton alloc]init];
    [self.notifyView setBackgroundColor:[XAppContext appColors].whiteColor];
    [self addSubview:self.notifyView];
    [self.notifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_bottom).offset(12);
        make.left.equalTo(self.mas_left).offset(8);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.equalTo(@35);
    }];
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.contentMode = UIViewContentModeScaleAspectFit;
    iconImg.image = [UIImage imageNamed:@"home_notice"];
    [self.notifyView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.notifyView.mas_centerY);
        make.left.equalTo(self.notifyView.mas_left).offset(10);
    }];
    self.notifyTitleLabel = [[UILabel alloc]init];
    self.notifyTitleLabel.textColor = [XAppContext appColors].blackColor;
    self.notifyTitleLabel.font = [XAppContext appFonts].font_14;
    [self.notifyView addSubview:self.notifyTitleLabel];
    [self.notifyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.notifyView.mas_centerY);
        make.left.equalTo(iconImg.mas_right).offset(13);
//        make.width.equalTo(@(ScreenWidth - 80));
    }];
    //三个点
    UIImageView *moreImgView = [[UIImageView alloc]init];
    moreImgView.image = [UIImage imageNamed:@"home_more"];
    [self.notifyView addSubview:moreImgView];
    [moreImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.notifyView.mas_centerY);
        make.right.equalTo(self.notifyView.mas_right).offset(-10);
    }];

}

#pragma mark - set方法
- (void)setTurnoverString:(NSString *)turnoverString{
    _turnoverString = turnoverString;
    self.turnoverContentLabel.text = turnoverString;
}
- (void)setUserNumberString:(NSString *)userNumberString{
    _userNumberString = userNumberString;
    self.userNumberContentLabel.text = userNumberString;
}
- (void)setNotifyTitleString:(NSString *)notifyTitleString{
    _notifyTitleString = notifyTitleString;
    self.notifyTitleLabel.text = notifyTitleString;
}

@end
