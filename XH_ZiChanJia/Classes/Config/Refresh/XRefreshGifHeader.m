//
//  XRefreshGifHeader.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/27.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XRefreshGifHeader.h"

@implementation XRefreshGifHeader

- (void)prepare {
    [super prepare];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"gold%d", i]];
        [images addObject:image];
    }
    [self setImages:images duration:0.3 forState:MJRefreshStateRefreshing];
    NSArray *pullImages = @[[UIImage imageNamed:@"goldStart"]];
    [self setImages:pullImages forState:MJRefreshStatePulling];
    NSArray *idleImages = @[[UIImage imageNamed:@"goldEnd"]];
    [self setImages:idleImages forState:MJRefreshStateIdle];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

@end
