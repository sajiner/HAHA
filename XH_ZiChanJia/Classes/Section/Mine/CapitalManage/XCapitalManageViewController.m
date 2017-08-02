//
//  XCapitalManageViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XCapitalManageViewController.h"
#import "XCapitalManageSectionModel.h"
#import "XCapitalManageCellModel.h"
#import "XCapitalManageApi.h"
#import "XCapitalManageCell.h"

@interface XCapitalManageViewController ()<UITableViewDataSource, UITableViewDelegate, YTKRequestDelegate>

@property (nonatomic, strong) UITableView *capitalManageView;
// 组数据模型
@property (nonatomic, strong) NSMutableArray *sectionArr;
// 资金管理api
@property (nonatomic, strong) XCapitalManageApi *capitalManageApi;
// 无数据的时候显示的图片
@property (nonatomic, strong) UIImageView *imgView;
// 当前页数
@property (nonatomic, assign) int currentPage;

@end

@implementation XCapitalManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.capitalManageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    self.capitalManageView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf.capitalManageApi start];
    }];
    [self.capitalManageView.mj_header beginRefreshing];
    
    self.capitalManageView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage ++;
        [weakSelf.capitalManageApi start];
    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    XCapitalManageSectionModel *sectionModel = _sectionArr[section];
    
    return sectionModel.sublist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCapitalManageSectionModel *sectionModel = _sectionArr[indexPath.section];
    XCapitalManageCellModel *cellModel = sectionModel.sublist[indexPath.row];
    XCapitalManageCell *cell = [XCapitalManageCell cellWithTableView:tableView];
    cell.cellModel = cellModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCapitalManageSectionModel *sectionModel = _sectionArr[indexPath.section];
    XCapitalManageCellModel *cellModel = sectionModel.sublist[indexPath.row];
    
    if (cellModel.fold) {
        return 135;
    } else {
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    XCapitalManageSectionModel *sectionModel = _sectionArr[section];
    if (section >= 1) {
        XCapitalManageSectionModel *formorSectionModel = _sectionArr[section - 1];
        if (formorSectionModel.month == sectionModel.month) {
            
            return 0;
        }
        else {
            return 44;
        }
    } else {
        return 44;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    XCapitalManageSectionModel *sectionModel = _sectionArr[section];
    
    static NSString *headerID = @"headerCell";
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerID];
    }
    headerView.textLabel.text = sectionModel.month0;
    headerView.contentView.backgroundColor = [XAppContext appColors].backgroundColor;
    headerView.textLabel.textColor = [XAppContext appColors].blackColor;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCapitalManageSectionModel *sectionModel = _sectionArr[indexPath.section];
    
    XCapitalManageCellModel *cellModel = sectionModel.sublist[indexPath.row];
    
    cellModel.fold = !cellModel.fold;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 资金管理 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    if (request == _capitalManageApi) {
        if (state == 1) {
           NSArray *dateJsonGroupArr = result[@"data"][@"list"];
            if (_currentPage == 1) {
                [self.sectionArr removeAllObjects];
            }
            NSArray *array = [NSArray array];
            array = [XCapitalManageSectionModel mj_objectArrayWithKeyValuesArray:dateJsonGroupArr];
            [_sectionArr addObjectsFromArray:array];
            if (_sectionArr.count == 0) {
                [self.capitalManageView addSubview:self.imgView];
                self.capitalManageView.mj_footer.hidden = YES;
            } else {
                self.capitalManageView.mj_footer.hidden = NO;
                [self.imgView removeFromSuperview];
            }
            [self.capitalManageView reloadData];
        } else {
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
        [self.capitalManageView.mj_header endRefreshing];
        [self.capitalManageView.mj_footer endRefreshing];
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
    [self.capitalManageView.mj_header endRefreshing];
    [self.capitalManageView.mj_footer endRefreshing];
}

#pragma mark - lazy
- (UITableView *)capitalManageView {
    if (!_capitalManageView) {
        _capitalManageView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _capitalManageView.dataSource = self;
        _capitalManageView.delegate = self;
        _capitalManageView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _capitalManageView.backgroundColor = [XAppContext appColors].backgroundColor;
    }
    return _capitalManageView;
}

- (NSMutableArray *)sectionArr {
    
    if (!_sectionArr) {
        
        _sectionArr = [NSMutableArray array];
    }
    return _sectionArr;
}

- (XCapitalManageApi *)capitalManageApi {
    _capitalManageApi = [[XCapitalManageApi alloc] initWithToken:[UserManager User].token pageNum:[NSString stringWithFormat:@"%d", _currentPage]  pageSize:@"10"];
    _capitalManageApi.delegate = self;
    return _capitalManageApi;
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
