//
//  XSanBiaoViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSanBiaoViewController.h"
#import "XSanBiaoTableViewCell.h"
#import "XSanBiaoTableHeaderView.h"
#import "XSanBiaoPOPV.h"
#import "XSanBiaoDetailViewController.h"
#import "XSanBiaoQueryALLApi.h"

@interface XSanBiaoViewController ()<UITableViewDelegate,UITableViewDataSource,XSanBiaoTableHeaderViewDelegate,XSanBiaoPOPVDelegate,YTKRequestDelegate>{
    NSInteger _statue;
    NSInteger _term;
    NSInteger _profit;
    NSInteger _type;
    NSInteger _pageSize;
    NSInteger _pageNumber;
    NSInteger _count;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray<XSanBiaoModel *> *dataOrigin;
@property (nonatomic,strong)XSanBiaoTableHeaderView *headerV;
@property (nonatomic,strong)XSanBiaoPOPV *pop;
@property (nonatomic,strong)XSanBiaoQueryALLApi *queryAllApi;
@property (nonatomic,strong)UILabel *noListLabel;
@end

@implementation XSanBiaoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.pop];
    
    self.pop.alpha = 0;
    self.pop.hidden = YES;
    
    _statue = _term  = _profit = _type = 0; _pageNumber = 5;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}

#pragma mark - Private
- (void)loadNewData{
    
    _pageSize = 1;
    if (self.dataOrigin.count>0) {
        [self.dataOrigin removeAllObjects];
    }
    
    [self.queryAllApi start];
}

- (void)loadMoreData{
    
    if (_count<_pageNumber || _pageSize *5>=_count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    _pageSize++;
    [self.queryAllApi start];
}

#pragma mark - Protocol conformance
-(void)showPopviewButtonTitles:(NSArray *)titles title:(NSString *)title key:(NSString *)key{
    
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
    }else if ([title isEqualToString:@"借款期限"]) {
        _term  =value;
    }else if ([title isEqualToString:@"项目收益"]) {
        _profit =value;
    }else if ([title isEqualToString:@"借款类型"]) {
        _type = value;
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
    NSDictionary *result = request.responseJSONObject;
    NSInteger state = [result[@"status"] integerValue];
    [self endRefresh];
    
    if (request == _queryAllApi) {
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
    XSanBiaoDetailViewController *detail = [[XSanBiaoDetailViewController alloc] init];
    detail.pid = model.p_id;
    detail.m_project_status = model.m_project_status;
    detail.start_time = model.p_start_time;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
       return self.headerV;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XSanBiaoTableViewCell *cell = [XSanBiaoTableViewCell cellWithTableView:tableView ];
    if ([self.dataOrigin count]>0) {
//        cell.model = self.dataOrigin[indexPath.row];
        [cell setModel:self.dataOrigin[indexPath.row] flag:YES];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

#pragma mark -lazy
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

- (NSMutableArray *)dataOrigin{
    if (!_dataOrigin) {
        _dataOrigin = [NSMutableArray array];
    }
    return _dataOrigin;
}

- (XSanBiaoPOPV *)pop{
    if (!_pop) {
        _pop = [[XSanBiaoPOPV alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerV.frame), ScreenWidth, ScreenHeight)];
        _pop.delegate = self;
    }
    return _pop;
}

- (UILabel *)noListLabel{
    if (!_noListLabel) {
        _noListLabel = [UILabel labelWithFont:[XAppContext appFonts].font_20 text:@"亲，暂时没有符合条件的项目哦" textColor:[XAppContext appColors].grayBlackColor];
        _noListLabel.backgroundColor = [XAppContext appColors].backgroundColor;
        _noListLabel.frame = CGRectMake(0, CGRectGetMaxY(self.headerV.frame), ScreenWidth, ScreenHeight - 2*64);
    }
    return _noListLabel;
}

- (XSanBiaoTableHeaderView *)headerV{
    if (!_headerV) {
        _headerV = [[XSanBiaoTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _headerV.delegate = self;
    }
    return _headerV;
}

- (XSanBiaoQueryALLApi *)queryAllApi{
    _queryAllApi = [[XSanBiaoQueryALLApi alloc] initWithStatus:_statue term:_term profit:_profit type:_type pageSize:_pageSize pageNumber:_pageNumber];
    _queryAllApi.delegate = self;    
    return _queryAllApi;
}

@end
