//
//  XSanBiaoModel.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/17.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>
//5(开抢) 6（立即投资） 7（投资完成） 8（还款中） 9（已结束）10(已流标)
typedef NS_ENUM(NSInteger,XSanBiaoProjectStatue){
    XSanBiaoProjectStatueStartGrab = 5,
    XSanBiaoProjectStatueInvestment,
    XSanBiaoProjectStatueCompleted,
    XSanBiaoProjectStatueRepayment,
    XSanBiaoProjectStatueEnd,
    XSanBiaoProjectStatueEndPass
};
//5(开抢) 6（立即投资） 7（投资完成） 8(已结束）
typedef NS_ENUM(NSInteger,XAssetStatue){
    XAssetStatueBid = 5,
    XAssetStatueComingSoon,
    XAssetStatueCompleted,
    XAssetStatueFinish,
    XAssetStatueEndPass=10
};

@interface XSanBiaoModel : NSObject
//P_ID用于详情页面
@property (nonatomic,assign)NSInteger p_id;
//项目编号
@property (nonatomic,copy)NSString *p_project_number;
//项目名称
@property (nonatomic,copy)NSString *p_project_name;
//年化收益率
@property (nonatomic,copy)NSString *p_project_rate;
//借款期限
@property (nonatomic,assign)NSInteger p_project_deadline;
//借款金额
@property (nonatomic,assign)CGFloat p_project_money;
//剩余可借金额
@property (nonatomic,assign)CGFloat p_rating_money;
//资产包状态
@property (nonatomic,assign)NSInteger m_project_status;
//开抢时间
@property (nonatomic,copy)NSString *p_start_time;
//已募集金额
@property (nonatomic,assign)CGFloat p_rated_money;

//散标状态码
@property (nonatomic,assign)NSInteger p_project_status;

@end
