//
//  XIconAndTextFieldView.h
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/11.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>
//左边Icon，右边textField的View
@interface XIconAndTextFieldView : UIView
@property(nonatomic,strong)UIView *topLine;
//textField
@property(nonatomic,strong)UITextField *textField;

/**
 设置iconImg和TextField的placeHolder

 @param iconImgName iconImg
 @param placeHolder placeHolder
 */
- (void)setupIconImg:(NSString *)iconImgName placeHolder:(NSString *)placeHolder;


/**
 重设topLine的左间距
 
 @param leftMargin 左边间距大小
 */
- (void)resetTopLineWithLeftMargin:(CGFloat)leftMargin;

@end
