//
//  XGuideCell.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XGuideCell.h"

static NSString * const ID = @"XGuideCell";

@interface XGuideCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation XGuideCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return self;
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    XGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}

+ (NSString *)identifier {
    return ID;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
