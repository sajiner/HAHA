//
//  XMyMagicViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XMyMagicViewController.h"
#import "XMyMagicCell.h"
#import "XMyMagicFooterView.h"
#import "XMyMagicHeaderView.h"
#import "XMyMagicModel.h"

@interface XMyMagicViewController ()<UITableViewDataSource, UITableViewDelegate, XMyMagicFooterViewDelegate> {
    // 请求回来的数据（"魔投资产总额（元）", "累计收益（元）", "待收收益（元））
    NSArray *_contents;
}

@property (nonatomic, strong) UITableView *myMagicView;

@end

@implementation XMyMagicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myMagicView];
    // 去掉导航栏底部线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _myMagicView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
//        sleep(1);
//        [_myMagicView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMyMagicCell *cell = [XMyMagicCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.magicModel = _magicModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMyMagicHeaderView *headerView = [XMyMagicHeaderView headerViewWithTableView:tableView];
    headerView.balance = _magicModel.signUserBalance0;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    XMyMagicFooterView *footerView = [XMyMagicFooterView footerViewWithTableView:tableView];
    footerView.myMagicFooterViewDelegate = self;
    return footerView;
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

#pragma mark - XMyMagicFooterViewDelegate
- (void)myMagicFooterView:(XMyMagicFooterView *)myMagicFooterView didClickOfButton:(UIButton *)sneder {
    NSLog(@"转出到资产家");
}

#pragma mark - lazy
- (UITableView *)myMagicView {
    if (!_myMagicView) {
        _myMagicView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _myMagicView.backgroundColor = [XAppContext appColors].whiteColor;
        _myMagicView.dataSource = self;
        _myMagicView.delegate = self;
        _myMagicView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 13)];
    }
    return _myMagicView;
}

@end
