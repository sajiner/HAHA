 //
//  XSanBiaoTableViewCell.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoTableViewCell.h"
#import "NSNumber+XDecimalString.h"

static NSString *reuseId = @"XSanBiaoTableViewCell";
static const CGFloat leftMargin =15;
static const CGFloat labelWidth =100;

@implementation XSanBiaoTableViewCell{
    UIImageView *_bgImageView;
    UILabel *_idDetailLabel;
}

#pragma mark - create cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XSanBiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[XSanBiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return cell;
}
#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [XAppContext appColors].backgroundColor;
        [self initElements];
    }
    return  self;
}

- (void)initElements{
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, ScreenWidth - 8*2, 165)];
    _bgImageView.image = [UIImage imageNamed:@"sanBiao_background"];
    [self.contentView addSubview:_bgImageView];
    //个人信贷
    self.personalLoanLabel = [UILabel labelWithFont:[XAppContext appFonts].font_15 text:@"" textColor:[XAppContext appColors].blackColor];
    self.personalLoanLabel.frame = CGRectMake(leftMargin, 12, labelWidth, 30);
    self.personalLoanLabel.textAlignment = NSTextAlignmentLeft;
    [_bgImageView addSubview:self.personalLoanLabel];
    
    self.IDLabel = [UILabel labelWithFont:[XAppContext appFonts].font_12 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    self.IDLabel.textAlignment = NSTextAlignmentLeft;
    [_bgImageView addSubview:self.IDLabel];
    
    
    _idDetailLabel = [UILabel labelWithFont:[XAppContext appFonts].font_12 text:@"等额本息" textColor:[XAppContext appColors].lightGrayColor];
    _idDetailLabel.textAlignment = NSTextAlignmentLeft;
    _idDetailLabel.frame = CGRectMake(ScreenWidth -labelWidth/3*2, CGRectGetMinY(self.personalLoanLabel.frame), labelWidth/3*2, 30);
    [_bgImageView addSubview:_idDetailLabel];
    
    UILabel *personDownGrayLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(self.personalLoanLabel.frame), ScreenWidth - 2*leftMargin, 1)];
    personDownGrayLabel.backgroundColor = [XAppContext appColors].lineColor;
    [_bgImageView addSubview:personDownGrayLabel];
        
    //利率
    self.profitLabel = [UILabel labelWithFont:[XAppContext appFonts].font_25 text:@"" textColor:[XAppContext appColors].orangeColor];
    self.profitLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(personDownGrayLabel.frame)+20,labelWidth, 25);
    self.profitLabel.textAlignment = NSTextAlignmentLeft;
    [_bgImageView addSubview:self.profitLabel];

    //期限
    self.deadlineLabel = [UILabel labelWithFont:[XAppContext appFonts].font_20 text:@"" textColor:[XAppContext appColors].lightGrayColor];
    self.deadlineLabel.frame = CGRectMake(ScreenWidth -2 * leftMargin - labelWidth, CGRectGetMinY(self.profitLabel.frame), labelWidth, 20);
    self.deadlineLabel.textAlignment = NSTextAlignmentRight;
    [_bgImageView addSubview:self.deadlineLabel];
    
    UILabel *profitDownLabel = [UILabel labelWithFont:[XAppContext appFonts].font_12 text:@"过往年化收益率" textColor:[XAppContext appColors].lightGrayColor];
    profitDownLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.profitLabel.frame)+10, 100, 15);
    [_bgImageView addSubview:profitDownLabel];

    //借款期限
    self.deadlineDownLabel = [UILabel labelWithFont:[XAppContext appFonts].font_12 text:@"借款期限" textColor:[XAppContext appColors].lightGrayColor];
    self.deadlineDownLabel.frame = CGRectMake(CGRectGetMinX(self.deadlineLabel.frame), CGRectGetMinY(profitDownLabel.frame), labelWidth, 15);
    self.deadlineDownLabel.textAlignment = NSTextAlignmentRight;
    [_bgImageView addSubview:self.deadlineDownLabel];
    
    //显示图标 还款还是结束
    self.paymentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 2*leftMargin - 70, CGRectGetMinY(self.deadlineLabel.frame), 70, 70)];
    [_bgImageView addSubview:self.paymentImageView];
    
    //开抢图片
    self.ropTimeView = [[XSanBiaoRobTimeView alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(profitDownLabel.frame)+20, labelWidth+20, 15)];
    [_bgImageView addSubview:self.ropTimeView];
    
    
    //显示的进度条
    CGFloat percentWidth = is_iPhone5? 130: 150;
    self.percentBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(self.deadlineLabel.frame)+20+ 10 + 15, percentWidth, 5)];
    self.percentBottomLabel.backgroundColor = [XAppContext appColors].lightGrayColor;
    self.percentBottomLabel.layer.masksToBounds = YES;
    self.percentBottomLabel.layer.cornerRadius = 2.5;
    [_bgImageView addSubview:self.percentBottomLabel];
    
    self.percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMinY(self.percentBottomLabel.frame), 10, 5)];
    self.percentLabel.backgroundColor = [XAppContext appColors].blueColor;
    self.percentLabel.layer.masksToBounds = YES;
    self.percentLabel.layer.cornerRadius = 2.5;
    [_bgImageView addSubview:self.percentLabel];
    
    //进度条后的显示比例
    self.percentStrLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:12] text:@"" textColor:[XAppContext appColors].blueColor];
    self.percentStrLabel.frame = CGRectMake(CGRectGetMaxX(self.percentBottomLabel.frame)+5, CGRectGetMinY(self.percentLabel.frame)-4, 50, 12);
    [_bgImageView addSubview:self.percentStrLabel];
    
    //剩余金额
    self.residualAmountLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:12] text:@"" textColor:[XAppContext appColors].lightGrayColor];
    self.residualAmountLabel.frame = CGRectMake(ScreenWidth-labelWidth- 2* leftMargin, CGRectGetMinY(self.percentStrLabel.frame), labelWidth, 12);
    self.residualAmountLabel.textAlignment = NSTextAlignmentRight;
    [_bgImageView addSubview:self.residualAmountLabel];
    
    //投资完成前图标
    self.residualAmountImageview = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.residualAmountLabel.frame)-15, CGRectGetMinY(self.residualAmountLabel.frame), 15, 15)];
    self.residualAmountImageview.image = [UIImage imageNamed:@"sanbiao_investCompelte"];
    [_bgImageView addSubview:self.residualAmountImageview];
}

#pragma mark - set model
- (void)setModel:(XSanBiaoModel *)model flag:(BOOL)flag{
    _model = model;
    
    CGSize size = [_model.p_project_name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(ScreenWidth-200, 30) lineBreakMode:NSLineBreakByTruncatingTail];
    self.personalLoanLabel.frame = CGRectMake(leftMargin, 12, size.width, 30);;
    self.personalLoanLabel.text = _model.p_project_name;
    self.IDLabel.frame = CGRectMake(CGRectGetMaxX(self.personalLoanLabel.frame)+leftMargin, CGRectGetMinY(self.personalLoanLabel.frame), 2*labelWidth, 30);
    
    _idDetailLabel.hidden = flag;

    self.IDLabel.text = flag == YES? [NSString stringWithFormat:@"ID %@",_model.p_project_number]:[NSString stringWithFormat:@"%@",_model.p_project_number];
    self.profitLabel.text = [NSString stringWithFormat:@"%.2f%%",[_model.p_project_rate doubleValue]];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld个月",(long)_model.p_project_deadline]];
    [attributeStr  addAttribute:NSFontAttributeName value:[XAppContext appFonts].font_20 range:NSMakeRange(0, attributeStr.length- 2)];
    [attributeStr  addAttribute:NSFontAttributeName value:[XAppContext appFonts].font_14 range:NSMakeRange(attributeStr.length- 2, 2)];
    [attributeStr  addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].blackColor range:NSMakeRange(0, attributeStr.length- 2)];
    self.deadlineLabel.attributedText = attributeStr;
    
    self.deadlineLabel.frame =CGRectMake(ScreenWidth -2 * leftMargin - labelWidth, CGRectGetMinY(self.profitLabel.frame), labelWidth, 20);
    self.deadlineDownLabel.frame = CGRectMake(CGRectGetMinX(self.deadlineLabel.frame), CGRectGetMinY(self.profitLabel.frame)+ 10 +25, labelWidth, 15);
    self.residualAmountLabel.frame = CGRectMake(ScreenWidth-labelWidth- 2* leftMargin, CGRectGetMinY(self.percentStrLabel.frame), labelWidth, 12);
    self.deadlineDownLabel.textAlignment = self.deadlineLabel.textAlignment = NSTextAlignmentRight;
    
    self.percentLabel.hidden =
    self.percentBottomLabel.hidden =
    self.percentStrLabel.hidden =
    self.residualAmountLabel.hidden =
    self.residualAmountImageview.hidden =
    self.ropTimeView.hidden =
    self.paymentImageView.hidden =NO;
    if (flag) {
        switch (_model.m_project_status) {
            case XSanBiaoProjectStatueStartGrab:{
                self.percentBottomLabel.hidden =
                self.residualAmountImageview.hidden=
                self.percentLabel.hidden =
                self.percentStrLabel.hidden =
                self.paymentImageView.hidden = YES;
                
                self.ropTimeView.timeLable.text = [NSString stringWithFormat:@"%@开抢",[_model.p_start_time substringWithRange:NSMakeRange(11, 5)]];
                self.residualAmountLabel.attributedText = [self atrributWithStr:[NSString stringWithFormat:@"%@",[[NSNumber numberWithFloat:_model.p_project_money] decimalString]]];
                break;
            }
            case XSanBiaoProjectStatueInvestment:{
                self.ropTimeView.hidden =
                self.residualAmountImageview.hidden =
                self.ropTimeView.hidden =
                self.paymentImageView.hidden = YES;
                
                CGFloat rate =  _model.p_project_money == 0? 0 : (double)_model.p_rated_money/(double)_model.p_project_money;
                self.percentLabel.frame = CGRectMake(leftMargin, CGRectGetMinY(self.percentBottomLabel.frame), CGRectGetWidth(self.percentBottomLabel.frame)*rate, 5);
                self.percentStrLabel.text = [NSString stringWithFormat:@"%.2f%%",(rate * 100)];
                ;
                self.residualAmountLabel.attributedText = [self atrributWithStr:[NSString stringWithFormat:@"%@",[[NSNumber numberWithFloat:_model.p_rating_money] decimalString]]];
                break;
            }
            case XSanBiaoProjectStatueCompleted:{
                self.paymentImageView.hidden =self.ropTimeView.hidden = YES;
                
                self.percentLabel.frame = self.percentBottomLabel.frame ;
                
                self.percentStrLabel.text = @"100%";
                self.residualAmountLabel.text = @"投资完成";
                self.residualAmountLabel.frame = CGRectMake(ScreenWidth-labelWidth/2- 2* leftMargin, CGRectGetMinY(self.percentStrLabel.frame), labelWidth/2, 12);
                self.residualAmountImageview.frame = CGRectMake(CGRectGetMinX(self.residualAmountLabel.frame)-15, CGRectGetMinY(self.residualAmountLabel.frame), 15, 15);
                break;
            }
            case XSanBiaoProjectStatueRepayment:
            case XSanBiaoProjectStatueEndPass:
            case XSanBiaoProjectStatueEnd:{
                CGFloat leftM = is_iPhone5?ScreenWidth - 2*leftMargin - labelWidth- 60:ScreenWidth - 2*leftMargin - labelWidth- 100;
                
                self.deadlineLabel.frame = CGRectMake(leftM, CGRectGetMinY(self.profitLabel.frame), labelWidth, 20);
                self.deadlineDownLabel.frame = CGRectMake(CGRectGetMinX(self.deadlineLabel.frame), CGRectGetMinY(self.profitLabel.frame)+ 10 +25, labelWidth, 15);;
                
                self.deadlineDownLabel.textAlignment = self.deadlineLabel.textAlignment = NSTextAlignmentLeft;
                
                self.percentLabel.hidden =
                self.percentBottomLabel.hidden =
                self.percentStrLabel.hidden =
                self.residualAmountLabel.hidden =
                self.residualAmountImageview.hidden =
                self.ropTimeView.hidden =YES;
                
                if (_model.m_project_status == XSanBiaoProjectStatueEndPass) {
                    self.paymentImageView.image = [UIImage imageNamed:@"sanbiao_floater"];
                }
                else if (_model.m_project_status == XSanBiaoProjectStatueEnd ) {
                    self.paymentImageView.image = [UIImage imageNamed:@"sanbiao_finished"];
                }else{
                    self.paymentImageView.image = [UIImage imageNamed:@"sanbiao_payment"];
                }
                
                break;
            }
        }
    }else{
        switch (_model.p_project_status) {
            case XAssetStatueBid:{
                self.percentBottomLabel.hidden =
                self.residualAmountImageview.hidden=
                self.percentLabel.hidden =
                self.percentStrLabel.hidden =
                self.paymentImageView.hidden = YES;
                
                self.ropTimeView.timeLable.text = [NSString stringWithFormat:@"%@开抢",[_model.p_start_time substringWithRange:NSMakeRange(11, 5)]];
                self.residualAmountLabel.attributedText = [self atrributWithStr:[NSString stringWithFormat:@"%@",[[NSNumber numberWithFloat:_model.p_project_money] decimalString]]];
                break;
            }
            case XAssetStatueComingSoon:{
                self.ropTimeView.hidden =
                self.residualAmountImageview.hidden =
                self.ropTimeView.hidden =
                self.paymentImageView.hidden = YES;
                
                CGFloat rate =  _model.p_project_money == 0? 0 : (double)_model.p_rated_money/(double)_model.p_project_money;
                self.percentLabel.frame = CGRectMake(leftMargin, CGRectGetMinY(self.percentBottomLabel.frame), CGRectGetWidth(self.percentBottomLabel.frame)*rate, 5);
                self.percentStrLabel.text = [NSString stringWithFormat:@"%.2f%%",(rate * 100)];
                ;
                self.residualAmountLabel.attributedText = [self atrributWithStr:[NSString stringWithFormat:@"%@",[[NSNumber numberWithFloat:_model.p_rating_money] decimalString]]];
                break;
            }
            case XAssetStatueCompleted:{
                self.paymentImageView.hidden =self.ropTimeView.hidden = YES;
                
                self.percentLabel.frame = self.percentBottomLabel.frame ;
                
                self.percentStrLabel.text = @"100%";
                self.residualAmountLabel.text = @"投资完成";
                self.residualAmountLabel.frame = CGRectMake(ScreenWidth-labelWidth/2- 2* leftMargin, CGRectGetMinY(self.percentStrLabel.frame), labelWidth/2, 12);
                self.residualAmountImageview.frame = CGRectMake(CGRectGetMinX(self.residualAmountLabel.frame)-15, CGRectGetMinY(self.residualAmountLabel.frame), 15, 15);
                break;
            }
            case XAssetStatueEndPass:
            case XAssetStatueFinish:{
                CGFloat leftM = is_iPhone5?ScreenWidth - 2*leftMargin - labelWidth- 60:ScreenWidth - 2*leftMargin - labelWidth- 100;
                
                self.deadlineLabel.frame = CGRectMake(leftM, CGRectGetMinY(self.profitLabel.frame), labelWidth, 20);
                self.deadlineDownLabel.frame = CGRectMake(CGRectGetMinX(self.deadlineLabel.frame), CGRectGetMinY(self.profitLabel.frame)+ 10 +25, labelWidth, 15);;
                
                self.deadlineDownLabel.textAlignment = self.deadlineLabel.textAlignment = NSTextAlignmentLeft;
                
                self.percentLabel.hidden =
                self.percentBottomLabel.hidden =
                self.percentStrLabel.hidden =
                self.residualAmountLabel.hidden =
                self.residualAmountImageview.hidden =
                self.ropTimeView.hidden =YES;
                self.paymentImageView.image = [UIImage imageNamed:@"sanbiao_finished"];
                break;
            }
            default:
                break;
        }
    }
    
}


- (NSAttributedString *)atrributWithStr:(NSString *)str{
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"剩余%@元",str]];
    [attriStr addAttribute:NSForegroundColorAttributeName value:[XAppContext appColors].orangeColor range:NSMakeRange(2, attriStr.length -3)];
    return attriStr;
}

@end

@implementation XSanBiaoRobTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        self.backgroundColor = [XAppContext appColors].orangeColor;
        
        UIImageView *rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 14, 14)];
        rightImageV.image = [UIImage imageNamed:@"sanbiao_clock"];
        [self addSubview:rightImageV];
        self.timeLable = [UILabel labelWithFont:[XAppContext appFonts].font_14 text:@"" textColor:[XAppContext appColors].whiteColor];
        self.timeLable.frame =CGRectMake(40, 0, 80, frame.size.height);
        self.timeLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLable];
    }
    return self;
}

@end
