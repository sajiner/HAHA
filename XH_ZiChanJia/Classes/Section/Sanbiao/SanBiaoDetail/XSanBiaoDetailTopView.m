//
//  XSanBiaoDetailTopView.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoDetailTopView.h"

@implementation XSanBiaoDetailTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview{
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, ScreenWidth - 8*2, 165)];
    bgImageView.image = [UIImage imageNamed:@"sanBiao_background"];
    
    self.progressView = [[XSanBiaoDetailProgress alloc]initWithFrame:CGRectMake(ScreenWidth / 4.0, 20, ScreenWidth / 2.0, ScreenWidth / 2.0)];
    
    self.starImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star"]];
    self.starImg.frame = CGRectMake(0, 0, 31, 30);
    self.starImg.image = [UIImage imageNamed:@"sanBiao_star"];
    self.starImg.center = CGPointMake(self.progressView.center.x / 2.0, -5);
    
    //设置percentLabel
    self.percentLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.progressView.frame.size.width - 150) / 2.0, CGRectGetMaxY(self.progressView.frame) * 0.2, 150, 50)];
    self.percentLabel.textAlignment = NSTextAlignmentCenter;
    self.percentLabel.textColor = [XAppContext appColors].orangeColor;
    self.percentLabel.font = [UIFont systemFontOfSize:40];
        
    UILabel *stringLable = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"过往年化收益率" textColor:[XAppContext appColors].grayBlackColor];
    stringLable.frame =  CGRectMake((self.progressView.frame.size.width - 150) / 2.0, CGRectGetMaxY(self.percentLabel.frame) + 10, 150, 20);
    [self.progressView addSubview:stringLable];
    
    //设置textLabel
    self.textlabel = [[UILabel alloc]initWithFrame:CGRectMake((self.progressView.frame.size.width - 150) / 2.0, CGRectGetMaxY(stringLable.frame) + 8, 150, 20)];
    self.textlabel.textColor = [XAppContext appColors].grayBlackColor;
    self.textlabel.textAlignment = NSTextAlignmentCenter;
    self.textlabel.font = [XAppContext appFonts].font_14 ;
    
    
    [self addSubview:bgImageView];
    [self addSubview:self.progressView];
    [self.progressView addSubview:self.starImg];
    [self.progressView addSubview:self.percentLabel];
    [self.progressView addSubview:self.textlabel];
    
}

//set和get方法
-(void)setPercent:(NSString *)percent{
    _percent = percent;
    //添加一个“%”符号
    NSString *tempStr = [[NSString alloc]initWithFormat:@"%@%%",_percent];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:tempStr];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(tempStr.length - 1, 1)];
    
    self.percentLabel.attributedText = attrStr;
}

-(void)setText:(NSString *)text{
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"借款期限|%@个月",text]];
    [attriStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(5, attriStr.length - 7)];
    self.textlabel.attributedText = attriStr;
}
-(void)setViewBackgroundColor:(UIColor *)viewBackgroundColor{
    self.backgroundColor = viewBackgroundColor;
}

-(void)setProgressTrackColor:(UIColor *)progressTrackColor{
    self.progressView.progressTrackColor = progressTrackColor;
}
-(void)setProgressColor:(UIColor *)progressColor{
    self.progressView.progressColor = progressColor;
}
-(void)setProgressStrokeWidth:(CGFloat)progressStrokeWidth{
    self.progressView.progressStrokeWidth = progressStrokeWidth;
}

- (void)setProgressValue:(CGFloat)progressValue{
    self.progressView.progressValue = progressValue;
    [self setNeedsDisplay];
}


@end
