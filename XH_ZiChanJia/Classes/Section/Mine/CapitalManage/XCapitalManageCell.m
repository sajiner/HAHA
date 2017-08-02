//
//  XCapitalManageCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XCapitalManageCell.h"
#import "XCapitalManageCellModel.h"
#import "XCapitalManageDetailCell.h"
#import "XLeftAndRightLabelView.h"

static NSString *ID = @"XCapitalManageCell";

@interface XCapitalManageCell ()

// 交易类型
@property (nonatomic, weak) UILabel *titleLabel;
// 交易时间
@property (nonatomic, weak) UILabel *timeLabel;
// 交易金额
@property (nonatomic, weak) UILabel *moneyLabel;
// 切换图片
@property (nonatomic, weak) UIImageView *imgView;
// 展开的详情页
@property (nonatomic, weak) XCapitalManageDetailCell *detailCell;

@end

@implementation XCapitalManageCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XCapitalManageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XCapitalManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 重新init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initElement];
    }
    return self;
}

#pragma mark - 初始化
- (void)initElement {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"充值" textColor:[XAppContext appColors].grayBlackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *timeLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"9-12 19:00" textColor:[XAppContext appColors].lightGrayColor];
    [self.contentView addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel = timeLabel;
    
    UILabel *moneyLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"+100元" textColor:[XAppContext appColors].orangeColor];
    [self.contentView addSubview:moneyLabel];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    self.moneyLabel = moneyLabel;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"btn_down"];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.userInteractionEnabled = YES;
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 44, ScreenWidth - 10, 1)];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    [self.contentView addSubview:lineView];
    
    // frame
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(0);
        make.width.lessThanOrEqualTo(@(100));
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.mas_centerX).offset(-15);
        make.width.lessThanOrEqualTo(@(90));
    }];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.trailing.mas_equalTo(imgView.mas_leading).offset(0);
        make.width.lessThanOrEqualTo(@(ScreenWidth - 170));
    }];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.trailing.mas_equalTo(-10);
    }];
    
    XCapitalManageDetailCell *detailCell = [[XCapitalManageDetailCell alloc] initWithFrame:CGRectMake(10, 45, ScreenWidth - 10, 90)];
    [self.contentView addSubview:detailCell];
    self.detailCell = detailCell;
}

- (void)setCellModel:(XCapitalManageCellModel *)cellModel {
    _cellModel = cellModel;
    
    _titleLabel.text = [ResultStateDic objectForKey:cellModel.type];
    _timeLabel.text = cellModel.date0;
    _moneyLabel.text = cellModel.amount0;
    _detailCell.serialView.content = cellModel.serialNo;
    
    NSString *status;
    switch ([cellModel.status integerValue]) {
        case 1:
            status = @"交易冻结";
            break;
        case 2:
            status = @"交易成功";
            break;
        case 3:
            status = @"交易失败";
            break;
        case 4:
            status = @"放款已处理";
            break;
        case 5:
            status = @"解冻已处理";
            break;
    }
    _detailCell.statusView.content = status;
    _detailCell.hidden = !cellModel.fold;
    
    if (_cellModel.fold) {
        _imgView.transform = CGAffineTransformMakeRotation(M_PI);
        
    } else {
        _imgView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
