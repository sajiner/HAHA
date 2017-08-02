//
//  XHMessageViewController.m
//  XinHe_JinRong
//
//  Created by sajiner on 16/7/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHMessageViewController.h"
#import "XHMessageModel.h"
#import "XHMessageCell.h"
#import "XGetNoticeApi.h"
#import "XUpdateNoticeApi.h"
#import "XMessageDetailViewController.h"

@interface XHMessageViewController ()<UITableViewDelegate, UITableViewDataSource, YTKRequestDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArr;
// 站内消息APi
@property (nonatomic, strong) XGetNoticeApi *noticeApi;
// 消息全部已读
@property (nonatomic, strong) XUpdateNoticeApi *updateApi;
// 无数据的时候显示的图片
@property (nonatomic, strong) UIImageView *imgView;
// 获取当前页的数据
@property (nonatomic, assign) int currentPage;
// 消息id
@property (nonatomic, copy) NSString *messageId;

@end

@implementation XHMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initElement];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全部已读" style:UIBarButtonItemStylePlain target:self action:@selector(updateNotice)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf.noticeApi start];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage ++;
        [weakSelf.noticeApi start];
    }];
}

- (void)dealloc {
    NSLog(@"come here");
}

#pragma mark - 初始化方法
- (void)initElement {
    self.view.backgroundColor = [XAppContext appColors].backgroundColor;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [XAppContext appColors].lineColor;
    lineView.frame = CGRectMake(0, 13, ScreenWidth, 1);
    [self.view addSubview:lineView];
    
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, lineView.bottom, ScreenWidth, ScreenHeight - lineView.bottom);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView = tableView;
}

#pragma mark - rightNavigationBar点击事件
- (void)updateNotice {
    _messageId = @"-1";
    [self.updateApi start];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XHMessageModel *model = _modelArr[indexPath.row];
    XHMessageCell *cell = [XHMessageCell cellWithTableView: tableView];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XHMessageModel *model = _modelArr[indexPath.row];
    _messageId = [NSString stringWithFormat:@"%ld", model.messageId];
    [self.updateApi start];
    
    XMessageDetailViewController *detailVc = [[XMessageDetailViewController alloc] init];
    detailVc.navigationItem.title = @"站内消息详情";
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 站内消息 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    if (request == _noticeApi) {
        if (state == 1) {
            if (_currentPage == 1) {
                [self.modelArr removeAllObjects];
            }
            NSArray *array = [NSArray array];
            array = [XHMessageModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
            [_modelArr addObjectsFromArray:array];
            if (_modelArr.count == 0) {
                [self.tableView addSubview:self.imgView];
                self.tableView.mj_footer.hidden = YES;
            } else {
                self.tableView.mj_footer.hidden = NO;
                [self.imgView removeFromSuperview];
            }
            [self.tableView reloadData];
        } else {
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } else if (request == _updateApi) {
        if (state == 1) {
            if ([_messageId isEqualToString:@"-1"]) {
                _currentPage = 1;
                [self.noticeApi start];
            }
        } else {
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
}

#pragma mark - lazy
- (NSMutableArray *)modelArr {
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (XGetNoticeApi *)noticeApi {
    _noticeApi = [[XGetNoticeApi alloc] initWithToken:[UserManager User].token status:@"-1" pageNum:[NSString stringWithFormat:@"%d", _currentPage] pageSize:@"10"];
    _noticeApi.delegate = self;
    return _noticeApi;
}

- (XUpdateNoticeApi *)updateApi {
    _updateApi = [[XUpdateNoticeApi alloc] initWithToken:[UserManager User].token messageId:_messageId];
    _updateApi.delegate = self;
    return _updateApi;
}


- (UIImageView *)imgView {
    if (!_imgView) {
        // 无数据的时候显示的图片
        _imgView= [[UIImageView alloc] initWithFrame:self.tableView.bounds];
        _imgView.contentMode = UIViewContentModeCenter;
        _imgView.image = [UIImage imageNamed:@"noDataImage"];
    }
    return _imgView;
}
@end
