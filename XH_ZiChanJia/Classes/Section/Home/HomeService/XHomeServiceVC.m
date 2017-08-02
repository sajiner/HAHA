//
//  XHomeServiceVC.m
//  XH_ZiChanJia
//
//  Created by 我的iMac on 16/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeServiceVC.h"
#import "XHomeServiceCell.h"
#import "XWebViewController.h"
#import "XFeedBackVC.h"
@interface XHomeServiceVC ()<UITableViewDataSource,UITableViewDelegate,CustomAlertViewDelegate>
//tableView
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation XHomeServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资产家服务";
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - UITableView的数据源和代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    XHomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[XHomeServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row == 0){
        [cell setupIcon:@"home_introduce" title:@"平台介绍" havrArrow:YES haveDetailTitle:NO];
    }else if(indexPath.row == 1){
        [cell setupIcon:@"home_help" title:@"帮助中心" havrArrow:YES haveDetailTitle:NO];

    }else if(indexPath.row == 2){
        [cell setupIcon:@"homt_feedBack" title:@"意见反馈" havrArrow:YES haveDetailTitle:NO];

    }else if(indexPath.row == 3){
        [cell setupIcon:@"home_hotline" title:@"客服热线" havrArrow:YES haveDetailTitle:YES];
            cell.detailLabel.text = @"400-015-0808";
    }else {
        [cell setupIcon:@"home_version" title:@"当前版本" havrArrow:NO haveDetailTitle:YES];
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.detailLabel.text = [NSString stringWithFormat:@"V%@",version];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        NSLog(@"跳转到平台介绍");
        XWebViewController *platIntroduceVC = [[XWebViewController alloc]init];
        platIntroduceVC.urlString = @"http://app.xinhe99.com/pxq_app/views/other/floor_introduce.html";
        [self.navigationController pushViewController:platIntroduceVC animated:YES];
    }else if(indexPath.row == 1){
        NSLog(@"跳转到帮助中心");
        XWebViewController *helpCenterVC = [[XWebViewController alloc]init];
        helpCenterVC.urlString = @"http://app.xinhe99.com/pxq_app/views/other/help.html";
        [self.navigationController pushViewController:helpCenterVC animated:YES];
    }else if(indexPath.row == 2){
        NSLog(@"跳转到意见反馈");
        XFeedBackVC *feedbackVC = [[XFeedBackVC alloc]init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }else if(indexPath.row == 3){
        [self showAlertViewWithTitle:@"400-015-0808" message:@"周一至周五 9:00-21:00                     周六至周日 9:00-18:00" letfButtonTitle:@"拨打" rightBtn:@"取消"];
    }else {
       
    }
}

#pragma mark - 懒加载
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        [self completeLoadWithTitle:nil];
    }else{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-015-0808"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight ) style:UITableViewStylePlain];
        _tableView.separatorColor = [XAppContext appColors].lineColor;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
