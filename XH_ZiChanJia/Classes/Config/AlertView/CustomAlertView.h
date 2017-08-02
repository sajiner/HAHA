//
//  CustomAlertView.h
//  CustomAlertView
//
//  Created by allenIverson on 16/3/1.
//  Copyright © 2016年 allenIverson. All rights reserved.
//

#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kBCAlertViewPresentNotify   @"kBCAlertViewPresentNotify"  //alertview present notify

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CustomAlertView;

@protocol CustomAlertViewDelegate <NSObject>

@optional

// - 代理方法
-(void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)alertViewClosed:(CustomAlertView *)alertView;
-(void)willPresentCustomAlertView:(UIView *)alertView;

// - 隐藏实用类弹出键盘
- (void)hideCurrentKeyBoard;

@end

@interface CustomAlertView : UIView {
}

@property (nonatomic, assign) id <CustomAlertViewDelegate> delegate;
@property (nonatomic, assign) BOOL           isNeedCloseBtn;  // - 左上角带叉叉按钮
@property (nonatomic, retain) NSString       *title;
@property (nonatomic, retain) NSString       *message;
@property (nonatomic, retain) UIView         *backView;
@property (nonatomic, retain) UIView         *titleBackgroundView;
@property (nonatomic, retain) UILabel        *titleLabel;
@property (nonatomic, retain) UIImageView    *titleIcon;
@property (nonatomic, retain) NSMutableArray *customerViewsToBeAdd;
@property (nonatomic, assign) BOOL isHTMLTag;
//GBZ添加，获取弹框所在View
@property(nonatomic,strong)UIScrollView *msgView;


- (id)initWithTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

-(void)initTitle:(NSString*)title message:(NSString*)message delegate:(id)del cancelButtonTitle:(NSString*)cancelBtnTitle otherButtonTitles:(NSString*)otherBtnTitles, ...NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate isHTMLTag:(BOOL)isHTMLTag cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) show ;

// - 在alertview中添加自定义控件
- (void)addCustomerSubview:(UIView *)view;

+ (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur;

+ (CustomAlertView *)defaultAlert;

@end