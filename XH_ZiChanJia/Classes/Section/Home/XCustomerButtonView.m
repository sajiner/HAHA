//
//  XCustomerButtonView.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XCustomerButtonView.h"
@interface XCustomerButtonView()
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *titleLbl;

@end
@implementation XCustomerButtonView

- (instancetype)init {
    if(self = [super init]){
        [self setupSubViews];
//        self.backgroundColor = [XAppContext appColors].whiteColor;
    }
    return self;
}

- (void)setupSubViews {
    self.btn = [[UIButton alloc]init];
    [self.btn sizeToFit];
    self.btn.userInteractionEnabled= NO;
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    self.titleLbl = [[UILabel alloc]init];
    self.titleLbl.textColor = [XAppContext appColors].blackColor;
    self.titleLbl.font = [XAppContext appFonts].font_14;
    [self addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn.mas_bottom).offset(8);
        make.centerX.equalTo(self.mas_centerX);
    }];

}

- (void)setupTitle: (NSString *)title imgName:(NSString *)imgName target: (id)target action: (SEL)action {
    self.titleLbl.text = title;
    [self.btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}
@end
