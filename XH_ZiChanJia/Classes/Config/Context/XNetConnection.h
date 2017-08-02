//
//  XNetConnection.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/9/22.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetWorkChanged)(BOOL connect);

/******************************************
 *
 *  检测网络连接类(单例)。
 *
 ******************************************/
@interface XNetConnection : NSObject

/** 网络状态改变的block */
@property (nonatomic, copy) NetWorkChanged netWorkChangedBlock;

/** 获取单例 */
+ (instancetype)sharedNetConnection;

/** 是否连上了wifi */
+ (BOOL)wifi;

/** 是否有网络 */
+ (BOOL)connect;

@end
