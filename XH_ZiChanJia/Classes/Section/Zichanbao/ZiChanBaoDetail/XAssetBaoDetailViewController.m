//
//  XAssetBaoDetailViewController.m
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XAssetBaoDetailViewController.h"
#import "XAssetPackageDetailApi.h"
#import "XAssetBaoDetailScrollView.h"
#import "XLoginViewController.h"
#import "XRealNameVerifiVC.h"
#import "XGoldAccountApi.h"
#import "XGoldViewController.h"
#import "XPacketApi.h"
#import "XSanBiaoInvestFormViewController.h"

@interface XAssetBaoDetailViewController ()<YTKRequestDelegate,UIScrollViewDelegate>{
    NSTimer *_timer;
    NSInteger _hour;
    NSInteger _minute;
    NSInteger _second;
}

@property (nonatomic,strong)XAssetPackageDetailApi *assetpackageDetailApi;
@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong)XAssetBaoDetailScrollView *scrollView;
@property (nonatomic,strong) XGoldAccountApi *goldAccountApi;// 开通金账户请求信息api
@property (nonatomic,strong) XPacketApi *packetApi;// 获取最新的用户信息api(发送给后台)

@end

@implementation XAssetBaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [XAppContext appColors].whiteColor;
    self.title = @"嘉盈";
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.confirmBtn];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.assetpackageDetailApi start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)computeTime:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    NSDateComponents *components = [NSDate computeTimeWithStartDate:startDate endDate:endDate];
    _hour = [components hour];
    _minute = [components minute];
    _second = [components second];
    
    if (_hour>=0 && _minute>=0 && _second>=0) {
        self.confirmBtn.hidden = NO;
        [_timer setFireDate:[NSDate distantPast]];
    }
}

//倒计时
- (void)timerAction{
    if (_second==0 && _minute==0 && _hour==0) {
        [self performSelector:@selector(viewWillAppear:)];
        [self deallocTimer];
    }
    _second--;
    if (_second==-1) {
        _second=59;
        _minute--;
        if (_minute==-1) {
            _minute=59;
            _hour--;
        }
    }
    NSString *titleStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld后开抢",_hour,_minute,_second];
    [self setBtnTitle:titleStr bgColor:[XAppContext appColors].lightGrayColor enable:NO];
    
}

- (void)deallocTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setBtnName{
    
    switch (self.p_project_status) {
        case XAssetStatueBid:{
            break;
        }
        case XAssetStatueComingSoon:
            self.confirmBtn.hidden = NO;
            [self setBtnTitle:@"立即投资" bgColor:[XAppContext appColors].blueColor enable:YES];
            break;
        case XAssetStatueCompleted:{
            self.confirmBtn.hidden = NO;
            self.scrollView.statusImageV.image = [UIImage imageNamed:@"asset_status_normal_pay"];
            [self setBtnTitle:@"查看其他项目" bgColor:[XAppContext appColors].blueColor enable:YES];
            break;
        }
        case XAssetStatueFinish:
        case XAssetStatueEndPass:
        {
            self.confirmBtn.hidden = NO;
            self.scrollView.statusImageV.image = [UIImage imageNamed:@"asset_status_finish"];
            [self setBtnTitle:@"查看其他项目" bgColor:[XAppContext appColors].blueColor enable:YES];
            break;
        }
    }
}

- (void)setBtnTitle:(NSString *)title bgColor:(UIColor *)color enable:(BOOL)enable{
    
    [self.confirmBtn setTitle:title forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:color];
    self.confirmBtn.enabled = enable;
}


#pragma mark - request method
- (void)confirm:(UIButton *)sender{
    //1、点击底部的立即投资时，先后判断有无登录、有无实名认证、有无开通托管，若没有，则跳转到对应的页面，完成相应操作后 才可以投资散标
    switch (self.p_project_status) {
        case XAssetStatueBid:
            break;
        case XAssetStatueComingSoon:{
            if (![UserManager User].token) {
                CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"请先登录" delegate:self cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
                customAlert.tag = 1000;
                [customAlert show];
                return;
            }
            if (![[UserManager User].nameChecked isEqualToString:@"1"]) {
                CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"请先实名认证" delegate:self cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
                customAlert.tag = 1001;
                [customAlert show];
                return;
            }
            if (![[UserManager User].magicUser isEqualToString:@"1"]) {
                CustomAlertView *customAlert = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"请先开通金账户" delegate:self cancelButtonTitle:@"嗯，我知道了" otherButtonTitles:nil, nil];
                customAlert.tag = 1002;
                [customAlert show];
                return;
            }
            
            XSanBiaoInvestFormViewController *sanbiaoInvest = [[XSanBiaoInvestFormViewController alloc] init];
            sanbiaoInvest.model = self.scrollView.detailModel;
            sanbiaoInvest.pid = self.pid;
            sanbiaoInvest.title = @"嘉盈";
            [self.navigationController pushViewController:sanbiaoInvest animated:YES];
            break;}
        case XAssetStatueCompleted:
        case XAssetStatueFinish:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
}

#pragma mark - customer alter delegate
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (alertView.tag) {
        case 1000:{
            XLoginViewController *loignVC = [[XLoginViewController alloc] init];
            [self.navigationController pushViewController:loignVC animated:YES];
            break;}
        case 1001:{
            XRealNameVerifiVC *nameVerVC = [[XRealNameVerifiVC alloc] init];
            [self.navigationController pushViewController:nameVerVC animated:YES];
            break;}
        case 1002:{
            [self.goldAccountApi start];
            break;}
        default:
            break;
    }
}
#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIPanGestureRecognizer* pan = scrollView.panGestureRecognizer;
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity<-5) {//向上
        self.scrollView.arrowImgV.image = [UIImage imageNamed:@"arrow_down"];
    }
    else if (velocity>5) {//向下
        self.scrollView.arrowImgV.image = [UIImage imageNamed:@"arrow_up"];
    }
}

#pragma mark - YTKRequestDelegate
- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    NSDictionary *result = request.responseJSONObject;
    NSInteger state = [result[@"status"] integerValue];
    if (request == _assetpackageDetailApi) {
        
        if (state == 1) {
            NSDictionary *dic = [[request.responseObject objectForKey:@"data"] objectForKey:@"data"];
            NSDictionary *listDic = [[request.responseObject objectForKey:@"data"] objectForKey:@"info"];
            XSanBiaoDetailModel *model = [XSanBiaoDetailModel mj_objectWithKeyValues:dic];
            self.scrollView.detailModel = model;
            self.p_project_status = [model.p_project_status integerValue];

            [self setBtnName];
            if (self.p_project_status == XAssetStatueBid) {
                [self computeTime:[[NSDate dateFormatter]dateFromString:[dic objectForKey:@"now"]] endDate:[[NSDate dateFormatter]dateFromString:[dic objectForKey:@"p_start_time"]]];
            }else{
                [self deallocTimer];
            }
            
            
            NSArray *listArr = [XAssetBaoListModel mj_objectArrayWithKeyValuesArray:listDic];
            self.scrollView.arrayList = listArr;
        }else{
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }else if (request == _goldAccountApi) {
        
        if (state == 1) {
            NSString *str = [[NSString alloc] UrlValueEncode:result[@"data"]];
            XGoldViewController *goldVc = [[XGoldViewController alloc] init];
            goldVc.navigationItem.title = @"存管账户";
            goldVc.params = [NSString stringWithFormat:@"json=%@", str];
            [self.navigationController pushViewController:goldVc animated:YES];
            _packetApi = [[XPacketApi alloc] initWithJson:result[@"data"]];
            [_packetApi start];
        } else {
            [self completeLoadWithTitle:(result[@"message"] ? result[@"message"] : @"")];
        }
    }

}

- (void)requestFailed:(__kindof YTKBaseRequest *)request{
    NSLog(@"___requestFailed__%@__",request);
}

#pragma mark - lazy

- (XAssetBaoDetailScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[XAssetBaoDetailScrollView alloc] initWithFrame:self.view.frame statusFlag:self.p_project_status];
        _scrollView.delegate =  self;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithFrame:CGRectMake(15, CGRectGetMaxY(self.view.frame) - 120, ScreenWidth- 30, 40) title:@"hello" titleColor:[XAppContext appColors].whiteColor titleFont:[XAppContext appFonts].font_14 image:[UIImage imageNamed:@""]];
        [_confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.hidden = YES;
    }
    return _confirmBtn;
}

- (XGoldAccountApi *)goldAccountApi {
    _goldAccountApi = [[XGoldAccountApi alloc] initWithToken:[UserManager User].token type:@"1" client:@"1"];
    _goldAccountApi.delegate = self;
    return _goldAccountApi;
}

- (XAssetPackageDetailApi *)assetpackageDetailApi{
    if (!_assetpackageDetailApi) {
        _assetpackageDetailApi = [[XAssetPackageDetailApi alloc] initWithPId:self.pid];
        _assetpackageDetailApi.delegate = self;
    }
    return _assetpackageDetailApi;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
