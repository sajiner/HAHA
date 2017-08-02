//
//  XHomeView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeView.h"
@interface XHomeView()
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
//年Label
@property(nonatomic,strong)UILabel *yearContentLabel;

@property(nonatomic,strong)UILabel *yearLabel;
//天Label
@property(nonatomic,strong)UILabel *dayContentLabel;

@property(nonatomic,strong)UILabel *dayLabel;
//时Label
@property(nonatomic,strong)UILabel *hourContentLabel;

@property(nonatomic,strong)UILabel *hourLabel;
//分Label
@property(nonatomic,strong)UILabel *minuteContentLabel;

@property(nonatomic,strong)UILabel *minuteLabel;
@end

@implementation XHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubViews];
        self.backgroundColor = [XAppContext appColors].backgroundColor;
    }
    return self;
}

- (void)setupSubViews {
    //顶部的滚动视图
    self.topScrollView = [[UIScrollView alloc]init];
    [self addSubview:self.topScrollView];
    [self.topScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@180);
    }];
    //轮播图的四个点
    self.pageController = [[UIPageControl alloc]init];
    self.pageController.currentPage = 0;
    self.pageController.pageIndicatorTintColor = [XAppContext appColors].whiteColor;
    self.pageController.currentPageIndicatorTintColor = [XAppContext appColors].blueColor;
    [self addSubview:self.pageController];
    [self.pageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.topScrollView.mas_bottom).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    //带弧形的背景图片
    UIImageView *imgview = [[UIImageView alloc]init];
    imgview.userInteractionEnabled = YES;
#pragma mark - TODO
//    imgview.image = [UIImage imageNamed:@""];
    imgview.backgroundColor = [UIColor grayColor];
    [self addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topScrollView.mas_bottom).offset(-5);
        make.height.equalTo(@110);
    }];
    //四个按钮。暂时写死
    //银行存管
    self.btn1 = [[XCustomerButtonView alloc]init];
    self.btn1.tag = 1;
    [imgview addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgview.mas_top).offset(24);
        make.left.equalTo(imgview.mas_left);
        make.width.equalTo(@(ScreenWidth / 4));
        make.height.equalTo(@73);
    }];
    //备付金
    self.btn2 = [[XCustomerButtonView alloc]init];
    self.btn2.tag = 2;
    [imgview addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgview.mas_top).offset(24);
        make.left.equalTo(self.btn1.mas_right);
        make.width.equalTo(@(ScreenWidth / 4));
        make.height.equalTo(@73);
    }];
    //技术安全
    self.btn3 = [[XCustomerButtonView alloc]init];
    self.btn3.tag = 3;
    [imgview addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgview.mas_top).offset(24);
        make.left.equalTo(self.btn2.mas_right);
        make.width.equalTo(@(ScreenWidth / 4));
        make.height.equalTo(@73);
    }];
    //资产无忧
    self.btn4 = [[XCustomerButtonView alloc]init];
    self.btn4.tag = 4;
    [imgview addSubview:self.btn4];
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgview.mas_top).offset(24);
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
    self.notifyView = [[UIView alloc]init];
    self.notifyView.backgroundColor = [XAppContext appColors].whiteColor;
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
    }];
    //三个点
    UIImageView *moreImgView = [[UIImageView alloc]init];
    moreImgView.image = [UIImage imageNamed:@"home_more"];
    [self.notifyView addSubview:moreImgView];
    [moreImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.notifyView.mas_centerY);
        make.right.equalTo(self.notifyView.mas_right).offset(-10);
    }];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.notifyView.mas_bottom).offset(12);
        make.left.right.equalTo(self);
        make.height.equalTo(@486);
    }];
    //安全运营时间
    UIView *timeView = [[UIView alloc]init];
    [self addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@83);
    }];
    self.dayLabel = [[UILabel alloc]init];
    self.dayLabel.text = @"天";
    self.dayLabel.textColor = [XAppContext appColors].blackColor;
    self.dayLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.dayLabel];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.mas_top).offset(25);
        make.centerX.equalTo(self.mas_centerX).offset(-10);
    }];
    self.dayContentLabel = [[UILabel alloc]init];
    self.dayContentLabel.textColor = [XAppContext appColors].orangeColor;
    self.dayContentLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.dayContentLabel];
    [self.dayContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dayLabel.mas_left).offset(-10);
        make.top.equalTo(self.dayLabel.mas_top);
    }];
    self.yearLabel = [[UILabel alloc]init];
    self.yearLabel.text = @"年";
    self.yearLabel.textColor = [XAppContext appColors].blackColor;
    self.yearLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayLabel.mas_top);
        make.right.equalTo(self.dayContentLabel.mas_left).offset(-10);
    }];
    //年
    self.yearContentLabel = [[UILabel alloc]init];
    self.yearContentLabel.textColor = [XAppContext appColors].orangeColor;
    self.yearContentLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.yearContentLabel];
    [self.yearContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.yearLabel.mas_left).offset(-10);
        make.top.equalTo(self.dayLabel.mas_top);
    }];
//    self.yearLabel = [[UILabel alloc]init];
//    self.yearLabel.text = @"年";
//    self.yearLabel.textColor = [XAppContext appColors].blackColor;
//    self.yearLabel.font = [XAppContext appFonts].font_13;
//    [timeView addSubview:self.yearLabel];
//    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.yearContentLabel.mas_top);
//        make.left.equalTo(self.yearContentLabel.mas_right).offset(10);
//    }];
    //天
//    self.dayContentLabel = [[UILabel alloc]init];
//    self.dayContentLabel.textColor = [XAppContext appColors].orangeColor;
//    self.dayContentLabel.font = [XAppContext appFonts].font_13;
//    [timeView addSubview:self.dayContentLabel];
//    [self.dayContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.yearLabel.mas_right).offset(10);
//        make.top.equalTo(self.yearContentLabel.mas_top);
//    }];
//    self.dayLabel = [[UILabel alloc]init];
//    self.dayLabel.text = @"天";
//    self.dayLabel.textColor = [XAppContext appColors].blackColor;
//    self.dayLabel.font = [XAppContext appFonts].font_13;
//    [timeView addSubview:self.dayLabel];
//    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.yearContentLabel.mas_top);
//        make.left.equalTo(self.dayContentLabel.mas_right).offset(10);
//    }];
    //时
    self.hourContentLabel = [[UILabel alloc]init];
    self.hourContentLabel.textColor = [XAppContext appColors].orangeColor;
    self.hourContentLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.hourContentLabel];
    [self.hourContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(10);
        make.top.equalTo(self.dayLabel.mas_top);
    }];
    self.hourLabel = [[UILabel alloc]init];
    self.hourLabel.text = @"时";
    self.hourLabel.textColor = [XAppContext appColors].blackColor;
    self.hourLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.hourLabel];
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayLabel.mas_top);
        make.left.equalTo(self.hourContentLabel.mas_right).offset(10);
    }];
    //分
    self.minuteContentLabel = [[UILabel alloc]init];
    self.minuteContentLabel.textColor = [XAppContext appColors].orangeColor;
    self.minuteContentLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.minuteContentLabel];
    [self.minuteContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hourLabel.mas_right).offset(10);
        make.top.equalTo(self.dayLabel.mas_top);
    }];
    self.minuteLabel = [[UILabel alloc]init];
    self.minuteLabel.text = @"分";
    self.minuteLabel.textColor = [XAppContext appColors].blackColor;
    self.minuteLabel.font = [XAppContext appFonts].font_13;
    [timeView addSubview:self.minuteLabel];
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayLabel.mas_top);
        make.left.equalTo(self.minuteContentLabel.mas_right).offset(10);
    }];
    //文字“安全运营时间”
    UILabel *securityRunTime = [[UILabel alloc]init];
    securityRunTime.text = @"安全运营时间";
    securityRunTime.textColor = [XAppContext appColors].lightGrayColor;
    securityRunTime.font = [XAppContext appFonts].font_13;
    [timeView addSubview:securityRunTime];
    [securityRunTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(timeView.mas_centerX);
        make.top.equalTo(self.dayLabel.mas_bottom).offset(8);
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
- (void)setYearString:(NSString *)yearString{
    _yearString = yearString;
    self.yearContentLabel.text = yearString;
}
- (void)setDayString:(NSString *)dayString{
    _dayString = dayString;
    self.dayContentLabel.text = [NSString stringWithFormat:@"%02d",[dayString intValue]];
}
- (void)setHourString:(NSString *)hourString{
    _hourString = hourString;
    self.hourContentLabel.text = [NSString stringWithFormat:@"%02d",[hourString intValue]];
}
- (void)setMinuteString:(NSString *)minuteString{
    _minuteString = minuteString;
    self.minuteContentLabel.text = [NSString stringWithFormat:@"%02d",[minuteString intValue]];
}
@end

