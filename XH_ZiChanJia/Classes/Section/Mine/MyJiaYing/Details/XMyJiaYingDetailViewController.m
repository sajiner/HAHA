//
//  XMyJiaYingDetailViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyJiaYingDetailViewController.h"
#import "XMyJiaYingDetailHeaderView.h"
#import "XMyJiaYingProjectInvestDetailApi.h"
#import "XMyJiaYingProjectInvestDetailApis.h"
#import "XMyJiaYingModel.h"
#import "XMyJiaYingDetailCell.h"
#import "XMyJiaYingDetailModel.h"
#import "XWebViewController.h"

@interface XMyJiaYingDetailViewController ()<UITableViewDelegate, UITableViewDataSource, YTKBatchRequestDelegate, XMyJiaYingDetailCellDelegate>

@property (nonatomic, strong) UITableView *jiaYingDetailView;
/// 头view
@property (nonatomic, strong) XMyJiaYingDetailHeaderView *headerView;
/// 详情api
@property (nonatomic, strong) XMyJiaYingProjectInvestDetailApi *detailApi;
/// 详情api
@property (nonatomic, strong) XMyJiaYingProjectInvestDetailApis *detailApis;
/// 原始资产包模型数组
@property (nonatomic, strong) NSMutableArray *cellModels0;
/// 复投资产包模型数组
@property (nonatomic, strong) NSMutableArray *cellModels1;
// 无数据的时候显示的图片
@property (nonatomic, strong) UIImageView *imgView;
// 当前页数
@property (nonatomic, assign) int currentPage;

@end

@implementation XMyJiaYingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.jiaYingDetailView];
    
    __weak typeof(self) weakSelf = self;
    self.jiaYingDetailView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf loadData];
    }];
    [self.jiaYingDetailView.mj_header beginRefreshing];
    
    self.jiaYingDetailView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage ++;
        [weakSelf loadData];
    }];
}

- (void)loadData {
    NSArray *apis;
    if ([_jiaYingModel.ftnum integerValue] == 0) {  // 如果没有复投
        apis = @[self.detailApi];
    } else {
        apis = @[self.detailApi, self.detailApis];
    }
    if (_currentPage == 1) {
        [_cellModels0 removeAllObjects];
        [_cellModels1 removeAllObjects];
    }
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apis];
    batchRequest.delegate = self;
    [batchRequest start];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sec = 0;
    if ([_jiaYingModel.ftnum integerValue] == 0) {  // 如果没有复投
        sec = 1;
    } else {
        sec = 2;
    }
    return sec;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger row;
    if ([_jiaYingModel.ftnum integerValue] == 0) {  // 如果没有复投
        row = self.cellModels0.count;
    } else {
        if (section == 0) {
            row = self.cellModels0.count;
        } else {
            row = self.cellModels1.count;
        }
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMyJiaYingDetailCell *cell = [XMyJiaYingDetailCell cellWithTableView:tableView];
    cell.delegate = self;
    if ([_jiaYingModel.ftnum integerValue] == 0) {  // 如果没有复投
        cell.detailModel = _cellModels0[indexPath.row];
    } else {
        if (indexPath.section == 0) {
            cell.detailModel = _cellModels0[indexPath.row];
        } else {
            cell.detailModel = _cellModels1[indexPath.row];
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    headerView.contentView.backgroundColor = [XAppContext appColors].backgroundColor;
    headerView.textLabel.textColor = [XAppContext appColors].grayBlackColor;
    if ([_jiaYingModel.ftnum integerValue] == 0) {  // 如果没有复投
        headerView.textLabel.text = @"原始资产包列表如下";
    } else {
        if (section == 0) {
            headerView.textLabel.text = @"收益复投匹配如下";
        } else if (section == 1) {
            headerView.textLabel.text = @"原始资产包列表如下";
        }
    }
    return headerView;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - YTKBatchRequestDelegate
- (void)batchRequestFinished:(YTKBatchRequest *)batchRequest {
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSDictionary *result = request.responseJSONObject;
        NSLog(@"result = %@", result);
        NSInteger state = [result[@"status"] integerValue];
        if (request == _detailApi) {
            if (state == 1) {
                NSArray *array = [XMyJiaYingDetailModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
                [_cellModels0 addObjectsFromArray:array];
            }
        } else if (request == _detailApis) {
            if (state == 1) {
                NSArray *array = [XMyJiaYingDetailModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
                [_cellModels1 addObjectsFromArray:array];
            }
        }
        if (_cellModels1.count == 0 && _cellModels0.count == 0) {
            [self.jiaYingDetailView addSubview:self.imgView];
            self.jiaYingDetailView.mj_footer.hidden = YES;
        } else {
            self.jiaYingDetailView.mj_footer.hidden = NO;
            [self.imgView removeFromSuperview];
        }
        /// 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.jiaYingDetailView reloadData];
        });
        [self.jiaYingDetailView.mj_header endRefreshing];
        [self.jiaYingDetailView.mj_footer endRefreshing];
    }
}

- (void)batchRequestFailed:(YTKBatchRequest *)batchRequest {
    
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSLog(@"网络error = %@", request);
        [self.jiaYingDetailView.mj_header endRefreshing];
        [self.jiaYingDetailView.mj_footer endRefreshing];
    }
}

#pragma mark - XMyJiaYingDetailCellDelegate
- (void)jiaYingDetailCell:(XMyJiaYingDetailCell *)jiaYingDetailCell didClickOfLoanAgreement:(UIButton *)loanAgreementButton linkString:(NSString *)linkString {
    XWebViewController *webVc = [[XWebViewController alloc] init];
    webVc.urlString = linkString;
    webVc.navigationItem.title = @"借款协议";
    [self.navigationController pushViewController:webVc animated:YES];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkString]];
}

#pragma mark - lazy
- (XMyJiaYingDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[XMyJiaYingDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 144)];
        _headerView.jiaYingModel = _jiaYingModel;
    }
    return _headerView;
}

- (UITableView *)jiaYingDetailView {
    if (!_jiaYingDetailView) {
        _jiaYingDetailView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, ScreenWidth, ScreenHeight - self.headerView.bottom - 64)];
        _jiaYingDetailView.backgroundColor = [XAppContext appColors].backgroundColor;
        _jiaYingDetailView.delegate = self;
        _jiaYingDetailView.dataSource = self;
        _jiaYingDetailView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _jiaYingDetailView;
}

- (XMyJiaYingProjectInvestDetailApi *)detailApi {
    _detailApi = [[XMyJiaYingProjectInvestDetailApi alloc] initWithToken:[UserManager User].token investId:_jiaYingModel.investid investType:@"0" pageNum:[NSString stringWithFormat:@"%d", _currentPage] pageSize:@"10"];
    return _detailApi;
}

- (XMyJiaYingProjectInvestDetailApis *)detailApis {
    _detailApis = [[XMyJiaYingProjectInvestDetailApis alloc] initWithToken:[UserManager User].token investId:_jiaYingModel.investid investType:@"1" pageNum:[NSString stringWithFormat:@"%d", _currentPage] pageSize:@"10"];
    return _detailApis;
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

- (NSMutableArray *)cellModels0 {
    if (!_cellModels0) {
        _cellModels0 = [NSMutableArray array];
    }
    return _cellModels0;
}

- (NSMutableArray *)cellModels1 {
    if (!_cellModels1) {
        _cellModels1 = [NSMutableArray array];
    }
    return _cellModels1;
}

@end
