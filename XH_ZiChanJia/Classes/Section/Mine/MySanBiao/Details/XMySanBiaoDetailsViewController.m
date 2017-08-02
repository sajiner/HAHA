//
//  XMySanBiaoDetailsViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/12.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMySanBiaoDetailsViewController.h"
#import "XMySanBiaoDetailView.h"
#import "XMySanBiaoInvestDetailApi.h"
#import "XMySanBiaoModel.h"
#import "XMySanBiaoDetailModel.h"
#import "XWebViewController.h"

@interface XMySanBiaoDetailsViewController ()<XMySanBiaoDetailViewDelegate, YTKRequestDelegate>

@property (nonatomic, strong) XMySanBiaoDetailView *detailView;
// 散标投资纪录详情接口
@property (nonatomic, strong) XMySanBiaoInvestDetailApi *detailApi;

@property (nonatomic, strong) XMySanBiaoDetailModel *detailModel;

@end

@implementation XMySanBiaoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [XAppContext appColors].backgroundColor;
    
     [self.detailApi start];
}

- (void)dealloc {
    NSLog(@"come here");
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 散标详情 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    if (request == _detailApi) {
        if (state == 1) {
            _detailModel = [XMySanBiaoDetailModel mj_objectWithKeyValues:result[@"data"]];
            [self.view addSubview:self.detailView];
        } else {
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
}

#pragma mark - XMySanBiaoDetailViewDelegate
- (void)mySanBiaoDetailView:(XMySanBiaoDetailView *)mySanBiaoDetailView didClickOfLoanProtocol:(UIButton *)LoanProtocolBtn {
    XWebViewController *webVc = [[XWebViewController alloc] init];
    webVc.urlString = _detailModel.contractUrl;
    webVc.navigationItem.title = @"借款协议";
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - lazy
- (XMySanBiaoDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[XMySanBiaoDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) planNums:_detailModel.list.count];
        _detailView.contentSize = CGSizeMake(0, _detailView.height + 80);
        _detailView.showsVerticalScrollIndicator = NO;
        _detailView.mySanBiaoDetailViewDelegate = self;
        _detailView.sanBiaoModel = _sanBiaoModel;
        _detailView.detailModel = _detailModel;
    }
    return _detailView;
}

- (XMySanBiaoInvestDetailApi *)detailApi {
    _detailApi = [[XMySanBiaoInvestDetailApi alloc] initWithToken:[UserManager User].token investId:_sanBiaoModel.investId];
    _detailApi.delegate = self;
    return _detailApi;
}

@end
