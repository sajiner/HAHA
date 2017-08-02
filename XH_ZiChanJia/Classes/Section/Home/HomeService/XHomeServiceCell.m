//
//  XHomeServiceCell.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeServiceCell.h"
@interface XHomeServiceCell()
//iconImgView
@property(nonatomic,strong)UIImageView *iconImgView;
//titleLabel
@property(nonatomic,strong)UILabel *titleLabel;
//arrowImgView
@property(nonatomic,strong)UIImageView *arrowImgView;
@end
@implementation XHomeServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupSubViews];
        self.contentView.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return self;
}

- (void)setupSubViews {
    //icon
    self.iconImgView = [[UIImageView alloc]init];
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    //titleLabel
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [XAppContext appColors].blackColor;
    self.titleLabel.font = [XAppContext appFonts].font_15;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.iconImgView.mas_right).offset(15);
    }];
    //arrowImgView
    self.arrowImgView = [[UIImageView alloc]init];
    self.arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.arrowImgView.image = [UIImage imageNamed:@"btn_down"];
    self.arrowImgView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.contentView addSubview:self.arrowImgView];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    //detailLabel
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.textColor = [XAppContext appColors].blueColor;
    self.detailLabel.font = [XAppContext appFonts].font_15;
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.arrowImgView.mas_left).offset(-10);
    }];
    
}

- (void)setupIcon:(NSString *)iconName title:(NSString *)titleName havrArrow:(BOOL)haveArrow haveDetailTitle:(BOOL)haveDetailTitle {
    self.iconImgView.image = [UIImage imageNamed:iconName];
    self.titleLabel.text = titleName;
    if(!haveArrow){
        self.arrowImgView.hidden = YES;
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
    }else{
        if(!haveDetailTitle){
            self.detailLabel.hidden = YES;
        }
    }
    
}
@end
