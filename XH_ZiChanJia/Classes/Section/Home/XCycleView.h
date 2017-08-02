//
//  CycleView.h
//  UIScrollView_collection实现
//
//  Created by 我的iMac on 16/10/25.
//  Copyright © 2016年 com.creditharmony. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CycleViewDelegate<NSObject>
- (void)selectedItemAtIndex:(NSInteger)index;
@end
//轮播器（使用UICollectionView实现）
@interface XCycleView : UIView
@property(nonatomic,strong)NSMutableArray *models;
@property(nonatomic,weak)id<CycleViewDelegate> delegate;
@property(nonatomic,strong)NSTimer *timer;
-(void)addCycleTimer;
@end
