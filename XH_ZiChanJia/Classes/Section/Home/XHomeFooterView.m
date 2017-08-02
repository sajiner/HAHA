//
//  XHomeFooterView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeFooterView.h"
@interface XHomeFooterView()
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
@implementation XHomeFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubViews];
        self.backgroundColor = [XAppContext appColors].backgroundColor;
    }
    return self;
}

- (void)setupSubViews {

    //安全运营时间
    UIView *timeView = [[UIView alloc]init];
    [self addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
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
