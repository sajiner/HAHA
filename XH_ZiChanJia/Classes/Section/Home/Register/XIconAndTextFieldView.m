//
//  XIconAndTextFieldView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XIconAndTextFieldView.h"
@interface XIconAndTextFieldView()
//icon
@property(nonatomic,strong)UIImageView *iconImgView;


@end
@implementation XIconAndTextFieldView

- (instancetype)init {
    if(self = [super init]){
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    //顶部横线
    self.topLine = [[UIView alloc]init];
    self.topLine.backgroundColor = [XAppContext appColors].lineColor;
    [self addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    //icon
    self.iconImgView = [[UIImageView alloc]init];
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.equalTo(self.iconImgView.mas_height);
    }];
    //textField
    self.textField = [[UITextField alloc]init];
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.textField setValue:[XAppContext appColors].placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[XAppContext appFonts].font_15 forKeyPath:@"_placeholderLabel.font"];
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.iconImgView.mas_right).offset(15);
        make.right.equalTo(self.mas_right);
    }];
}

- (void)setupIconImg:(NSString *)iconImgName placeHolder:(NSString *)placeHolder {
    self.iconImgView.image = [UIImage imageNamed:iconImgName];
    self.textField.placeholder = placeHolder;
}

- (void)resetTopLineWithLeftMargin:(CGFloat)leftMargin {
    [self.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@1);
    }];
}
@end
