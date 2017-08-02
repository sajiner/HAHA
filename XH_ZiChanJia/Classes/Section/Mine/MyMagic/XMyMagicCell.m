//
//  XMyMagicCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyMagicCell.h"
#import "XMyMagicModel.h"

static NSString *ID = @"XMyMagicCell";

@interface XMyMagicCell ()
// 标题
@property (nonatomic, strong) NSArray *titles;
// 收益数据
@property (nonatomic, strong) NSArray *contents;

@end

@implementation XMyMagicCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XMyMagicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XMyMagicCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - lazy
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"魔投资产总额（元）", @"累计收益（元）", @"待收收益（元）"];
    }
    return _titles;
}

- (NSArray *)contents {
    if (!_contents) {
       _contents = @[(_magicModel.signUserTotal0 ? _magicModel.signUserTotal0 : @"0.00"), (_magicModel.signUserInvestA0 ? _magicModel.signUserInvestA0 : @"0.00"), (_magicModel.signUserInterestTotalW0 ? _magicModel.signUserInterestTotalW0 : @"0.00")];
    }
    return _contents;
}


#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (_indexPath.row == 0) {
        self.backgroundColor = [XAppContext appColors].lineColor;
    } else {
        self.textLabel.attributedText = [self.titles[_indexPath.row - 1] stringWithFont:[XAppContext appFonts].font_15 yuanFont:[XAppContext appFonts].font_12 stringColor:[XAppContext appColors].grayBlackColor yuanColor:[XAppContext appColors].lightGrayColor];
        self.detailTextLabel.text = self.contents[indexPath.row - 1];
        self.detailTextLabel.textColor = [XAppContext appColors].orangeColor;
    }
}

@end
