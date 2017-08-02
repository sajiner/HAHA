//
//  XAssetBaoPopView.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XAssetBaoPopViewDelegate <NSObject>
@required
- (void)popClickTitle:(NSString *)title value:(NSInteger)value;

@end

@interface XAssetBaoPopView : UIView
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,weak) id<XAssetBaoPopViewDelegate> delegate;

- (void)setTitles:(NSArray *)titles title:(NSString *)title key:(NSString *)key;
@end
