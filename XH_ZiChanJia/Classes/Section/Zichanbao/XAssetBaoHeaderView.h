//
//  XAssetBaoHeaderView.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XAssetBaoHeaderViewDelegate <NSObject>
@required
- (void)showPopviewButtonTitle:(NSArray *)titles title:(NSString*)title key:(NSString *)key;
- (void)hidePopView;
@end

@interface XAssetBaoHeaderView : UIView
@property (nonatomic,weak)id<XAssetBaoHeaderViewDelegate> delegate;

@end
