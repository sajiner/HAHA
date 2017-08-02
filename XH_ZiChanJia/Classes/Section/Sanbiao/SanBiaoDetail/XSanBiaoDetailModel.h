//
//  XSanBiaoDetailModel.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/10/26.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

//散标详情和资产包（嘉盈）详情公用model
@interface XSanBiaoDetailModel : NSObject
//项目名称
@property (nonatomic,copy)NSString *p_project_name;

//项目编号
@property (nonatomic,copy)NSString * m_number;

//年化收益率
@property (nonatomic,assign)CGFloat p_project_rate;

//借款期限
@property (nonatomic,assign)NSInteger p_project_deadline;

//借款金额
@property (nonatomic,assign)CGFloat p_project_money;

//剩余可借金额
@property (nonatomic,assign)CGFloat p_rating_money;

//已募到金额
@property (nonatomic,assign)CGFloat p_rated_money;

//下线时间
@property (nonatomic,copy)NSString *p_inserting_time;

//上线时间
@property (nonatomic,copy)NSString *p_start_time;

//服务器时间
@property (nonatomic,copy)NSString *now;

//项目状态
@property (nonatomic,copy)NSString *p_project_status;

@end


@interface XSanBiaoDetailPersonModel : NSObject

//还款方式(1为等额本息目前只有这一个)
@property (nonatomic,assign)NSInteger m_way;

//借款事由（1 信用贷，2车贷）
@property (nonatomic,copy)NSString * m_borrow_type;

//借款金额
@property (nonatomic,assign)CGFloat d_give_money;

//借款期限
@property (nonatomic,copy)NSString * d_debt_period;

//信用级别
@property (nonatomic,copy)NSString * d_rate_result;

//姓名
@property (nonatomic,copy)NSString * d_debtors_name;

//性别c_sex
@property (nonatomic,copy)NSString * p_sex;

//年龄
@property (nonatomic,assign)NSInteger age;

//学历
@property (nonatomic,copy)NSString * p_education;

//婚姻状况
@property (nonatomic,copy)NSString * p_marriage_case;

//现居住地
@property (nonatomic,copy)NSString * p_live_address;

@end

