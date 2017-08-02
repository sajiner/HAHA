//
//  XSanBiaoPOPV.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XSanBiaoPOPVDelegate <NSObject>

@required
- (void)popClickTitle:(NSString *)title value:(NSInteger)value;

@end

@interface XSanBiaoPOPV : UIView

@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,weak) id<XSanBiaoPOPVDelegate> delegate;

- (void)setTitles:(NSArray *)titles title:(NSString *)title key:(NSString *)key;

@end
