//
//  XMyJiaYingModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMyJiaYingModel : NSObject

// 项目名称
@property (nonatomic, copy) NSString *projectname;
// 投资项目ID
@property (nonatomic, copy) NSString *projectid;
// 投资资金
@property (nonatomic, copy) NSString *amount;
// 过往年化收益率
@property (nonatomic, copy) NSString *rate;
// 到期日期
@property (nonatomic, copy) NSString *lastdate;
// 投资状态 (1-投资中，2-回款中，3-已结束)
@property (nonatomic, copy) NSString *investstatus;
// 用户投资记录id
@property (nonatomic, copy) NSString *investid;
// 收益返还方式（0/回款不可复投/1回款可复投）
@property (nonatomic, copy) NSString *backway;
// 项目期限
@property (nonatomic, copy) NSString *projectline;
// 匹配标的笔数
@property (nonatomic, copy) NSString *marknum;
// 包含的复投笔数
@property (nonatomic, copy) NSString *ftnum;
// 待收收益
@property (nonatomic, copy) NSString *predict;

/* 处理后的数据 */
// 投资资金
@property (nonatomic, copy) NSString *amount0;
// 过往年化收益率
@property (nonatomic, copy) NSString *rate0;
// 到期日期
//@property (nonatomic, copy) NSString *lastdate0;
// 项目期限
@property (nonatomic, copy) NSString *projecyline0;
// 匹配标的笔数
@property (nonatomic, copy) NSString *marknum0;
// 收益返还方式（0/回款不可复投/1回款可复投）
@property (nonatomic, copy) NSString *backway0;
// 待收收益
@property (nonatomic, copy) NSString *predict0;

@end
