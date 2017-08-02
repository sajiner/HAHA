//
//  XCapitalManageSectionModel.h
//  XH_ZiChanJia
//
//  Created by sajiner on 16/10/10.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCapitalManageSectionModel : NSObject
/*  交易时间 */
@property (nonatomic, copy) NSString *month;
/*  seciotn的所有cell */
@property (nonatomic, strong) NSArray *sublist;

/*  是否展开 */
@property (assign, nonatomic) BOOL fold;

/*  处理后的数据  */
@property (nonatomic, copy) NSString *month0;

@end
