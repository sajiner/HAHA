//
//  XSanBiaoTableHeaderView.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XSanBiaoTableHeaderViewDelegate <NSObject>
@required
- (void)showPopviewButtonTitles:(NSArray *)titles title:(NSString*)title key:(NSString *)key;
- (void)hidePopView;
@end

@interface XSanBiaoTableHeaderView : UIView
@property (nonatomic,weak)id<XSanBiaoTableHeaderViewDelegate> delegate;
@end

