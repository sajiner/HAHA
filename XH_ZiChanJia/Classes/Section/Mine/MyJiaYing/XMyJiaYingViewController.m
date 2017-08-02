//
//  XMyJiaYingViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingViewController.h"
#import "XMyJiaYingProjectMoneyApi.h"
#import "XMyJiaYingProjectInvestApi.h"
#import "XMyJiaYingHeaderModel.h"
#import "XMySanBiaoCell.h"
#import "XMySanBiaoHeaderView.h"
#import "XMyJiaYingModel.h"
#import "XMyJiaYingDetailViewController.h"

@interface XMyJiaYingViewController () <UITableViewDelegate, UITableViewDataSource, YTKBatchRequestDelegate>

// 我的嘉盈接口（获取待收本金、待收收益、累计收益）
@property (nonatomic, strong) XMyJiaYingProjectMoneyApi *moneyApi;
// 嘉盈投资纪录接口
@property (nonatomic, strong) XMyJiaYingProjectInvestApi *investApi;

@property (nonatomic, strong) UITableView *myJiaYingView;
// cell模型数组
@property (nonatomic, strong) NSMutableArray *cellModels;
// header数据模型
@property (nonatomic, strong) XMyJiaYingHeaderModel *headerModel;
// 无数据的时候显示的图片
@property (nonatomic, strong) UIImageView *imgView;
// 当前页数
@property (nonatomic, assign) int currentPage;

@end

@implementation XMyJiaYingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myJiaYingView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    self.myJiaYingView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf loadData];
    }];
    [self.myJiaYingView.mj_header beginRefreshing];
    
    self.myJiaYingView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage ++;
        [weakSelf loadData];
    }];
}

#pragma mark - 加载网络数据
- (void)loadData {
    NSArray *apis;
    if (_currentPage == 1) {
        apis = @[self.moneyApi, self.investApi];
    } else {
        apis = @[self.investApi];
    }
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apis];
    batchRequest.delegate = self;
    [batchRequest start];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMyJiaYingModel *cellModel = _cellModels[indexPath.row];
    
    XMySanBiaoCell *cell = [XMySanBiaoCell cellWithTableView:tableView];
    cell.jiaYingModel = cellModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMySanBiaoHeaderView *headerView = [XMySanBiaoHeaderView headerViewWithTableView:tableView];
    headerView.jiaYingHeaderModel = _headerModel;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 59;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XMyJiaYingModel *cellModel = _cellModels[indexPath.row];
    XMyJiaYingDetailViewController *detailsVc = [[XMyJiaYingDetailViewController alloc] init];
    detailsVc.navigationItem.title = @"我的嘉盈";
    detailsVc.jiaYingModel = cellModel;
    [self.navigationController pushViewController:detailsVc animated:YES];
}

#pragma mark - YTKBatchRequestDelegate
- (void)batchRequestFinished:(YTKBatchRequest *)batchRequest {
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSDictionary *result = request.responseJSONObject;
        NSLog(@"result = %@", result);
        NSInteger state = [result[@"status"] integerValue];
        if (request == _moneyApi) {
            if (state == 1) {
                _headerModel = [XMyJiaYingHeaderModel mj_objectWithKeyValues:result[@"data"]];
            } else {
                [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
            }
        } else if (request == _investApi) {
            if (state == 1) {
                if (_currentPage == 1) {
                    [self.cellModels removeAllObjects];
                }
                NSArray *array = [XMyJiaYingModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
                [_cellModels addObjectsFromArray:array];
                if (_cellModels.count == 0) {
                    [self.myJiaYingView addSubview:self.imgView];
                    self.myJiaYingView.mj_footer.hidden = YES;
                } else {
                    self.myJiaYingView.mj_footer.hidden = NO;
                    [self.imgView removeFromSuperview];
                }
                [self.myJiaYingView reloadData];
            } else {
                [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
            }
        }
    }
    [self.myJiaYingView.mj_header endRefreshing];
    [self.myJiaYingView.mj_footer endRefreshing];
}

- (void)batchRequestFailed:(YTKBatchRequest *)batchRequest {
    
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSLog(@"网络error = %@", request);
    }
    [self.myJiaYingView.mj_header endRefreshing];
    [self.myJiaYingView.mj_footer endRefreshing];
}

#pragma mark - lazy
- (UITableView *)myJiaYingView {
    if (!_myJiaYingView) {
        _myJiaYingView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _myJiaYingView.backgroundColor = [XAppContext appColors].backgroundColor;
        _myJiaYingView.dataSource = self;
        _myJiaYingView.delegate = self;
        _myJiaYingView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myJiaYingView;
}

- (XMyJiaYingProjectMoneyApi *)moneyApi {
    _moneyApi = [[XMyJiaYingProjectMoneyApi alloc] initWithToken:[UserManager User].token];
    return _moneyApi;
}

- (XMyJiaYingProjectInvestApi *)investApi {
    _investApi = [[XMyJiaYingProjectInvestApi alloc] initWithToken:[UserManager User].token pageNum:[NSString stringWithFormat:@"%d", _currentPage] pageSize:@"10" investStatus:@"-1"];
    return _investApi;
}

- (NSMutableArray *)cellModels {
    if (!_cellModels) {
        _cellModels = [NSMutableArray array];
    }
    return _cellModels;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        // 无数据的时候显示的图片
        _imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _imgView.contentMode = UIViewContentModeCenter;
        _imgView.image = [UIImage imageNamed:@"noDataImage"];
    }
    return _imgView;
}

@end
