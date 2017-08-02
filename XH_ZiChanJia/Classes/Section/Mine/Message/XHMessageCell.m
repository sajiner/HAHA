
//
//  XHMessageCell.m
//  XinHe_JinRong
//
//  Created by sajiner on 16/7/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHMessageCell.h"
#import "XHMessageModel.h"

@interface XHMessageCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation XHMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    XHMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (!cell) {
        cell = [[XHMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initElement];
    }
    return self;
}

- (void)initElement {
    
    UILabel *titleLabel = [UILabel labelWithFont:[XAppContext appFonts].font_16 text:@"系统消息" textColor:[XAppContext appColors].blackColor];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel *timeLabel = [UILabel labelWithFont:[XAppContext appFonts].font_13 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    [self.contentView addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel = timeLabel;
    
    UILabel *contentLabel = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].grayBlackColor];
    [self.contentView addSubview:contentLabel];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel = contentLabel;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    _iconView = iconView;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.leading.mas_equalTo(iconView.mas_trailing).offset(5);
        make.width.mas_equalTo(80);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleLabel.mas_trailing).offset(5);
        make.centerY.mas_equalTo(titleLabel.mas_centerY).offset(0);
        make.trailing.mas_equalTo(-15);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
        make.bottom.mas_equalTo(-12);
        make.leading.mas_equalTo(iconView.mas_trailing).offset(10);
        make.trailing.mas_equalTo(-15);
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
}

- (void)setModel:(XHMessageModel *)model {
    _model = model;
    _contentLabel.text = model.content;
    
    _timeLabel.text = model.sendTime;
    
    if (model.status == 0) {
        _iconView.image = [UIImage imageNamed:@"unread_message"];
    } else {
       _iconView.image = [UIImage imageNamed:@"read_message"];
    }
}

@end
