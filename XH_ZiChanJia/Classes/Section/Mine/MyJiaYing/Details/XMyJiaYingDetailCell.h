//
//  XMyJiaYingDetailCell.h
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/11/16.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMyJiaYingDetailCell;
@protocol XMyJiaYingDetailCellDelegate <NSObject>

- (void)jiaYingDetailCell: (XMyJiaYingDetailCell *)jiaYingDetailCell didClickOfLoanAgreement: (UIButton *)loanAgreementButton linkString: (NSString *)linkString;

@end

@class XMyJiaYingDetailModel;
@interface XMyJiaYingDetailCell : UITableViewCell

@property (nonatomic, weak) id<XMyJiaYingDetailCellDelegate> delegate;
/// 详情model
@property (nonatomic, strong) XMyJiaYingDetailModel *detailModel;

/**  创建cell */
+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
