//
//  XRequestUrl.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/20.
//  Copyright © 2016年 资产家. All rights reserved.
//

#ifndef XRequestUrl_h
#define XRequestUrl_h

// 开发
#define RequestBaseUrl @"http://10.167.201.170:9090"
// 测试
//#define RequestBaseUrl @"http://10.167.201.176:9090"

/********************************* 温馨提示 *********************************/
#define Request_Reminder [NSString stringWithFormat: @"%@/zcj/front/api/feeback/reminder", RequestBaseUrl]


/********************************* 登录、找回密码、修改密码相关 *********************************/
//登录
#define Request_Login [NSString stringWithFormat: @"%@/zcj/front/login/userLogin", RequestBaseUrl]
//退出
#define Request_Logout [NSString stringWithFormat: @"%@/zcj/front/login/logOut", RequestBaseUrl]
//找回密码--给指定手机号发送手机验证码，注册时的不一样
#define Request_ResetPwd_SendSmsCode [NSString stringWithFormat: @"%@/zcj/front/verification/sendSMSForEditPassword", RequestBaseUrl]
//找回密码--验证短信验证码
#define Request_ResetPwd_VerifiSmsCode [NSString stringWithFormat: @"%@/zcj/front/user/resetPasswordValidate", RequestBaseUrl]
//找回密码--重置密码
#define Request_ResetPwd [NSString stringWithFormat: @"%@/zcj/front/user/resetPasswordPhone", RequestBaseUrl]


/********************************* 注册相关 *********************************/
//验证手机号是否合法
#define Request_Regist_VerifiPhoneNumber [NSString stringWithFormat: @"%@/zcj/front/register/validatePhone", RequestBaseUrl]
//给手机发送短信验证码
#define Request_Regist_SendSMSCode [NSString stringWithFormat: @"%@/zcj/front/verification/sendSMS", RequestBaseUrl]
//给手机发送语音验证码
#define Request_Regist_SendVoiceCode [NSString stringWithFormat: @"%@/zcj/front/verification/sendVoiceSMS", RequestBaseUrl]
//验证短信验证码
#define Request_Regist_VerifiSmsCode [NSString stringWithFormat: @"%@/zcj/front/register/validateSmsCode", RequestBaseUrl]
//验证邀请码
#define Request_Regist_VerifiInviteCode [NSString stringWithFormat: @"%@/zcj/front/register/validateInvitedCode", RequestBaseUrl]
//注册
#define Request_Regist_Register [NSString stringWithFormat: @"%@/zcj/front/register/userRegister", RequestBaseUrl]
//实名认证
#define Request_Regist_VerifiRealName [NSString stringWithFormat: @"%@/zcj/front/verification/verifiRealName", RequestBaseUrl]
//资产家平台服务协议
#define Request_Regist_ServiceProtocol [NSString stringWithFormat:@"%@/html/Platform.html",RequestBaseUrl]


/********************************* 首页相关 *********************************/
//首页信息
#define Request_HomeInfor [NSString stringWithFormat: @"%@/zcj/front/api/information", RequestBaseUrl]
//意见反馈
#define Request_FeedBack [NSString stringWithFormat: @"%@/zcj/front/api/feeback/submit", RequestBaseUrl]
//首页银行存管/备付金/技术安全/资产无忧
#define BackSaveH5 [NSString stringWithFormat:@"%@/html/indexBK.html",RequestBaseUrl]
#define BeiYongJin [NSString stringWithFormat:@"%@/html/indexBY.html",RequestBaseUrl]
#define TechnologySecurity [NSString stringWithFormat:@"%@/html/indexJA.html",RequestBaseUrl]
#define ZiChanWuYou [NSString stringWithFormat:@"%@/html/indexWY.html",RequestBaseUrl]
//首页banner
#define Request_HomeBanner [NSString stringWithFormat: @"http://10.167.201.172/app"]
//菜单-帮助中心
#define HTML_MenuHelpUs [NSString stringWithFormat:@"%@/pxq_app/views/other/help.html",RequestBaseUrl]
//菜单-平台介绍
#define HTML_MenuIntroduce [NSString stringWithFormat:@"%@/pxq_app/views/other/floor_introduce.html",RequestBaseUrl]
//检查APP版本更新
#define Request_CheckVersion [NSString stringWithFormat:@"%@/zcj/front/api/feeback/version",RequestBaseUrl]

/********************************* 我的相关 *********************************/

// 我的页面接口（获取可用余额、资产总额、待收收益、累计收益等数据）
#define Request_UserCenter_UserAsset [NSString stringWithFormat: @"%@/zcj/front/usercenter/userAsset", RequestBaseUrl]
// 我的散标接口（获取待收本金、待收收益、累计收益）
#define Request_UserCenter_UserInMoney [NSString stringWithFormat: @"%@/zcj/front/usercenter/userInMoney", RequestBaseUrl]
// 散标投资纪录接口
#define Request_UserCenter_UserInvest [NSString stringWithFormat: @"%@/zcj/front/usercenter/userInvest", RequestBaseUrl]
// 散标投资纪录详情接口
#define Request_UserCenter_UserReMoney [NSString stringWithFormat: @"%@/zcj/front/usercenter/userReMoney", RequestBaseUrl]
// 我的嘉盈接口（获取待收本金、待收收益、累计收益）
#define Request_UserCenter_UserProject [NSString stringWithFormat: @"%@/zcj/front/usercenter/userProject", RequestBaseUrl]
// 嘉盈投资纪录接口
#define Request_UserCenter_UserProjectInvest [NSString stringWithFormat: @"%@/zcj/front/usercenter/userProjectInvest", RequestBaseUrl]
// 嘉盈投资纪录详情接口
#define Request_UserCenter_UserProjectMark [NSString stringWithFormat: @"%@/zcj/front/usercenter/userProjectMark", RequestBaseUrl]
// 资金管理接口
#define Request_UserCenter_UserAccountLog [NSString stringWithFormat: @"%@/zcj/front/usercenter/userAccountLogApp", RequestBaseUrl]
// 站内消息接口
#define Request_GetNotices [NSString stringWithFormat: @"%@/zcj/front/api/getNotices", RequestBaseUrl]
// 站内消息全部已读接口
#define Request_UpdateNotice [NSString stringWithFormat: @"%@/zcj/front/api/updateNotice", RequestBaseUrl]
// 在线客服接口
#define Request_ChatOnLine @"http://36.7.134.99:8088/chatOnline/business/chatOnline/talk.jsp?bid=1464600656063"


/*********************************散标页相关 *********************************/
//获取散标列表的接口
#define Request_QueryAll [NSString stringWithFormat: @"%@/zcj/front/api/standard/queryall", RequestBaseUrl]
//散标详情页面接口
#define Request_Details [NSString stringWithFormat: @"%@/zcj/front/api/standard/details", RequestBaseUrl]
//投资列表
#define Request_GetInvestmentList [NSString stringWithFormat: @"%@/zcj/front/api/standard/getInvestmentList", RequestBaseUrl]
//还款计划
#define Request_GetRepaymentPlan [NSString stringWithFormat: @"%@/zcj/front/api/standard/getRepaymentPlan", RequestBaseUrl]
//查询散标预期收益
#define Request_GetInvestIncome [NSString stringWithFormat: @"%@/zcj/front/api/invest/getInvestIncome", RequestBaseUrl]
//投资散标
#define Request_InvestMark [NSString stringWithFormat: @"%@/zcj/front/api/invest/investMark", RequestBaseUrl]


/********************************* 资产包（嘉盈）相关 *********************************/
//资产包首页
#define Request_AssetpackageQueryALl [NSString stringWithFormat: @"%@/zcj/front/api/assetPackage/queryall", RequestBaseUrl]
//资产包详情
#define Request_AssetpackageDetail [NSString stringWithFormat: @"%@/zcj/front/api/assetPackage/details", RequestBaseUrl]
//资产包详情中标的详情
#define Request_AssetpackageInfo [NSString stringWithFormat: @"%@/zcj/front/api/assetPackage/info", RequestBaseUrl]
//投资资产包
#define Request_AssetpackageInvestProject [NSString stringWithFormat: @"%@/zcj/front/api/invest/investProject", RequestBaseUrl]
//借款协议
#define Request_loanAgreement [NSString stringWithFormat: @"%@/html/Loanagreement.html", RequestBaseUrl]
//风险揭示书
#define Request_riskDisclosure [NSString stringWithFormat: @"%@/html/Riskbook.html", RequestBaseUrl]

/********************************* 金账户相关 *********************************/
// 统一调用富有api
#define Request_GoldInlet @"http://180.168.100.155:28160/inlet"

// ============================== 与富有交互的api ==================================== //
// 获取开户请求信息
#define Request_GoldAccount_Open [NSString stringWithFormat: @"%@/zcj/front/api/goldaccount/open", RequestBaseUrl]
// 获取提现申请信息
#define Request_DrawCash [NSString stringWithFormat: @"%@/zcj/front/api/cash", RequestBaseUrl]
// 获取充值信息
#define Request_ToppedUp [NSString stringWithFormat: @"%@/zcj/front/api/charge", RequestBaseUrl]
// ============================== 与富有交互的api ==================================== //

// 获取银行卡信息
#define Request_DrawCash_BankCard [NSString stringWithFormat: @"%@/zcj/front/api/cash/bankcard", RequestBaseUrl]
// 获取最新的用户信息(给后台)
#define Request_Recent_Account [NSString stringWithFormat: @"%@/zcj/front/api/account", RequestBaseUrl]
// 用户行为请求接口(给后台)
#define Request_Packet [NSString stringWithFormat: @"%@/zcj/front/api/packet", RequestBaseUrl]

// ============================== 一些 h5 页面 ==================================== //
// 提现请阅
#define Request_cashRead [NSString stringWithFormat: @"%@/html/cashRead.html", RequestBaseUrl]
// 充值请阅
#define Request_chargeRead [NSString stringWithFormat: @"%@/html/chargeRead.html", RequestBaseUrl]
// 风险偏好
#define Request_riskLover [NSString stringWithFormat: @"%@/html/riskLover.html", RequestBaseUrl]



#endif /* XRequestUrl_h */
