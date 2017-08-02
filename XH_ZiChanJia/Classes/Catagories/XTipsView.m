//
//  XTipsView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 2016/11/23.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XTipsView.h"

@implementation XTipsView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    self.noticeImageView = [[UIImageView alloc] init];
    self.noticeImageView.image = [UIImage imageNamed:@"tips_background"];
    [self addSubview:self.noticeImageView];
    [self.noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    UIImageView *smile = [[UIImageView alloc] init];
    smile.contentMode = UIViewContentModeScaleAspectFit;
    smile.image = [UIImage imageNamed:@"tips_icon"];
    [self.noticeImageView addSubview: smile];
    [smile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noticeImageView.mas_top).offset(13);
        make.left.equalTo(self.noticeImageView.mas_left).offset(15);
    }];
    //温馨提示
    UILabel *noticeLabel = [[UILabel alloc] init];
    self.noticeLabel = noticeLabel;
    noticeLabel.font = [XAppContext appFonts].font_12;
    [self.noticeImageView addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(smile.mas_right).offset(6.5);
        make.centerY.equalTo(smile.mas_centerY);
    }];
    //横线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [XAppContext appColors].lineColor;
    [self.noticeImageView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noticeLabel.mas_bottom).offset(8);
        make.left.equalTo(smile.mas_left);
        make.right.equalTo(self.noticeImageView.mas_right).offset(-15);
        make.height.equalTo(@0.5);
    }];
    //温馨提示内容
    UILabel *noticeTextLabel = [[UILabel alloc]init];
    self.noticeTextLabel = noticeTextLabel;
    noticeTextLabel.font = [XAppContext appFonts].font_12;
    noticeTextLabel.numberOfLines = 0;
    [self.noticeImageView addSubview:noticeTextLabel];
    [noticeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeImageView.mas_left).offset(15);
        make.top.equalTo(line.mas_bottom).offset(14);
        make.right.equalTo(self.noticeImageView.mas_right).offset(-15);
    }];
    
}
- (void)setTitle:(NSString *)noticeTitle tipsContent:(NSString *)tipsContent {
    self.noticeLabel.text = noticeTitle;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[tipsContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSPlainTextDocumentType} documentAttributes:nil error:nil];
    self.noticeTextLabel.attributedText = attrStr;
    //计算label内容高度
    CGSize maxSize2 = CGSizeMake(ScreenWidth - 100, MAXFLOAT);
    // 计算文字占据的高度
    CGSize size2 = [attrStr.string boundingRectWithSize:maxSize2 options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
    self.height = size2.height + 70;
    [self.noticeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(size2.height + 70));
    }];
}

@end
