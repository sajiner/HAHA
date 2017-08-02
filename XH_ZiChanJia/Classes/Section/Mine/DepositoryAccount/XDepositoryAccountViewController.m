//
//  XDepositoryAccountViewController.m
//  XH_ZiChanJia
//
//  Created by sajiner on 2016/10/19.
//  Copyright © 2016年 资产家. All rights reserved.
//

#import "XDepositoryAccountViewController.h"
#import "XDepositoryAccountView.h"

@interface XDepositoryAccountViewController ()
// 存管账户view
@property (nonatomic, strong) XDepositoryAccountView *depositoryAccountView;

@end

@implementation XDepositoryAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.depositoryAccountView];
}

- (void)dealloc {
    NSLog(@"come here");
}

#pragma mark - lazy
- (XDepositoryAccountView *)depositoryAccountView {
    if (!_depositoryAccountView) {
        _depositoryAccountView = [[XDepositoryAccountView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _depositoryAccountView.backgroundColor = [XAppContext appColors].whiteColor;
        _depositoryAccountView.model = _depositoryAccountModel;
    }
    return _depositoryAccountView;
}

@end
