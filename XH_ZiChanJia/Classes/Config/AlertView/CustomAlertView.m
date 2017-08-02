//
//  CustomAlertView.m
//  CustomAlertView
//
//  Created by allenIverson on 16/3/1.
//  Copyright © 2016年 allenIverson. All rights reserved.
//

#import "CustomAlertView.h"
@interface CustomAlertView()

{
    BOOL _isShow;
}
@property (nonatomic, retain) NSString       *cancelButtonTitle;
@property (nonatomic, retain) NSMutableArray *otherButtonTitles;

@end

@implementation CustomAlertView

static const CGFloat mWidth  = 290;
static const CGFloat mHeight = 180;
static const CGFloat mMaxHeight    = 250;
static const CGFloat mBtnHeight    = 30;
static const CGFloat mBtnWidth     = 110;
static const CGFloat mHeaderHeight = 40;

+ (CustomAlertView *)defaultAlert
{
    static CustomAlertView *shareCenter = nil;
    if (!shareCenter)
    {
        shareCenter = [[CustomAlertView alloc] init];
    }
    return shareCenter;
}

- (NSMutableArray *)customerViewsToBeAdd
{
    if (_customerViewsToBeAdd == nil)
    {
        _customerViewsToBeAdd = [[NSMutableArray alloc] init];
    }
    
    return _customerViewsToBeAdd;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight + 20)];
    if (self)
    {
        _isShow = NO;
    }
    return self;
}

- (id)initWithTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate isHTMLTag:(BOOL)isHTMLTag cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... {
    
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight + 20)];
    if (self)
    {
        self.delegate = delegate;
        self.cancelButtonTitle = cancelButtonTitle;
        self.isHTMLTag = isHTMLTag;
        
        if (!_otherButtonTitles)
        {
            va_list argList;
            if (otherButtonTitles)
            {
                self.otherButtonTitles = [NSMutableArray array];
                [self.otherButtonTitles addObject:otherButtonTitles];
            }
            va_start(argList, otherButtonTitles);
            id arg;
            while ((arg = va_arg(argList, id)))
            {
                [self.otherButtonTitles addObject:arg];
            }
        }
        self.title = title;
        self.message = message;
        
    }
    return self;
    
}

- (id)initWithTitle:(NSString*)title message:(NSString*)message delegate:(id)del cancelButtonTitle:(NSString*)cancelBtnTitle otherButtonTitles:(NSString*)otherBtnTitles, ...
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight + 20)];
    if (self)
    {
        self.delegate = del;
        self.cancelButtonTitle = cancelBtnTitle;
        
        if (!_otherButtonTitles)
        {
            va_list argList;
            if (otherBtnTitles)
            {
                self.otherButtonTitles = [NSMutableArray array];
                [self.otherButtonTitles addObject:otherBtnTitles];
            }
            va_start(argList, otherBtnTitles);
            id arg;
            while ((arg = va_arg(argList, id)))
            {
                [self.otherButtonTitles addObject:arg];
            }
        }
        self.title = title;
        self.message = message;
        
    }
    return self;
}

-(void)initTitle:(NSString*)title message:(NSString*)message delegate:(id)del cancelButtonTitle:(NSString*)cancelBtnTitle otherButtonTitles:(NSString*)otherBtnTitles, ...
{
    if (self)
    {
        self.delegate = del;
        self.cancelButtonTitle = cancelBtnTitle;
        
        if (!_otherButtonTitles)
        {
            va_list argList;
            if (otherBtnTitles)
            {
                self.otherButtonTitles = [NSMutableArray array];
                [self.otherButtonTitles addObject:otherBtnTitles];
            }
            va_start(argList, otherBtnTitles);
            id arg;
            while ((arg = va_arg(argList, id)))
            {
                [self.otherButtonTitles addObject:arg];
            }
        }
        self.title = title;
        self.message = message;
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setAlpha:0.4];
    [self addSubview:bgView];
    
    if (!_backView)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mWidth, mHeight)];
        _backView.opaque = NO;
        _backView.backgroundColor     = [UIColor whiteColor];
        _backView.layer.shadowOffset  = CGSizeMake(1, 1);
        _backView.layer.shadowRadius  = 2.0;
        _backView.layer.shadowColor   = [UIColor grayColor].CGColor;
        _backView.layer.shadowOpacity = 0.8;
        _backView.layer.cornerRadius = 10;
        [_backView.layer setMasksToBounds:YES];
    }
    
    // - 设置消息显示区域
    _msgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mWidth, (mHeight-mHeaderHeight * 1.2))];
    _msgView.layer.borderColor = [UIColor grayColor].CGColor;
    _msgView.layer.borderWidth = 0.5;
    _msgView.layer.cornerRadius = 10;
    _msgView.layer.masksToBounds = YES;
    // - 设置背景颜色
    _msgView.backgroundColor = [UIColor whiteColor];
    
    // - 内容
    CGSize messageSize = CGSizeZero;
    if (self.message && [self.message length]>0)
    {
        messageSize = [self.message sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(mWidth-20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        if (messageSize.width > 0)
        {
            
//            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_msgView.frame.size.width - 35, 5, 30, 30)];
//            [btn setBackgroundImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [_msgView addSubview:btn];
            
            //标题
            UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, ((mHeight - mHeaderHeight * 2) - messageSize.height) / 2 - 20, mWidth-20, messageSize.height + 5)];
            titleLable.textAlignment = NSTextAlignmentCenter;
            
//            NSDictionary *attributes = @{NSParagraphStyleAttributeName:ps};
           
//            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[self.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSHTMLTextDocumentType: ps} documentAttributes:nil error:nil];
//            titleLable.attributedText = attrStr;
            titleLable.text = self.title;

            titleLable.font = [UIFont systemFontOfSize:20];
            [_msgView addSubview:titleLable];
            
            //内容
            UILabel *msgLabel = [[UILabel alloc] init];

            msgLabel.numberOfLines = 0;
            msgLabel.backgroundColor = [UIColor whiteColor];
            if (self.isHTMLTag) {
                NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[self.message dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//             NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[@"<p align='center'><font color='#0264cf' size='6px'>400-015-0808</font></p><p align='center' style=\"font-size:16px\">周一至周五 9:00-21:00</p><p align='center' style=\"font-size:16px\">周六至周日 9:00-18:00</p>" dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                msgLabel.attributedText = attrStr;
                msgLabel.frame = CGRectMake(10, ((mHeight - mHeaderHeight * 2) - messageSize.height) / 2 + 20, mWidth-20, 50);
            }else {
                msgLabel.textAlignment = NSTextAlignmentCenter;
                msgLabel.font = [UIFont systemFontOfSize:16.0f];
                msgLabel.text = self.message;
                msgLabel.frame = CGRectMake(10, ((mHeight - mHeaderHeight * 2) - messageSize.height) / 2 + 20, mWidth-20, messageSize.height + 30);
            }


            if(messageSize.height > mMaxHeight)
            {
                NSLog(@"1");
                _msgView.frame = CGRectMake(_msgView.frame.origin.x, _msgView.frame.origin.y, _msgView.frame.size.width, mMaxHeight + 25);
                _backView.frame = CGRectMake(0, 0, mWidth, mHeaderHeight * 2 + _msgView.frame.size.height);
                msgLabel.textAlignment = NSTextAlignmentLeft;
                msgLabel.frame = CGRectMake(10, 10, mWidth - 20, messageSize.height);
                _msgView.contentSize = CGSizeMake(_msgView.frame.size.width, msgLabel.frame.size.height + 20);
            }
            else if (messageSize.height > (mHeight-mHeaderHeight * 2) - 10)
            {
                NSLog(@"2");
                _msgView.frame = CGRectMake(_msgView.frame.origin.x, _msgView.frame.origin.y, _msgView.frame.size.width, messageSize.height + 25);
                _backView.frame = CGRectMake(0, 0, mWidth, mHeaderHeight * 2 + _msgView.frame.size.height);
                msgLabel.frame = CGRectMake(10, 10, mWidth - 20, messageSize.height + 5);
            }
            //2014/4/14  by wz 后期可以优化
            if(self.isHTMLTag){
             _msgView.frame = CGRectMake(_msgView.frame.origin.x, _msgView.frame.origin.y, _msgView.frame.size.width, 155);
             msgLabel.frame = CGRectMake(10, 10, mWidth - 20, 135);
             _backView.frame = CGRectMake(0, 0, mWidth, 210);
            }
            [_msgView addSubview:msgLabel];
            [_backView addSubview:_msgView];
        }
    }else{
        if (self.customerViewsToBeAdd && [self.customerViewsToBeAdd count] > 0)
        {
            CGFloat startY = 0;
            for (UIView *subView in self.customerViewsToBeAdd)
            {
                CGRect rect = subView.frame;
                rect.origin.y = startY;
                subView.frame = rect;
                [_msgView addSubview:subView];
                startY += rect.size.height;
            }
            if(self.title && [self.title length] > 0){
                _msgView.frame = CGRectMake(0, mHeaderHeight, mWidth, startY);
            }else{
                _msgView.frame = CGRectMake(0, 0, mWidth, startY);
            }
        }
        [_backView addSubview:_msgView];
        if(self.title && [self.title length] > 0){
            _backView.frame = CGRectMake(0, 0, mWidth, _msgView.frame.size.height + mHeaderHeight * 2 + 20);
        }else{
            _backView.frame = CGRectMake(0, 0, mWidth, _msgView.frame.size.height + mHeaderHeight + 10);
        }
    }
    
    
    // - 设置按钮显示区域
    if (_otherButtonTitles != nil || _cancelButtonTitle != nil)
    {
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, _backView.frame.size.height-mHeaderHeight, mWidth, mHeaderHeight)];
        _backView.backgroundColor = [XAppContext appColors].blueColor;
        // - 如果只显示一个按钮,需要计算按钮的显示大小
        if (_otherButtonTitles == nil || _cancelButtonTitle == nil)
        {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mWidth, mBtnHeight)];
            btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
            btn.titleLabel.textColor = [UIColor whiteColor];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            if (_otherButtonTitles == nil && _cancelButtonTitle != nil)
            {
                [btn setTitle:_cancelButtonTitle forState:UIControlStateNormal];
            } else
            {
                [btn setTitle:[_otherButtonTitles objectAtIndex:0] forState:UIControlStateNormal];
            }
            btn.tag = 0;
            btn.layer.cornerRadius = 5;
            [btnView addSubview:btn];
        }
        else if(_otherButtonTitles && [_otherButtonTitles count] == 1)
        {
            // - 显示两个按钮
            // - 设置确定按钮的相关属性
            CGFloat startX = (_backView.frame.size.width-mBtnWidth*2-20)/2;
            UIButton *otherBtn = [[UIButton alloc]initWithFrame:CGRectMake(startX, 0, mBtnWidth, mBtnHeight)];
            otherBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
            otherBtn.titleLabel.textColor = [UIColor whiteColor];
            [otherBtn setTitle:[_otherButtonTitles objectAtIndex:0] forState:UIControlStateNormal];
            [otherBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            otherBtn.tag = 0;
            [btnView addSubview:otherBtn];
            startX += mBtnWidth+20;
            
            // - 设置取消按钮的相关属性
            UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(startX, 0, mBtnWidth, mBtnHeight)];
            cancelBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
            cancelBtn.titleLabel.textColor = [UIColor whiteColor];
            [cancelBtn setTitle:_cancelButtonTitle forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            cancelBtn.tag = 1;
            [btnView addSubview:cancelBtn];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(btnView.frame.size.width * 0.5, 0, 1, btnView.frame.size.height - 5)];
            lineView.backgroundColor = RGB(235, 235, 235);
            [btnView addSubview:lineView];
        }
        [_backView addSubview: btnView];
    }
    else
    {
        CGRect rc = _backView.frame;
        rc.size.height -= mHeaderHeight;
        _backView.frame = rc;
    }
    
    UIControl *touchView = [[UIControl alloc] initWithFrame:self.frame];
    [touchView addTarget:self action:@selector(touchViewClickDown) forControlEvents:UIControlEventTouchDown];
    touchView.frame = self.frame;
    [self addSubview:touchView];
    _backView.center = self.center;
    
    
    [self addSubview:_backView];
    
    if (!_isShow)
        [CustomAlertView exChangeOut:_backView dur:0.5];
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(willPresentCustomAlertView:)])
        {
            [self.delegate willPresentCustomAlertView:self];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kBCAlertViewPresentNotify object:nil userInfo:nil];
    }
}
- (void)touchViewClickDown
{
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(hideCurrentKeyBoard)])
        {
            [self.delegate hideCurrentKeyBoard];
        }
    }
}

// - 在消息区域设置自定义控件
- (void)addCustomerSubview:(UIView *)view
{
    [self.customerViewsToBeAdd addObject:view];
}

- (void)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    _isShow = NO;
    if (btn)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
        {
            [self.delegate alertView:self clickedButtonAtIndex:btn.tag];
        }
        [self removeFromSuperview];
    }
}

- (void)closeBtnClicked:(id)sender
{
    _isShow = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewClosed:)])
    {
        [self.delegate alertViewClosed:self];
    }
    [self removeFromSuperview];
}

- (void)show
{
    [self layoutSubviews];
    if (!_isShow)
        [[[UIApplication sharedApplication].delegate window]  addSubview:self];
    _isShow = YES;
}

- (void)dealloc
{
    self.titleLabel = nil;
    self.titleBackgroundView = nil;
    self.titleIcon = nil;
    
}

// - alertview弹出动画
+ (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}

@end
