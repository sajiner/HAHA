//
//  XMineBottomCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMineBottomCell.h"
#import "XButton.h"

static NSString *ID = @"XMineBottomCell";

@interface XMineBottomCell ()
// 标题
@property (nonatomic, strong) NSArray *titles;
// 图标
@property (nonatomic, strong) NSArray *images;

@end

@implementation XMineBottomCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XMineBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XMineBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [XAppContext appColors].lineColor;
        [self initElement];
    }
    return self;
}

#pragma mark - 初始化
- (void)initElement {
    CGFloat margin = 1.0;
    CGFloat width = (ScreenWidth - 2 * margin) / 3;
    CGFloat height = width;
    int row = 0;
    int sec = 0;
    for (int i = 0; i < 6; i++) {
        XButton *button = [[XButton alloc] init];
        button.tag = i + 1000;
        row = i % 3;
        sec = i / 3;
        button.frame = CGRectMake((width + margin) * row, margin + (width + margin) * sec, width, height);
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[XAppContext appColors].grayBlackColor forState:UIControlStateNormal];
        button.titleLabel.font = [XAppContext appFonts].font_14;
        [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [XAppContext appColors].whiteColor;
        [self.contentView addSubview:button];
    }
}

#pragma mark - 点击事件
- (void)didSelectButton: (UIButton *)button {
    if ([self.bottomCellDelegate respondsToSelector:@selector(bottomCell:didSelectedItemAtTag:)]) {
        [self.bottomCellDelegate bottomCell:self didSelectedItemAtTag:button.tag];
    }
}

#pragma mark - lazy
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"我的散标", @"我的嘉盈", @"资金管理", @"存管账户", @"风险偏好", @"在线客服"];
    }
    return _titles;
}

- (NSArray *)images {
    if (!_images) {
        _images = @[@"mine_sanBiao", @"mine_ziChanBao", @"mine_capitalManage", @"mine_cunGuanAccount", @"mine_riskEvaluate", @"mine_online", @""];
    }
    return _images;
}

@end
