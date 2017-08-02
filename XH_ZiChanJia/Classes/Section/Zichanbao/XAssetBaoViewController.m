//
//  XAssetBaoViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAssetBaoViewController.h"
#import "XAssetPackageQueryAllApi.h"
#import "XSanBiaoModel.h"
#import "XSanBiaoTableViewCell.h"
#import "XAssetBaoHeaderView.h"
#import "XAssetBaoPopView.h"
#import "XAssetBaoDetailViewController.h"

@interface XAssetBaoViewController ()<UITableViewDelegate,UITableViewDataSource,YTKRequestDelegate,XAssetBaoPopViewDelegate,XAssetBaoHeaderViewDelegate>{
    NSInteger _statue;
    NSInteger _term;
    NSInteger _profit;
    NSInteger _pageSize;
    NSInteger _pageNumber;
    NSInteger _count;
}
@property (nonatomic,strong)XAssetPackageQueryAllApi *assetQueryAllApi;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)XAssetBaoHeaderView *headerView;
@property (nonatomic,strong)XAssetBaoPopView *pop;

@property (nonatomic,strong)NSMutableArray<XSanBiaoModel *> *dataOrigin;

@property (nonatomic,strong)UILabel *noListLabel;
@end

@implementation XAssetBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.pop];
    
    self.pop.alpha = 0;
    self.pop.hidden = YES;

    _statue = _term  = _profit = 0; _pageNumber = 1;_pageSize = 5;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNewData];
}

#pragma mark - Private
- (void)loadNewData{
    
    _pageNumber = 1;
    if (self.dataOrigin.count>0) {
        [self.dataOrigin removeAllObjects];
    }
    
    [self.assetQueryAllApi start];
}

- (void)loadMoreData{
    
    if ( _pageNumber *5>=_count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    _pageNumber++;
    [self.assetQueryAllApi start];
}
#pragma mark - Protocol conformance
-(void)showPopviewButtonTitle:(NSArray *)titles title:(NSString *)title key:(NSString *)key{
    
    [self hidePop];
    
    [self.pop setTitles:titles title:title key:key];
    [UIView animateWithDuration:0.5 animations:^{
        self.pop.alpha = 1;
        self.pop.hidden = NO;
        [self.view bringSubviewToFront:self.pop];
    }];
}

- (void)hidePopView{
    [self loadNewData];
    [self hidePop];
}
- (void)popClickTitle:(NSString *)title value:(NSInteger)value{
    
    if ([title isEqualToString:@"项目状态"]) {
        _statue =value;
    }else if ([title isEqualToString:@"项目期限"]) {
        _term  =value;
    }else if ([title isEqualToString:@"项目收益"]) {
        _profit =value;
    }
    
    [self hidePopView];
}

- (void)hidePop{
    [UIView animateWithDuration:1 animations:^{
        self.pop.alpha = 0;
        self.pop.hidden = YES;
    }];
}

#pragma mark -  YTKRequestDelegate
- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    NSLog(@"request.requestUrl__%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSInteger state = [result[@"status"] integerValue];
    [self endRefresh];
    
    if (request == _assetQueryAllApi) {
        if (state == 1) {
            _count = [[[request.responseObject objectForKey:@"data"] objectForKey:@"count"] integerValue];
            if (_count == 0) {
                [self.view addSubview:self.noListLabel];
            }else{
                [self.noListLabel removeFromSuperview];
                NSArray *array = [XSanBiaoModel mj_objectArrayWithKeyValuesArray:[[request.responseObject objectForKey:@"data"] objectForKey:@"data"]];
                [self.dataOrigin addObjectsFromArray:array];
            }
            [self.tableView reloadData];
        }else{
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request{
    NSLog(@"request.requestUrl__%@",request.requestUrl);

    [self endRefresh];
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataOrigin.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XSanBiaoModel *model = ((XSanBiaoModel *)self.dataOrigin[indexPath.row]);
    XAssetBaoDetailViewController *detail = [[XAssetBaoDetailViewController alloc] init];
    detail.pid = model.p_id;
    detail.p_project_status = model.p_project_status;
    detail.start_time = model.p_start_time;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XSanBiaoTableViewCell *cell = [XSanBiaoTableViewCell cellWithTableView:tableView ];
    if ([self.dataOrigin count]>0) {
//        cell.model = self.dataOrigin[indexPath.row];
        [cell setModel:self.dataOrigin[indexPath.row] flag:NO];

    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}


#pragma mark - lazy

- (NSMutableArray<XSanBiaoModel *> *)dataOrigin{
    if (!_dataOrigin) {
        _dataOrigin = [NSMutableArray array];
    }
    return _dataOrigin;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [XAppContext appColors].backgroundColor;
        _tableView.mj_header = [XRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (XAssetBaoHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[XAssetBaoHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (XAssetBaoPopView *)pop{
    if (!_pop) {
        _pop = [[XAssetBaoPopView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), ScreenWidth, ScreenHeight)];
        _pop.delegate = self;
    }
    return _pop;
}

- (XAssetPackageQueryAllApi *)assetQueryAllApi{
    _assetQueryAllApi = [[XAssetPackageQueryAllApi alloc] initWithStatus:_statue term:_term profit:_profit pageNum:_pageNumber pageSize:_pageSize];
    _assetQueryAllApi.delegate = self;
    return _assetQueryAllApi;
}

- (UILabel *)noListLabel{
    if (!_noListLabel) {
        _noListLabel = [UILabel labelWithFont:[XAppContext appFonts].font_20 text:@"亲，暂时没有符合条件的项目哦" textColor:[XAppContext appColors].grayBlackColor];
        _noListLabel.backgroundColor = [XAppContext appColors].backgroundColor;
        _noListLabel.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), ScreenWidth, ScreenHeight - 2*64);
    }
    return _noListLabel;
}



@end
