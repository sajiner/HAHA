//
//  XAssetBaoHeaderView.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAssetBaoHeaderView.h"

@interface XAssetBaoHeaderView(){
    NSArray * _titlesArr;
    NSInteger _selectBtnTag;
    NSArray * _btnTitles;
}

@end


@implementation XAssetBaoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titlesArr = @[@[@"全部",@"投标中",@"即将上线",@"投标完成",@"已结束"],@[@"全部",@"0-3个月",@"3-6个月",@"6-12个月"],@[@"全部",@"9%以下",@"9%-10%",@"10%-11%"]];
        self.backgroundColor = [UIColor whiteColor];
        [self initElement];
    }
    return self;
}
- (void)initElement{
    _btnTitles = @[@"项目状态",@"项目期限",@"项目收益"];
    CGFloat buttonW = ScreenWidth/3;
    CGFloat buttonH = 40;
    for (NSInteger i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithTitle:_btnTitles[i] target:self action:@selector(btnCLick:)];
        button.frame = CGRectMake(buttonW * i, 0, buttonW, buttonH);
        [button setTitleColor:[XAppContext appColors].blackColor forState:UIControlStateNormal];
        button.titleLabel.font = is_iPhone5?[XAppContext appFonts].font_13: [XAppContext appFonts].font_14;
        [button setTitleColor:[XAppContext appColors].blackColor forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        button.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
        [button setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        //设置位置
        button.imageEdgeInsets = UIEdgeInsetsMake(0, buttonW-15, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        
        button.tag =  1000+i;
        [self addSubview:button];
        
        if (i!= 3) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), 5, 1, 30)];
            label.backgroundColor = [XAppContext appColors].lineColor;
            [self addSubview:label];
        }
        
    }
    self.layer.borderColor = [XAppContext appColors].lineColor.CGColor;
    self.layer.borderWidth = 0.5;
    
    _selectBtnTag = 1000;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideBtn:) name:@"hideAssetBaoHeaderViewBtn" object:nil];
}
- (void)hideBtn:(NSNotification *)notitfa{
    NSDictionary *dic = notitfa.userInfo;
    
    UIButton *btn = [self viewWithTag:_selectBtnTag];
    [btn setTitle:[dic objectForKey:@"btnTitle"] forState:UIControlStateNormal];
    [self btnCLick:btn];
    
}

- (void)btnCLick:(UIButton *)sender{
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (sender.tag == view.tag) {
                if ([((UIButton *)view).currentImage isEqual: [UIImage imageNamed:@"arrow_up"]]) {
                    [((UIButton *)view) setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
                    [((UIButton *)view) setTitleColor:[XAppContext appColors].blackColor forState:UIControlStateNormal];
                    
                    [self hidePopView];
                }else{
                    [((UIButton *)view) setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
                    [((UIButton *)view) setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
                    
                    [self showWithTag:sender.tag title:((UIButton *)view).currentTitle key:_btnTitles[sender.tag - 1000]];
                    _selectBtnTag = sender.tag;
                }
            }else{
                [((UIButton *)view) setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
                [((UIButton *)view) setTitleColor:[XAppContext appColors].blackColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)showWithTag:(NSInteger)tag title:(NSString *)title key:(NSString *)key{
    if (_delegate && [_delegate respondsToSelector:@selector(showPopviewButtonTitle:title:key:)]) {
        [_delegate showPopviewButtonTitle:_titlesArr[tag - 1000] title:title key:key];
    }
}

- (void)hidePopView{
    if (_delegate &&[_delegate respondsToSelector:@selector(hidePopView)]) {
        [_delegate hidePopView];
    }
}


@end
