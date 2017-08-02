//
//  XSettingViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XSettingViewController.h"
#import "XSettingFooterView.h"
#import "XSettingCell.h"
#import "XRealNameVerifiVC.h"
#import "XGestureManagerVC.h"
#import "XLoginViewController.h"
#import "XForgetPwdVC.h"
//-------- 接口 ---------//
#import "XLogoutApi.h"
@interface XSettingViewController ()<UITableViewDataSource, UITableViewDelegate, XSettingFooterViewDelegate,YTKRequestDelegate,CustomAlertViewDelegate>

@property (nonatomic, strong) UITableView *settingView;
//退出API
@property(nonatomic,strong)XLogoutApi *logoutApi;

@end

@implementation XSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.settingView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.settingView reloadData];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSettingCell *cell = [XSettingCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    XSettingFooterView *footerView = [XSettingFooterView footerViewWithTableView:tableView];
    footerView.settingFooterViewDelegate = self;
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1){
        //实名认证
        XRealNameVerifiVC *realNameVerifiVC = [[XRealNameVerifiVC alloc]init];
        realNameVerifiVC.u_real_name = self.u_real_name;
        realNameVerifiVC.u_id_number = self.u_id_number;
        [self.navigationController pushViewController:realNameVerifiVC animated:YES];
    }else if(indexPath.row == 2){
        XForgetPwdVC *changePwdVC = [[XForgetPwdVC alloc]init];
        changePwdVC.title = @"修改登录密码";
        changePwdVC.resetOrChange = @"2";
        [self.navigationController pushViewController:changePwdVC animated:YES];

    }else if(indexPath.row == 3){
        XGestureManagerVC *gesManagerVC = [[XGestureManagerVC alloc]init];
        [self.navigationController pushViewController:gesManagerVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    if (indexPath.row == 0) {
        height = 1.000001;
    } else {
        height = 44;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 67;
}

#pragma mark - XSettingFooterViewDelegate
- (void)settingFooterView:(XSettingFooterView *)settingFooterView didClickOfLogoutButton:(UIButton *)logoutButton {
    [self showAlertViewWithTitle:@"提示" message:@"确定退出应用吗？" letfButtonTitle:@"取消" rightBtn:@"确定"];
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@" 退出登录 result = %@", result);
    NSInteger state = [result[@"status"] integerValue];
    //发送短信验证码
    if (request == _logoutApi) {
        if (state == 1) {
            //退出成功，返回到首页
            [UserManager clearUser];
            XLoginViewController *loginVC = [[XLoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }else{
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
}

- (void)clearRequest {
    
}

#pragma mark - CustomeAlertDelegate
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        //点击确定
        [self.logoutApi start];
    }else{
        [self completeLoadWithTitle:nil];
    }
}


#pragma mark - lazy
- (UITableView *)settingView {
    if (!_settingView) {
        _settingView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _settingView.backgroundColor = [XAppContext appColors].whiteColor;
        _settingView.dataSource = self;
        _settingView.delegate = self;
        _settingView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 13)];
    }
    return _settingView;
}

- (XLogoutApi *)logoutApi {
    if(!_logoutApi){
        _logoutApi = [[XLogoutApi alloc]initWithToken:[UserManager User].token];
        _logoutApi.delegate = self;
    }
    return _logoutApi;
}
@end
