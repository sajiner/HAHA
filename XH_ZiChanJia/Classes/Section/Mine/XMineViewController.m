//
//  XMineViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMineViewController.h"
#import "UIBarButtonItem+XExtension.h"
#import "XMineTopCell.h"
#import "XMineMiddleCell.h"
#import "XMineBottomCell.h"
#import "XWebViewController.h"
#import "XSettingViewController.h"
#import "XHMessageViewController.h"
#import "XMySanBiaoViewController.h"
#import "XCapitalManageViewController.h"
#import "XMyMagicViewController.h"
#import "XToppedUpViewController.h"
#import "XWithdrawCashViewController.h"
#import "XUserApi.h"
#import "XMineModel.h"
#import "XMySanBiaoDetailsViewController.h"
#import "XDepositoryAccountViewController.h"
#import "XGoldAccountApi.h"
#import "XGoldViewController.h"
#import "XRealNameVerifiVC.h"
#import "XPacketApi.h"
#import "XDepositoryAccountModel.h"
#import "XGetNoticeApi.h"
#import "XLoginViewController.h"
#import "XMyMagicModel.h"
#import "XMyJiaYingViewController.h"

@interface XMineViewController ()<UITableViewDataSource, UITableViewDelegate, XMineBottomCellDelegate, XMineMiddleCellDelegate, XMineTopCellDelegate, YTKRequestDelegate, YTKBatchRequestDelegate, CustomAlertViewDelegate> {
    XDepositoryAccountModel *_depositoryAccountModel;
}

@property (nonatomic, strong) UITableView *mineView;
// 我的页面APi
@property (nonatomic, strong) XUserApi *userApi;
// 查看站内消息是否有未读APi
@property (nonatomic, strong) XGetNoticeApi *noticeApi;
// 我的页面的model
@property (nonatomic, strong) XMineModel *mineModel;
// 我的魔投页面的model
@property (nonatomic, strong) XMyMagicModel *magicModel;
// 开通金账户请求信息api
@property (nonatomic, strong) XGoldAccountApi *goldAccountApi;
// 获取最新的用户信息api(发送给后台)
@property (nonatomic, strong) XPacketApi *packetApi;

@end

@implementation XMineViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏的一些配置
    [self setupNavBar];
    
    [self.view addSubview:self.mineView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /// 设置导航栏的背景颜色，解决手势密码返回过来的颜色改变bug
//    self.navigationController.navigationBar.barTintColor = [XAppContext appColors].whiteColor;
//    self.navigationController.navigationBar.tintColor = [XAppContext appColors].blackColor;
    self.navigationController.hiddenLineView = YES;

    __weak typeof(self) weakSelf = self;
    self.mineView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.mineView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.mineView.mj_header endRefreshing];
}

- (void)dealloc {
    NSLog(@"come here");
}

#pragma mark - 加载网络数据
- (void)loadData {
    NSArray *apis = @[self.userApi, self.noticeApi];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apis];
    batchRequest.delegate = self;
    [batchRequest start];
}

#pragma mark - 跳转至站内公告、设置页面
- (void)goToMessageList {
    XHMessageViewController *messageVc = [[XHMessageViewController alloc] init];
    messageVc.navigationItem.title = @"站内消息";
    [self.navigationController pushViewController:messageVc animated:YES];
}

- (void)goToSetting {
    XSettingViewController *settingVc = [[XSettingViewController alloc] init];
    settingVc.u_real_name = self.mineModel.u_real_name;
    settingVc.u_id_number = self.mineModel.u_id_number;
    settingVc.navigationItem.title = @"设置";
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 设置导航栏的一些配置
- (void)setupNavBar {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"mine_setting" selImageName:@"mine_setting" target:self action:@selector(goToSetting)];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
        {
            XMineTopCell *cell = [XMineTopCell cellWithTableView:tableView];
            cell.topCellDelegate = self;
            cell.mineModel = self.mineModel;
            cell.mtBalance = _magicModel.signUserBalance0;
            return cell;
        }
            break;
        case 1:
        {
            XMineMiddleCell *cell = [XMineMiddleCell cellWithTableView:tableView];
            cell.middleCellDelegate = self;
            return cell;
        }
            break;
        case 2:
        {
            XMineBottomCell *cell = [XMineBottomCell cellWithTableView:tableView];
            cell.bottomCellDelegate = self;
            return cell;
        }
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    
    switch (indexPath.section) {
        case 0:
            if (!self.magicModel.signUserTotal) {
                height = 118;
            } else {
                height = 164;
            }
            break;
        case 1:
            height = 88;
            break;
        case 2:
            height = (ScreenWidth - 2) * 2 / 3 + 3;
            break;
    }
    return height;
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSDictionary *result = request.responseJSONObject;
    NSLog(@"result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    if (request == _goldAccountApi) {
        if (state == 1) {
            NSLog(@"%@", result[@"data"]);
            NSString *str = [[NSString alloc] UrlValueEncode:result[@"data"]];
            XGoldViewController *goldVc = [[XGoldViewController alloc] init];
            goldVc.navigationItem.title = @"存管账户";
            goldVc.params = [NSString stringWithFormat:@"json=%@", str];
            [self.navigationController pushViewController:goldVc animated:YES];
            _packetApi = [[XPacketApi alloc] initWithJson:result[@"data"]];
            [_packetApi start];
        } else {
            NSLog(@"%@", result[@"message"]);
            [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
    [self.mineView.mj_header endRefreshing];
}

#pragma mark - YTKBatchRequestDelegate
- (void)batchRequestFinished:(YTKBatchRequest *)batchRequest {
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSDictionary *result = request.responseJSONObject;
        NSLog(@"result = %@", result);
        NSInteger state = [result[@"status"] integerValue];
        if (request == _userApi) {
            if (state == 1) {
                
                self.mineModel = [XMineModel mj_objectWithKeyValues:result[@"data"][@"user"]];
                if (result[@"data"][@"signUser"]) {
                    self.magicModel = [XMyMagicModel mj_objectWithKeyValues:result[@"data"][@"signUser"]];
                }
                self.navigationItem.title = _mineModel.u_user_name;
                _depositoryAccountModel = [XDepositoryAccountModel mj_objectWithKeyValues:result[@"data"][@"user"]];
            } else if (state == 15) { // 用户未登录
                XLoginViewController *loginVc = [[XLoginViewController alloc] init];
                [self.navigationController pushViewController:loginVc animated:YES];
                return;
            } else {
                [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
                 NSLog(@"%@", result[@"message"]);
            }
            [self.mineView reloadData];
        } else if (request == _noticeApi) {
            if (state == 1) {
                NSArray *lists = result[@"data"][@"list"];
                if (lists.count > 0) { //有未读信息
                    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"mine_message_read" selImageName:@"mine_message_read" target:self action:@selector(goToMessageList)];
                } else {
                    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImageName:@"mine_message_unread" selImageName:@"mine_message_unread" target:self action:@selector(goToMessageList)];
                }
            } else {
                 NSLog(@"%@", result[@"message"]);
                [self showAlertViewWithTitle:@"温馨提示" message:result[@"message"] letfButtonTitle:nil rightBtn:@"嗯，我知道了"];
            }
        }
        [self.mineView.mj_header endRefreshing];
    }
}

- (void)batchRequestFailed:(YTKBatchRequest *)batchRequest {
    
    for (YTKBaseRequest *request in batchRequest.requestArray) {
        NSLog(@"网络error = %@", request);
    }
    [self.mineView.mj_header endRefreshing];
}

#pragma mark - XMineTopCellDelegate 我的魔投
- (void)topCell:(XMineTopCell *)topCell didClickOfCheckMyMagicButton:(UIButton *)checkMyMagicButton {
    if ([_mineModel.u_is_real_name_checked integerValue] == 0) { // 未实名认证
        XRealNameVerifiVC *realNameVc = [[XRealNameVerifiVC alloc] init];
        [self.navigationController pushViewController:realNameVc animated:YES];
    } else {
        XMyMagicViewController *myMagicVc = [[XMyMagicViewController alloc] init];
        myMagicVc.navigationItem.title = @"我的魔投";
        myMagicVc.magicModel = _magicModel;
        [self.navigationController pushViewController:myMagicVc animated:YES];
    }
}

#pragma mark - XMineMiddleCellDelegate 充值 提现
- (void)middleCell:(XMineMiddleCell *)middleCell didClickOfTypeButton:(XButtonType)type {
    switch (type) {
        case XButtonTypeToppedUp:  // 充值
        {
            if ([_mineModel.u_is_real_name_checked integerValue] == 0) { // 未实名认证
                XRealNameVerifiVC *realNameVc = [[XRealNameVerifiVC alloc] init];
                [self.navigationController pushViewController:realNameVc animated:YES];
            } else if ([_mineModel.u_is_magic_user integerValue] == 0) { // 未开金账户
                [self.goldAccountApi start];
            } else {
                XToppedUpViewController *toppedUpVc = [[XToppedUpViewController alloc] init];
                toppedUpVc.navigationItem.title = @"充值";
                toppedUpVc.balance = _mineModel.a_balance0;
                
                [self.navigationController pushViewController:toppedUpVc animated:YES];
            }
        }
            break;
        case XButtonTypeDrawCash:  // 提现
        {
            if ([_mineModel.u_is_real_name_checked integerValue] == 0) { // 未实名认证
                XRealNameVerifiVC *realNameVc = [[XRealNameVerifiVC alloc] init];
                [self.navigationController pushViewController:realNameVc animated:YES];
            } else if ([_mineModel.u_is_magic_user integerValue] == 0) { // 未开金账户
                [self.goldAccountApi start];
            } else {
                XWithdrawCashViewController *withdrawCashVc = [[XWithdrawCashViewController alloc] init];
                withdrawCashVc.navigationItem.title = @"提现";
                withdrawCashVc.balance0 = _mineModel.a_balance0;
                withdrawCashVc.balance = _mineModel.a_balance;
                [self.navigationController pushViewController:withdrawCashVc animated:YES];
            }
        }
            break;
    }
}

#pragma mark - XMineBottomCellDelegate
- (void)bottomCell:(XMineBottomCell *)bottomCell didSelectedItemAtTag:(NSInteger)tag {
    switch (tag) {
        case 1000:  // 我的散标
        {
            if ([_mineModel.u_is_real_name_checked integerValue] == 0) { // 未实名认证
                XRealNameVerifiVC *realNameVc = [[XRealNameVerifiVC alloc] init];
                [self.navigationController pushViewController:realNameVc animated:YES];
            } else if ([_mineModel.u_is_magic_user integerValue] == 0) { // 未开金账户
                [self.goldAccountApi start];
            } else {
                XMySanBiaoViewController *mySanBiaoVc = [[XMySanBiaoViewController alloc] init];
                mySanBiaoVc.navigationItem.title = @"我的散标";
                [self.navigationController pushViewController:mySanBiaoVc animated:YES];
            }
        }
            break;
        case 1001:  // 我的嘉盈
        {
            if ([_mineModel.u_is_real_name_checked integerValue] == 0) { // 未实名认证
                XRealNameVerifiVC *realNameVc = [[XRealNameVerifiVC alloc] init];
                [self.navigationController pushViewController:realNameVc animated:YES];
            } else if ([_mineModel.u_is_magic_user integerValue] == 0) { // 未开金账户
                [self.goldAccountApi start];
            } else {
                XMyJiaYingViewController *myJiaYingVc = [[XMyJiaYingViewController alloc] init];
                myJiaYingVc.navigationItem.title = @"我的嘉盈";
                [self.navigationController pushViewController:myJiaYingVc animated:YES];
            }
        }
            break;
        case 1002:  // 资金管理
        {
            if ([_mineModel.u_is_real_name_checked integerValue] == 0) { // 未实名认证
                XRealNameVerifiVC *realNameVc = [[XRealNameVerifiVC alloc] init];
                [self.navigationController pushViewController:realNameVc animated:YES];
            } else if ([_mineModel.u_is_magic_user integerValue] == 0) { // 未开金账户
                [self.goldAccountApi start];
            } else {
                XCapitalManageViewController *capitalManageVc = [[XCapitalManageViewController alloc] init];
                capitalManageVc.navigationItem.title = @"资金管理";
                [self.navigationController pushViewController:capitalManageVc animated:YES];
            }
        }
            break;
        case 1003:  // 存管账户
        {
            if ([_mineModel.u_is_real_name_checked integerValue] == 0) { // 未实名认证
                XRealNameVerifiVC *realNameVc = [[XRealNameVerifiVC alloc] init];
                [self.navigationController pushViewController:realNameVc animated:YES];
            } else if ([_mineModel.u_is_magic_user integerValue] == 0) { // 未开金账户
                [self.goldAccountApi start];
            } else {
                XDepositoryAccountViewController *depositoryAccountVc = [[XDepositoryAccountViewController alloc] init];
                depositoryAccountVc.navigationItem.title = @"存管账户";
                depositoryAccountVc.depositoryAccountModel = _depositoryAccountModel;
                [self.navigationController pushViewController:depositoryAccountVc animated:YES];
            }
        }
            break;
        case 1004:  // 风险偏好
        {
            XWebViewController *webVc = [[XWebViewController alloc] init];
            webVc.urlString = Request_riskLover;
            webVc.navigationItem.title = @"风险偏好";
            [self.navigationController pushViewController:webVc animated:YES];
        }
            break;
        case 1005:  // 在线客服
        {
            XWebViewController *webVc = [[XWebViewController alloc] init];
            webVc.urlString = Request_ChatOnLine;
            [self.navigationController pushViewController:webVc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - lazy
- (UITableView *)mineView {
    if (!_mineView) {
        _mineView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _mineView.backgroundColor = [UIColor whiteColor];
        _mineView.dataSource =self;
        _mineView.delegate = self;
        _mineView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mineView.tableFooterView = [[UIView alloc]init];
    }
    return _mineView;
}

- (XUserApi *)userApi {
    _userApi = [[XUserApi alloc] initWithToken:[UserManager User].token];
    return _userApi;
}

- (XGoldAccountApi *)goldAccountApi {
    _goldAccountApi = [[XGoldAccountApi alloc] initWithToken:[UserManager User].token type:@"1" client:@"1"];
    _goldAccountApi.delegate = self;
    return _goldAccountApi;
}

- (XGetNoticeApi *)noticeApi {
    _noticeApi = [[XGetNoticeApi alloc] initWithToken:[UserManager User].token status:@"0" pageNum:@"1" pageSize:@"10"];
    return _noticeApi;
}

@end
