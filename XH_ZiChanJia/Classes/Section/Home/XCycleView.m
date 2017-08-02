//
//  CycleView.m
//  UIScrollView_collection实现
//
//  Created by 我的iMac on 16/10/25.
//  Copyright © 2016年 com.creditharmony. All rights reserved.
//

#import "XCycleView.h"
#define Identifier @"Item"
//定时器时间
#define TimerSecond 3

@interface XCycleView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;

@end
@implementation XCycleView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [XAppContext appColors].whiteColor;
        [self setupSubViews];
    }
    return self;
}
-(void)setupSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //设置layout
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.collectionView.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [self addSubview:self.collectionView];
    //设置pageControl
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 30, 100, 20)];
    self.pageControl.centerX = self.centerX;
    self.pageControl.tintColor = [XAppContext appColors].whiteColor;
    self.pageControl.currentPageIndicatorTintColor = [XAppContext appColors].blueColor;
    [self addSubview:self.pageControl];
}
#pragma mark - 数据源和代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count * 10000;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.bounds];
    // 获取图片
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.models[indexPath.row % self.models.count][@"imageurl"]] placeholderImage:[UIImage imageNamed:@"home_placehoder"]];
    cell.backgroundView = imgView;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if([self.delegate respondsToSelector:@selector(selectedItemAtIndex:)]){
        [self.delegate selectedItemAtIndex:indexPath.row % self.models.count];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5;
    self.pageControl.currentPage = ((int)(offset / scrollView.bounds.size.width)) % self.models.count;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeCycleTimer];

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self addCycleTimer];
}
#pragma mark - set方法和懒加载和定时器
-(void)setModels:(NSMutableArray *)models{
    _models = models;
    // 1.刷新collectionView
    [self.collectionView reloadData];
    // 2.设置pageControl个数
    self.pageControl.numberOfPages = models.count;
    //3.默认滚动到中间某一个位置
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:models.count * 10 inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    // 4.添加定时器
    [self removeCycleTimer];
    [self addCycleTimer];
}
-(void)scrollToNext{
    // 1.获取滚动的偏移量
    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
    CGFloat offsetX = currentOffsetX + self.collectionView.bounds.size.width;
    // 2.滚动该位置
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0)];
}
-(void)addCycleTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TimerSecond target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)removeCycleTimer{
    [self.timer invalidate];
    self.timer = nil;
}
@end
