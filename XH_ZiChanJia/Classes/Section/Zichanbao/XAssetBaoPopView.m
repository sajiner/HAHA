//
//  XAssetBaoPopView.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAssetBaoPopView.h"

@interface XAssetBaoPopView(){
    NSString *_key;
}
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)NSMutableDictionary *blueIndexDic;
@property (nonatomic,strong)NSMutableDictionary *valueTypeDic;
@end

@implementation XAssetBaoPopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        self.blueIndexDic =[[NSMutableDictionary alloc] initWithDictionary: @{@"项目状态":@(0),@"项目期限":@(0),@"项目收益":@(0)}];
        self.valueTypeDic =[[NSMutableDictionary alloc] initWithDictionary: @{@"项目状态":@[@0,@1,@2,@3,@4],@"项目期限":@[@0,@1,@2,@3],@"项目收益":@[@0,@1,@2,@3]}];
    }
    return self;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.frame];
        _bgView.backgroundColor = [XAppContext appColors].blackColor;
        _bgView.alpha = 0.7;
    }
    return _bgView;
}
- (void)setTitles:(NSArray *)titles title:(NSString *)title key:(NSString *)key{
    [self removeSubViews];
    _key = key;
    NSInteger index = [[self.blueIndexDic objectForKey:key] integerValue];
    
    [self initElementWithTitles:titles showIndex:index];
}

- (void)removeSubViews{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] || [view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)initElementWithTitles:(NSArray *)titles showIndex:(NSInteger)index{
    
    for (NSInteger i=0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithTitle:titles[i] target:self action:@selector(popShowButton:)];
        button.backgroundColor = [XAppContext appColors].whiteColor;
        button.frame = CGRectMake(0, 40*i, ScreenWidth, 40);
        button.titleLabel.font = [XAppContext appFonts].font_14;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        if (i==index) {
            [button setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[XAppContext appColors].blackColor forState:UIControlStateNormal];
        }
        button.tag = 1000+i;
        [self addSubview:button];
        UILabel *bgLable = [[UILabel alloc] initWithFrame:CGRectMake(0, button.y, ScreenWidth, 1)];
        bgLable.backgroundColor = [XAppContext appColors].lineColor;
        [self addSubview:bgLable];
    }
}

- (void)popShowButton:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [self.blueIndexDic setValue:@(index) forKey:_key];
            if (view.tag == sender.tag) {
                [(UIButton *)view setTitleColor:[XAppContext appColors].blueColor forState:UIControlStateNormal];
            }else{
                [(UIButton *)view  setTitleColor:[XAppContext appColors].grayBlackColor forState:UIControlStateNormal];
            }
        }
    }
    
    NSInteger value = [((NSArray *)[self.valueTypeDic objectForKey:_key])[index] integerValue];
    if (_delegate && [_delegate respondsToSelector:@selector(popClickTitle:value:)]) {
        NSString *btnTitle = [sender.currentTitle isEqualToString:@"全部"]?_key:sender.currentTitle;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hideAssetBaoHeaderViewBtn" object:nil userInfo:@{@"btnTitle":btnTitle}];
        [_delegate popClickTitle:_key value:value];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter ]removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
