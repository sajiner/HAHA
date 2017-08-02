//
//  XGuideViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/8.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XGuideViewController.h"
#import "XGuideCell.h"
#import "XFlowLayout.h"
#import "XTabBarController.h"

@interface XGuideViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:YES forKey:@"isFirstStart"];
//    [userdefaults setObject:@"isfirst" forKey:@"isFirstStart"];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XGuideCell *cell = [XGuideCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.imageName = _images[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (indexPath.item == _images.count - 1) {
        XTabBarController *tabVc = [[XTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
    }
}

#pragma mark - lazy
- (NSArray *)images {
    if (!_images) {
        _images = @[@"guide_01", @"guide_02"];
    }
    return _images;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        XFlowLayout *layout = [[XFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
         [_collectionView registerClass:[XGuideCell class] forCellWithReuseIdentifier:[XGuideCell identifier]];
        _collectionView.backgroundColor = [XAppContext appColors].backgroundColor;
    }
    return _collectionView;
}

@end
