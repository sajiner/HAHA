//
//  XGuideCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGuideCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName;

+ (NSString *)identifier;

+ (instancetype)cellWithCollectionView: (UICollectionView *)collectionView indexPath: (NSIndexPath *)indexPath;

@end
