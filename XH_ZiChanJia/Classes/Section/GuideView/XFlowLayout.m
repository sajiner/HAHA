//
//  XFlowLayout.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XFlowLayout.h"

@implementation XFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (self.collectionView.height) {
        self.itemSize = self.collectionView.size;
    }
}

@end
