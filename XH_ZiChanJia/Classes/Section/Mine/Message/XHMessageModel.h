//
//  XHMessageModel.h
//  XinHe_JinRong
//
//  Created by sajiner on 16/7/25.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHMessageModel : NSObject

@property (nonatomic, copy) NSString *content;  // 内容

@property (nonatomic, assign) NSInteger status; // 0未读、1已读、-1全部

@property (nonatomic, strong) NSDictionary *time;  // 发送时间

@property (nonatomic, assign) NSInteger messageId; // 消息id

// 处理后的时间
@property (nonatomic, copy) NSString *sendTime;

@end
