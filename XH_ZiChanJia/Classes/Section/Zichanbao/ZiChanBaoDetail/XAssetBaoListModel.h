//
//  XAssetBaoListModel.h
//  XH_ZiChanJia
//
//  Created by CC on 2016/11/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XAssetBaoListModel : NSObject

//标的编号
@property (nonatomic,copy)NSString * m_number;

//标的金额
@property (nonatomic,assign)CGFloat m_money;

//可投金额
@property (nonatomic,assign)CGFloat m_rated_money;

//期限
@property (nonatomic,assign)NSInteger m_deadline;

//还款方式(1为等额本息目前只有这一个)
@property (nonatomic,assign)NSInteger m_way;

@end
