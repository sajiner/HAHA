//
//  UIViewController+XExtension.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "UIViewController+XExtension.h"
#import "UIBarButtonItem+XExtension.h"

#define SHOW_VIEW_SIZE         [UIScreen mainScreen].bounds.size.width/4.0         //显示视图尺寸
#define SHOW_LBL_SIZE          [UIScreen mainScreen].bounds.size.width/3.0         //提示视图尺寸

@interface HUDView()

/*
 *gif动画
 */
@property(nonatomic,strong)UIView                      *showView;          //显示视图
@property(nonatomic,strong)UIActivityIndicatorView     *activityView;      //加载小菊花
@property(nonatomic,strong)UILabel                     *contentLbl;        //加载提示
/*
 *小菊花
 */
@property(nonatomic,strong)UIImageView                 *loadImgView;       //加载图片
@property(nonatomic,strong)UILabel                     *loadLbl;           //加载提示

/*
 *显示效果
 */
@property(nonatomic,strong)CAKeyframeAnimation         *popAnimation;      //显示动画
@property(nonatomic,strong)UILabel                     *showLbl;           //提示视图

@end

#import <objc/runtime.h>

static char animate;
static char activity;
static char complete;

@implementation UIViewController (XExtension)

-(void)setAnimateBgView:(HUDView *)animateBgView {
    [self willChangeValueForKey:@"HUD-animate"];
    objc_setAssociatedObject(self, &animate,
                             animateBgView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"HUD-animate"];
}

-(HUDView *)animateBgView {
    return objc_getAssociatedObject(self, &animate);
}

-(void)setActivityBgView:(HUDView *)activityBgView {
    [self willChangeValueForKey:@"HUD-activity"];
    objc_setAssociatedObject(self, &activity,
                             activityBgView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"HUD-activity"];
}
-(HUDView *)activityBgView {
    return objc_getAssociatedObject(self, &activity);
}

-(void)setCompleteBgView:(HUDView *)completeBgView {
    [self willChangeValueForKey:@"HUD-complete"];
    objc_setAssociatedObject(self, &complete,
                             completeBgView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"HUD-complete"];
}

-(HUDView *)completeBgView {
    return objc_getAssociatedObject(self, &complete);
}

//加载动画
-(void)showAnimateView {
    if (!self.animateBgView) {
        self.animateBgView=[[HUDView alloc]initWithFrame:self.view.bounds withActivity:YES];
        self.animateBgView.backgroundColor=[UIColor clearColor];
    }
    [self.view addSubview:self.animateBgView];
    [self.animateBgView.loadImgView startAnimating];
}

//加载小菊花
- (void)showActivityViewWithTitle:(NSString *)title {
    if (!self.activityBgView) {
        self.activityBgView=[[HUDView alloc]initWithFrame:self.view.bounds withActivity:YES];
        self.activityBgView.backgroundColor=[UIColor clearColor];
    }
    [self.view addSubview:self.activityBgView];
    self.activityBgView.contentLbl.text=title;
    [self.activityBgView.activityView startAnimating];
}

//加载完成视图
-(void)completeLoadWithTitle:(NSString *)title {
    HUDView *hudView;
    if(self.animateBgView){
        [self.animateBgView.loadImgView stopAnimating];
        [self.animateBgView removeFromSuperview];
        hudView=self.animateBgView;
    }
    if (self.activityBgView) {
        [self.activityBgView.activityView stopAnimating];
        [self.activityBgView removeFromSuperview];
        hudView=self.activityBgView;
    }
    if (!hudView) {
        if (!self.completeBgView) {
            self.completeBgView=[[HUDView alloc]initWithFrame:self.view.bounds withActivity:YES];
            self.completeBgView.backgroundColor=[UIColor clearColor];
        }
        hudView=self.completeBgView;
    }
    if (title) {
        //        hudView.showLbl.textAlignment = NSTextAlignmentCenter;
        //        hudView.showLbl.text=title;
        //        CGRect tmpRect = [title boundingRectWithSize:CGSizeMake(SHOW_LBL_SIZE, SHOW_LBL_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil] context:nil];
        //        hudView.showLbl.frame=CGRectMake((self.view.frame.size.width-CGRectGetWidth(tmpRect)-20)/2.0 , (self.view.frame.size.height-CGRectGetHeight(tmpRect)-20)/2.0-44, CGRectGetWidth(tmpRect), CGRectGetHeight(tmpRect)+20);
        //        hudView.showLbl.layer.cornerRadius=hudView.showLbl.frame.size.height/10.0;
        //        [hudView.showLbl.layer removeAllAnimations];
        //        [hudView.showLbl.layer addAnimation:hudView.popAnimation forKey:nil];
        //        [self.view addSubview:hudView.showLbl];
        [hudView.showLbl performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2];
        CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
        [customAlert show];
    }
    
}

//MBProgress加载完成视图
-(void)mbCompleteLoadWithTitle:(NSString *)title {
    CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
    [customAlert show];
}

- (void)mbCompleteLoadWithTitle:(NSString *)title afterDelay:(int)time {
    CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
    [customAlert show];
}

#pragma mark - UIAlertView
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message letfButtonTitle:(NSString *)left rightBtn:(NSString *)right {
    CustomAlertView *customAlertView = [[CustomAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:left otherButtonTitles:right, nil];
    [customAlertView show];
}

@end

@implementation HUDView
-(instancetype)initWithFrame:(CGRect)frame withActivity:(BOOL)isActivity {
    self=[super initWithFrame:frame];
    if (self) {
        if (isActivity) {
            [self addSubview:self.showView];
        }else
        {
            [self addSubview:self.loadImgView];
            [self addSubview:self.loadLbl];
        }
    }
    return self;
}

-(UIView *)showView {
    if (!_showView) {
        _showView=[[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-SHOW_VIEW_SIZE)/2.0, (self.frame.size.height-SHOW_VIEW_SIZE)/2.0-44, SHOW_VIEW_SIZE, SHOW_VIEW_SIZE)];
        _showView.backgroundColor=rgba(0, 0, 0, .7);
        _showView.layer.cornerRadius=_showView.frame.size.width/10.0;
        [_showView addSubview:self.activityView];
        [_showView addSubview:self.contentLbl];
    }
    return _showView;
}
-(UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((SHOW_VIEW_SIZE-30)/2.0, (SHOW_VIEW_SIZE-30)/2.0-10, 30, 30)];
    }
    return _activityView;
}
-(UILabel *)contentLbl {
    if (!_contentLbl) {
        _contentLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, SHOW_VIEW_SIZE-30, SHOW_VIEW_SIZE, 20)];
        _contentLbl.textAlignment=NSTextAlignmentCenter;
        _contentLbl.textColor=[UIColor whiteColor];
        _contentLbl.font=[UIFont systemFontOfSize:13.0f];
        _contentLbl.backgroundColor=[UIColor clearColor];
    }
    return _contentLbl;
}
-(UIImageView *)loadImgView {
    if (!_loadImgView) {
        _loadImgView=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-30)/2.0, (self.frame.size.height-20)/2.0-31-44, 30, 20)];
        _loadImgView.animationDuration=1.5;
        NSMutableArray *imgs=[NSMutableArray arrayWithCapacity:7];
        for (NSInteger i=1; i<8; i++) {
            [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%ld",(long)i]]];
        }
        _loadImgView.animationImages=imgs;
        
    }
    return _loadImgView;
}
-(UILabel *)loadLbl {
    if (!_loadLbl) {
        _loadLbl=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-100)/2.0, (self.frame.size.height+20)/2.0-44, 100, 20)];
        _loadLbl.textAlignment=NSTextAlignmentCenter;
        _loadLbl.textColor=RGB(154, 154, 9);
        _loadLbl.font=[UIFont systemFontOfSize:13.0f];
        _loadLbl.text=@"快速加载中...";
        _loadLbl.backgroundColor=[UIColor clearColor];
        
    }
    return _loadLbl;
}
-(CAKeyframeAnimation *)popAnimation {
    if (!_popAnimation) {
        _popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        _popAnimation.duration = 0.4;
        _popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        _popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
        _popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    return _popAnimation;
}
-(UILabel *)showLbl {
    if (!_showLbl) {
        _showLbl=[[UILabel alloc]initWithFrame:CGRectZero];
        _showLbl.textAlignment=NSTextAlignmentCenter;
        _showLbl.textColor=[UIColor whiteColor];
        _showLbl.font=[UIFont systemFontOfSize:14];
        _showLbl.backgroundColor=[UIColor colorWithRed:.0/255.0 green:.0/255.0 blue:.0/255.0 alpha:.7];
        _showLbl.layer.masksToBounds=YES;
        _showLbl.lineBreakMode=NSLineBreakByWordWrapping;
        _showLbl.numberOfLines=0;
        
    }
    return _showLbl;
}

@end
