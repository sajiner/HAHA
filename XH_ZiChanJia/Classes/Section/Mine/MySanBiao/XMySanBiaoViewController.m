//
//  XMySanBiaoViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoViewController.h"
#import "XMySanBiaoInvestApi.h"
#import "XMySanBiaoUserInMoneyApi.h"
#import "XMySanBiaoHeaderView.h"
#import "XMySanBiaoCell.h"
#import "XMySanBiaoHeaderModel.h"
#import "XMySanBiaoModel.h"
#import "XMySanBiaoDetailsViewController.h"
#import "UIBarButtonItem+XExtension.h"

@interface XMySanBiaoViewController ()<UITableViewDataSource, UITableViewDelegate, YTKBatchRequestDelegate>

// 我的散标接口（获取待收本金、待收收益、累计收益）
@property (nonatomic, strong) XMySanBiaoUserInMoneyApi *moneyApi;
// 散标投资纪录接口
@property (nonatomic, strong) XMySanBiaoInvestApi *investApi;

@property (nonatomic, strong) UITableView *mySanBiaoView;
// cell模型数组
@property (nonatomic, strong) NSMutableArray *cellModels;
// header数据模型
@property (nonatomic, strong) XMySanBiaoHeaderModel *headerModel;
// 无数据的时候显示的图片
@property (nonatomic, strong) UIImageView *imgView;
// 当前页数
@property (nonatomic, assign) int currentPage;

@end

@implementation XMySanBiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mySanBiaoView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    self.mySanBiaoView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf loadData];
    }];
    [self.mySanBiaoView.mj_header beginRefreshing];
    
    self.mySanBiaoView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage ++;
        [weakSelf loadData];
    }];
}

- (void)dealloc {
    NSLog(@"come here");
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
    XMySanBiaoModel *cellModel = _cellModels[indexPath.row];
    
    XMySanBiaoCell *cell = [XMySanBiaoCell cellWithTableView:tableView];
    cell.sanBiaoModel = cellModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMySanBiaoHeaderView *headerView = [XMySanBiaoHeaderView headerViewWithTableView:tableView];
    headerView.headerModel = _headerModel;
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
    
    XMySanBiaoModel *cellModel = _cellModels[indexPath.row];
    if ([cellModel.investStatus integerValue] != 1 && [cellModel.projectStatus integerValue] != 10) { // 不是投标中，进入详情页
        XMySanBiaoDetailsViewController *detailsVc = [[XMySanBiaoDetailsViewController alloc] init];
        detailsVc.navigationItem.title = @"我的散标";
        detailsVc.sanBiaoModel = cellModel;
        [self.navigationController pushViewController:detailsVc animated:YES];
    }
}

#pragma mark - YTKBatchRequestDelegate
- (void)batchRequestFinished:(YTKBatchRequest *)batchRequest {
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSDictionary *result = request.responseJSONObject;
        NSLog(@"result = %@", result);
        NSInteger state = [result[@"status"] integerValue];
        if (request == _moneyApi) {
            if (state == 1) {
                _headerModel = [XMySanBiaoHeaderModel mj_objectWithKeyValues:result[@"data"]];
            } else {
                [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
            }
        } else if (request == _investApi) {
            if (state == 1) {
                if (_currentPage == 1) {
                    [self.cellModels removeAllObjects];
                }
                NSArray *array = [XMySanBiaoModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
                [_cellModels addObjectsFromArray:array];
                if (_cellModels.count == 0) {
                    [self.mySanBiaoView addSubview:self.imgView];
                    self.mySanBiaoView.mj_footer.hidden = YES;
                } else {
                    self.mySanBiaoView.mj_footer.hidden = NO;
                    [self.imgView removeFromSuperview];
                }
                [self.mySanBiaoView reloadData];
            } else {
                [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
            }
        }
    }
    [self.mySanBiaoView.mj_header endRefreshing];
    [self.mySanBiaoView.mj_footer endRefreshing];
}

- (void)batchRequestFailed:(YTKBatchRequest *)batchRequest {
    
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSLog(@"网络error = %@", request);
    }
    [self.mySanBiaoView.mj_header endRefreshing];
    [self.mySanBiaoView.mj_footer endRefreshing];
}

#pragma mark - lazy
- (UITableView *)mySanBiaoView {
    if (!_mySanBiaoView) {
        _mySanBiaoView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _mySanBiaoView.backgroundColor = [XAppContext appColors].backgroundColor;
        _mySanBiaoView.dataSource = self;
        _mySanBiaoView.delegate = self;
        _mySanBiaoView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mySanBiaoView;
}

- (XMySanBiaoUserInMoneyApi *)moneyApi {
    _moneyApi = [[XMySanBiaoUserInMoneyApi alloc] initWithToken:[UserManager User].token];
    return _moneyApi;
}

- (XMySanBiaoInvestApi *)investApi {
    
    NSLog(@"%d", _currentPage);
    _investApi = [[XMySanBiaoInvestApi alloc] initWithToken:[UserManager User].token pageNum:[NSString stringWithFormat:@"%d", _currentPage] pageSize:@"10" investStatus:@"-1"];
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
