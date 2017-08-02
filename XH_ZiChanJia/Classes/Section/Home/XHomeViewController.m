//
//  XHomeViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/9.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XHomeViewController.h"
#import "DXPopover.h"
#import "UIBarButtonItem+XExtension.h"
#import "XRegisterViewController.h"
#import "XHomeHeaderView.h"
#import "XHomeFooterView.h"
#import "XHomeServiceVC.h"
#import "XNavigationController.h"
#import "XSanBiaoTableViewCell.h"
#import "XSanBiaoDetailViewController.h"
#import "XWebViewController.h"
#import "XAssetBaoDetailViewController.h"
//-------- 接口 ---------//
#import "XHomeApi.h"
#import "XReminderApi.h"
#import "XReminder.h"
#import "XHomeBannerApi.h"
#import "XCheckVersionApi.h"
//轮播图的高度
#define ScrollPageHeight 180

@interface XHomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,YTKRequestDelegate,CycleViewDelegate,CustomAlertViewDelegate>
@property (nonatomic, strong) DXPopover *popover;
//左上角按钮
@property(nonatomic,strong)UIButton *leftButton;
//右上角按钮
@property(nonatomic,strong)UIButton *rightButton;
//banner URL字典数组
@property(nonatomic,strong)NSMutableArray *bannersArray;
//dataArray(嘉赢)
@property(nonatomic,strong)NSMutableArray *dataArray;
//dataArray2(散标)
@property(nonatomic,strong)NSMutableArray *dataArray2;
//tableView2
@property(nonatomic,strong)UITableView *tableView;
//headerView
@property(nonatomic,strong)XHomeHeaderView *headerView;
//平台公告的url
@property(nonatomic,copy)NSString *notifiStr;
//首页信息API
@property(nonatomic,strong)XHomeApi *homeApi;
//获取全部温馨提示的API
@property(nonatomic,strong)XReminderApi *reminderApi;
//轮播图API
@property(nonatomic,strong)XHomeBannerApi *homeBannerApi;
//检查版本更新API
@property(nonatomic,strong)XCheckVersionApi *checkVersionApi;

@end

@implementation XHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    //检查版本更新
//    [self.checkVersionApi start];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置左右navgationbar
    [self setupLeftAndRightrbutton];
    self.navigationController.navigationBar.hidden = YES;
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [XRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf.homeApi start];
        //请求轮播图
        [weakSelf.homeBannerApi start];
        //温馨提示请求
        [weakSelf.reminderApi start];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.tableView.mj_header endRefreshing];
    [self.dataArray removeAllObjects];
    [self.dataArray2 removeAllObjects];
    [self.headerView.cycleScrollView.timer invalidate];
    self.headerView.cycleScrollView.timer = nil;
}

#pragma mark - 设置左右按钮
- (void)setupLeftAndRightrbutton {
    [self.view addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(36);
        make.left.equalTo(self.view.mas_left).offset(15);
    }];
    [self.view addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftButton.mas_top);
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];
    if([UserManager User].token){
        self.rightButton.hidden = YES;
    }else{
        self.rightButton.hidden = NO;
    }
}

#pragma mark - 左右两个Button点击事件
- (void)leftButtonClick {
    XHomeServiceVC *serviceVC = [[XHomeServiceVC alloc]init];
    [self.navigationController pushViewController:serviceVC animated:YES];}

- (void)rightButtonClick {
    //跳转到注册页面
    XRegisterViewController *registerVC = [[XRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - 轮播图点击事件代理方法
-(void)selectedItemAtIndex:(NSInteger)index{
    NSLog(@"轮播图点击了----%ld",index);
    XWebViewController *webVC = [[XWebViewController alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@",self.bannersArray[index][@"linkurl"]];
    webVC.urlString = urlStr;
    [self.navigationController pushViewController:webVC animated:YES];
//    [self completeLoadWithTitle:[NSString stringWithFormat:@"h5页面没有给---%ld",index]];
}

#pragma mark - 四个按钮点击事件
- (void)btnClick:(UITapGestureRecognizer *)sender {
    NSLog(@"跳转到---%ld",[sender view].tag);
    if([sender view].tag == 0){
        NSLog(@"跳转到银行存管");
        XWebViewController *bankSave = [[XWebViewController alloc]init];
        bankSave.urlString = BackSaveH5;
        [self.navigationController pushViewController:bankSave animated:YES];
    }else if([sender view].tag == 1){
        NSLog(@"跳转到备付金");
        XWebViewController *beiYongJin = [[XWebViewController alloc]init];
        beiYongJin.urlString = BeiYongJin;
        [self.navigationController pushViewController:beiYongJin animated:YES];
    }else if([sender view].tag == 2){
        NSLog(@"跳转到技术安全");
        XWebViewController *techSecurity = [[XWebViewController alloc]init];
        techSecurity.urlString = TechnologySecurity;
        [self.navigationController pushViewController:techSecurity animated:YES];
    }else if([sender view].tag == 3){
        NSLog(@"跳转到资产无忧");
        XWebViewController *ziChanWuYou = [[XWebViewController alloc]init];
        ziChanWuYou.urlString = ZiChanWuYou;
        [self.navigationController pushViewController:ziChanWuYou animated:YES];
    }else{
    
    }
}

#pragma mark - 顶部轮播图的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.tableView){
        self.leftButton.alpha = 1 - (scrollView.contentOffset.y / 150);
        self.rightButton.alpha = 1 - (scrollView.contentOffset.y / 150);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.headerView.cycleScrollView.timer invalidate];
    self.headerView.cycleScrollView.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.headerView.cycleScrollView addCycleTimer];
}

#pragma mark - 公告栏点击事件
- (void)notifiBtnClick {
    XWebViewController *webVC = [[XWebViewController alloc]init];
    webVC.urlString = self.notifiStr;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return self.dataArray.count >2 ? 2 : self.dataArray.count;
    }else if(section == 1){
        return self.dataArray2.count >2 ? 2 : self.dataArray2.count;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 28)];
    [tableView addSubview:headerView];
   
    UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 5, 20)];
    blueView.backgroundColor = [XAppContext appColors].blueColor;
    blueView.centerY = headerView.centerY+5;
    [headerView addSubview:blueView];
   
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(blueView.frame)+10, 0, 100, 30)];
    titleLbl.centerY = blueView.centerY;
    titleLbl.font = [XAppContext appFonts].font_15;
    titleLbl.textColor = [XAppContext appColors].blackColor;
    [headerView addSubview:titleLbl];
    if(section == 0){
        titleLbl.text = @"优选专区";
        return headerView;
    }else{
        titleLbl.text = @"精选散标";
        return headerView;
    }
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSanBiaoTableViewCell *cell = [XSanBiaoTableViewCell cellWithTableView:tableView];
    if((self.dataArray.count>0) && (self.dataArray2.count>0)){
        if(indexPath.section == 0){
            [cell setModel:self.dataArray[indexPath.row] flag:NO];
        }else if(indexPath.section == 1){
            [cell setModel:self.dataArray2[indexPath.row] flag:YES];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        XSanBiaoModel *model = ((XSanBiaoModel *)self.dataArray[indexPath.row]);
        XAssetBaoDetailViewController *detail = [[XAssetBaoDetailViewController alloc] init];
        detail.pid = model.p_id;
        detail.p_project_status = model.p_project_status;
        detail.start_time = model.p_start_time;
        [self.navigationController pushViewController:detail animated:YES];
    }else if(indexPath.section == 1){
        XSanBiaoModel *model = ((XSanBiaoModel *)self.dataArray2[indexPath.row]);
        XSanBiaoDetailViewController *detail = [[XSanBiaoDetailViewController alloc] init];
        detail.pid = model.p_id;
        detail.m_project_status = model.m_project_status;
        detail.start_time = model.p_start_time;
        [self.navigationController pushViewController:detail animated:YES];
    }

}

#pragma mark - CustomAlertViewDelegate
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //强制更新
    if(alertView.tag==1){
        switch (buttonIndex) {
            case 0:{
                NSString *appStoreLink = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/zi-chan-jia-nin-tie-xin-zi/id1060020723?mt=8"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
                [self exitApplication];
                break;
            }
            default:
                break;
        }
    }else{
    //手动更新
        switch (buttonIndex) {
            case 0:{
                [alertView removeFromSuperview];
                break;
            }
            case 1:{

                NSString *appStoreLink = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/zi-chan-jia-nin-tie-xin-zi/id1060020723?mt=8"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
                break;
            }
            default:
                break;
        }
    }
};

- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view.window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    self.view.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(YTKBaseRequest *)request {
    NSLog(@"%@",request.requestUrl);
    NSDictionary *result = request.responseJSONObject;
    NSLog(@"===== 首页 result = %@------", result);
    NSInteger state = [result[@"status"] integerValue];
    //首页
    if (request == _homeApi) {
        if (state == 1) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
            //金额的格式（保留两位小数）
            formatter.numberStyle =kCFNumberFormatterCurrencyStyle;
            NSString *turnoverTempStr = [formatter stringFromNumber:[NSNumber numberWithInt:[(result[@"data"][@"homeInfo"][@"moneycount"] ? result[@"data"][@"homeInfo"][@"moneycount"] : @"0.00")intValue]]];
            //去除首位的“¥”
            self.headerView.turnoverString = [turnoverTempStr substringFromIndex:1];
            //用户数的格式（不保留两位小数）
            formatter.numberStyle =kCFNumberFormatterDecimalStyle;
            self.headerView.userNumberString = [formatter stringFromNumber:[NSNumber numberWithInt:[(result[@"data"][@"homeInfo"][@"usercount"] ? result[@"data"][@"homeInfo"][@"usercount"] : @"0.00")intValue]]];
            //dataArray
            self.dataArray = [XSanBiaoModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"assetPackageInfo"]];
            self.dataArray2 = [XSanBiaoModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"standardPowderInfo"]];
            [self.tableView reloadData];
        }else{
            //弹框提示错误信息
            NSLog(@"%@",result[@"message"]);
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }
    //温馨提示
    if(request == _reminderApi){
        if(state == 1){
            //判断是否为空数组
            NSArray *dataArray = result[@"data"];
            if(dataArray.count > 0){
                //获取全部的温馨提示
                [XReminder sharedReminder].registReminder = [NSString stringWithFormat:@"%@",result[@"data"][0][@"a_value"]];
                [XReminder sharedReminder].nameVerifi = [NSString stringWithFormat:@"%@",result[@"data"][1][@"a_value"]];
                [XReminder sharedReminder].riskUserDefault = [NSString stringWithFormat:@"%@",result[@"data"][2][@"a_value"]];
                [XReminder sharedReminder].recharge = [NSString stringWithFormat:@"%@",result[@"data"][3][@"a_value"]];
                [XReminder sharedReminder].withdraw = [NSString stringWithFormat:@"%@",result[@"data"][4][@"a_value"]];
                [XReminder sharedReminder].userName = [NSString stringWithFormat:@"%@",result[@"data"][5][@"a_value"]];
            }
        }
    }
    //轮播图
    if(request == _homeBannerApi){
        self.bannersArray = result[@"banner"];
        self.headerView.cycleScrollView.models = self.bannersArray;
        NSMutableString *tempstr = result[@"notice"][0][@"title"];
        if([tempstr length] > 18){
            tempstr = [NSMutableString stringWithString:[tempstr substringToIndex:18]];
        }
        self.headerView.notifyTitleString = tempstr;
        self.notifiStr = result[@"notice"][0][@"url"];
    }
    //版本更新
    if(request == _checkVersionApi){
        if(state == 1){
            NSString *currentVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            NSString *latestVer = result[@"data"][0][@"v_app_version"];
            //版本描述
            NSString *message=[NSString stringWithFormat:@"%@",[[result objectForKey:@"data"][0] objectForKey:@"v_newversion_descripe"]];
            //1强制  2选择
            NSString *publishWay=[NSString stringWithFormat:@"%@",[[result objectForKey:@"data"][0] objectForKey:@"v_publish_way"]];
            if(![latestVer isEqualToString:@""]){
                if([latestVer compare:currentVer] == NSOrderedDescending){
                    NSLog(@"最新版是：%@--当前版本是：%@---请更新",latestVer,currentVer);
                    //强制更新
                    if([publishWay isEqualToString:@"1"]){
                        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:@"发现新版本" message:message delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                        alert.delegate = self;
                        alert.tag=1;
                        [alert show];
                    }else{
                        //手动更新
                        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:@"发现新版本" message:message delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"下次再说", nil];
                        alert.delegate = self;
                        alert.tag=2;
                        [alert show];
                    }
                    return ;
                }
            }
        }
    }
    [self.tableView.mj_header endRefreshing];
}

- (void)requestFailed:(YTKBaseRequest *)request {
    NSLog(@"请求失败%@", request);
    [self.tableView.mj_header endRefreshing];
}

- (void)clearRequest {
    
}

#pragma mark - 懒加载
- (UIButton *)leftButton {
    if(!_leftButton){
        _leftButton = [[UIButton alloc]init];
        [_leftButton setEnlargeEdgeWithTop:5 right:5 bottom:5 left:5];
        [_leftButton sizeToFit];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"home_platIntroduce"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if(!_rightButton){
        _rightButton = [[UIButton alloc]init];
        [_rightButton setEnlargeEdgeWithTop:5 right:5 bottom:5 left:5];
        [_rightButton sizeToFit];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"home_register"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 44) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [XAppContext appColors].backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    }
    return _tableView;
}

- (XHomeHeaderView *)headerView {
    if(!_headerView){
        _headerView = [[XHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 375)];
        _headerView.cycleScrollView.delegate = self;
        [_headerView.btn1 setupTitle:@"银行存管" imgName:@"home_bankCunGuan" target:self action:@selector(btnClick:)];
        [_headerView.btn2 setupTitle:@"保障金" imgName:@"home_beiFuJin" target:self action:@selector(btnClick:)];
        [_headerView.btn3 setupTitle:@"技术安全" imgName:@"home_technologySecurity" target:self action:@selector(btnClick:)];
        [_headerView.btn4 setupTitle:@"资产无忧" imgName:@"home_propertyNocare" target:self action:@selector(btnClick:)];
        [_headerView.notifyView addTarget:self action:@selector(notifiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

- (NSMutableArray *)bannersArray {
    if(!_bannersArray){
        _bannersArray = [NSMutableArray array];
    }
    return _bannersArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)dataArray2{
    if (!_dataArray2) {
        _dataArray2 = [NSMutableArray array];
    }
    return _dataArray2;
}

- (XHomeApi *)homeApi {
    if(!_homeApi){
        _homeApi = [[XHomeApi alloc]init];
        _homeApi.delegate = self;
    }
    return _homeApi;
}

- (XReminderApi *)reminderApi {
    if(!_reminderApi){
        _reminderApi = [[XReminderApi alloc]initWithKey:@"0"];
        _reminderApi.delegate = self;
    }
    return _reminderApi;
}

- (XHomeBannerApi *)homeBannerApi {
    if(!_homeBannerApi){
        _homeBannerApi = [[XHomeBannerApi alloc]init];
        _homeBannerApi.delegate = self;
    }
    return _homeBannerApi;
}

- (XCheckVersionApi *)checkVersionApi {
    if(!_checkVersionApi){
        _checkVersionApi = [[XCheckVersionApi alloc]initWithSystem:@"ios"];
        _checkVersionApi.delegate = self;
    }
    return _checkVersionApi;
}
@end
